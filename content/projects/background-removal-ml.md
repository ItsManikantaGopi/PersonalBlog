---
title: Replacing a vendor vision API with a self-hosted GPU service
summary: Background removal moved from a per-call cloud API to an ONNX model on GPU nodes in our own cluster. Then a face-detector swap that I validated against 200 real production images before shipping — and the numbers changed what we shipped.
date: '2026-02-25'
period: '2025 – 2026'
role: Built and validated the service
featured: true
weight: 60
tags: ['machine learning', 'infrastructure', 'evaluation']
stack: ['Python', 'ONNX Runtime', 'Flask', 'Gunicorn', 'OpenCV', 'Kubernetes', 'BiRefNet', 'SCRFD']
---

Every poster starts with a photograph that needs its background removed. At the volumes we generate, that operation is a line item — and originally it was a per-call charge to a cloud vision API.

This is the story of bringing it in-house, and then of a change I nearly shipped without measuring properly.

## Part one: getting off the vendor API

The original implementation called Azure Computer Vision. It worked. It also meant per-call pricing on our single highest-volume image operation, a network round trip in the middle of a latency-sensitive path, and no ability to tune quality for our specific input distribution — which is not "arbitrary photographs" but "portraits, often shot on mid-range phones, often against cluttered indoor backgrounds."

The replacement is a Python service running a segmentation model under **ONNX Runtime on GPU**, served by Flask behind Gunicorn, deployed to GPU-tainted nodes in the Kubernetes cluster.

Getting there took most of a year and several false starts, visible in the repository as closed pull requests:

- Started with an off-the-shelf background-removal package, then moved to calling the underlying model directly for control over pre- and post-processing.
- Tried a route that mounted model weights from S3 at pod start rather than baking them into the image. Abandoned: it traded image size for startup latency and a network dependency at the worst possible moment.
- Tried removing MediaPipe from the pipeline for a lighter dependency graph. Closed unmerged.
- Landed on **ONNX Runtime GPU** with the model baked into the image, which is larger to pull and simpler to reason about. Pod startup is deterministic and there is no runtime dependency on object storage.
- Fine-tuned **BiRefNet** on our own data for the portrait case specifically.

The infrastructure side had its own lessons. GPU nodes are expensive and must not sit idle, so the deployment scales to zero replicas when there is no work and Karpenter provisions GPU capacity on demand. A recurring pattern in the fleet repository is enabling and disabling these replicas around demand periods — including the preprod GPU pods, which have no business being warm overnight.

## Part two: the face-detector swap, and why measurement changed the outcome

This is the part I'd actually want to be judged on.

The service does more than segment. If the photo contains exactly one face, it crops to a standardised portrait frame; otherwise it returns the full frame. That `face_count == 1` gate is the interesting logic, and it depended on **dlib** for detection.

We had reasons to move to **SCRFD** — a more modern detector, better on the hard cases dlib misses. The change is small: swap the detector, keep everything else.

The obvious way to ship it is to eyeball a dozen images, agree they look fine, and merge. I've done that before. Instead I built a comparison against **200 real production images**, pulling the actual stored production outputs — not reproductions — and generating new outputs from a preprod pod running the change.

### The methodology

Details that mattered:

- **Real production outputs**, read from where production wrote them. A reproduction of what the old code *would* do is not evidence about what it *did*.
- **Composited on a grey checkerboard.** This one is easy to get wrong: many subjects wear white shirts. On a white page you cannot distinguish a white shirt from a removed background, and a whole class of error becomes invisible.
- **Mask IoU** between old and new subject masks, as the quantitative measure of framing agreement.
- **Every per-image number written out** to CSV and JSON, so the summary could be checked rather than trusted.

### What it found

| Metric | Value |
|---|---|
| Images compared | 200 |
| Same crop decision | 184 / 200 (92%) |
| **Crop decision flipped** | **16 / 200 (8%)** |
| Subject-mask IoU, median | 0.9952 |
| IoU p10 / min | 0.856 / 0.618 |
| Essentially identical (IoU > 0.99) | 95 / 184 |
| Latency p50 / p90 | 384ms / 885ms |

The headline number — median IoU of 0.9952, with 95 of 184 images essentially pixel-identical — says the new detector produces nearly the same framing. That was the result I expected, and on its own it reads as "ship it."

**The 8% was the actual finding, and it wasn't about framing at all.**

SCRFD is *better* at finding faces. On images with a second partially-visible face — a bystander, someone in a photograph on the wall behind the subject — SCRFD finds it and dlib doesn't. Which means `face_count == 1` stops being true, the crop gate doesn't fire, and the image comes back **full-frame instead of cropped**.

That is a far larger visual change than any shift in crop box. The user uploads a portrait and gets an uncropped photo on their poster. And it is caused by the detector being *more* accurate.

A better model made the product worse, because the product logic assumed the old model's blind spots.

### What that changed

The fix isn't the detector; it's the gate. Counting faces and requiring exactly one was always a proxy for "is this a portrait of one person" — and it only worked because dlib under-counted in a way that happened to suit us. A better detector needs a gate expressed in terms of the *dominant* subject rather than a raw count.

I would not have found this with spot checks. The 16 flips are 8% of the sample — you can look at a dozen images and see none of them, conclude the change is safe, and ship a regression to one in twelve users.

## What I take from this

**Aggregate metrics can hide the failure mode.** Median IoU 0.9952 is an excellent number and it was measuring the wrong thing. The regression lived in a categorical decision that IoU doesn't capture, and it only became visible because the comparison also tracked the crop decision.

**A model upgrade is a change to every downstream assumption.** Any threshold tuned against the old model's behaviour is now untested. The detector swap was one line; its blast radius was the entire cropping logic.

**Visualise against the adversarial background.** The checkerboard decision was worth as much as any metric in the table. Choosing a background that makes errors visible rather than pretty is a design decision about the evaluation itself.

**Write the numbers down per-item.** The summary table is derived. Having the per-image CSV meant that when the 8% showed up, I could go straight to those 16 images and find the mechanism instead of speculating about it.
