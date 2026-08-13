---
title: Moving production from Azure to AWS, service by service
summary: A live migration of a social platform's workload from AKS to EKS — Terraform for the new estate, one service at a time, DNS and CDN last, then a deliberate decommission. No maintenance window.
date: '2025-05-12'
period: '2024 – 2025'
role: Led the migration
featured: true
weight: 50
tags: ['infrastructure', 'migration', 'terraform']
stack: ['Terraform', 'AWS EKS', 'Azure AKS', 'GCP', 'CloudFront', 'Route 53', 'Kubernetes']
---

The platform ran on Azure — AKS for compute, Azure Media Services for video, Azure Computer Vision for image processing, Azure CDN. Over roughly a year it moved to AWS, while serving traffic throughout. I led that work.

## Why move at all

Not for the reason people assume. It wasn't a vendor grudge; it was that our workload had grown into a shape Azure was serving expensively and awkwardly for us:

- **GPU capacity** for the background-removal model was easier to obtain, schedule and autoscale on AWS at the time.
- **Media pipeline economics.** We were paying per-minute vendor pricing for video transcoding and per-call pricing for image background removal. Both were candidates for self-hosting, and the self-hosted versions needed Kubernetes-native GPU scheduling.
- **Consolidation.** We already had AWS in the estate for Lambda, S3 and CloudFront. Running two clouds meant two networking models, two IAM models, two monitoring integrations and two on-call runbooks.

The decision was less "AWS is better" and more "one cloud is better than one and a half."

## The approach: strangle, don't lift

There was no cutover date and no maintenance window. The migration worked service by service, and each service followed the same sequence:

1. **Build the target in Terraform.** Not by hand. If it wasn't in code it didn't exist.
2. **Deploy to EKS alongside the running AKS version.** Both live, both healthy.
3. **Point preprod at the new one first,** for as long as it took to be boring.
4. **Move production DNS.** The reversible step.
5. **Watch, with the old one still running.**
6. **Remove the AKS deployment.** Only after step 5 stopped being interesting.
7. **Delete the Azure resources.** Separately, later, deliberately.

Steps 6 and 7 being distinct matters. Removing the pods from the old cluster is cheap and reversible. Deleting the underlying resources is neither. Keeping them apart meant a bad surprise on day three was a DNS change away from being fixed.

The repository history shows this rhythm plainly: `moving praja-web to eks`, then `Chore: praja web dns change to aws`, then `Removing praja web deployment on azure`, then weeks later `cleaning/azure resources`. Four commits, four different risk levels.

## What actually went wrong

The interesting part of any migration.

### Ingress and health checks

The single most fiddly area. A run of consecutive PRs deals with ingress schema, HTTPS on liveness checks, and preprod annotations — because the two clusters' ingress controllers disagreed about defaults in ways that only surfaced under real traffic.

Specifically: liveness probes that worked over HTTP on AKS needed HTTPS on the new setup, and the health check failing meant the pod never became ready, which meant the Service had no endpoints, which presented as a 503 with no obvious cause. The fix is two lines. Finding it was an afternoon.

### Domains multiply

The platform accumulated domains over years, and every one of them was load-bearing for some client version still in the wild. The ingress had to accept several hostnames simultaneously, then keep accepting the old ones after the move, because you cannot force an app upgrade on users.

There's a PR titled `chore: Adding support for old domains in IP in eks` and it exists because a regex match in an ingress rule was quietly dropping a legacy hostname.

### CDN cutover is a cache problem

Moving from Azure CDN to CloudFront isn't a DNS change; it's a DNS change plus a cache with a long memory. Two specific issues:

- **Origin redirection.** A `g-cdn` domain that was supposed to serve from GCS was resolving to an AWS bucket, and vice versa for `az-cdn`. Three consecutive PRs to fix bucket redirection, which is what happens when three CDNs coexist during a transition.
- **Content-Length and compression.** Compression had to be disabled for certain image responses so a `Content-Length` header would be present — some clients needed it, and the compressed response didn't have it.

### CI has to move too

The build and deploy pipelines were tied to the old cluster: self-hosted runners, registry authentication, deployment targets. Every application repository needed its workflows migrated, and for a period each one had both an AKS and an EKS workflow with one disabled — the same alongside-then-remove pattern, applied to CI.

We also moved to **ARC runners on EKS**, so CI capacity came from the same cluster and the same autoscaling as everything else.

## What we kept on other clouds

The end state isn't purist, deliberately.

**GCP stayed** for video transcoding and some storage. Cloud Video Transcoder was a good fit and there was no compelling reason to move it — the multi-cloud configuration in the image processor and media service is intentional, not residual.

**Azure was fully decommissioned.** Media Services and Computer Vision were replaced by self-hosted equivalents; the AKS cluster and its resources were removed in stages.

The principle I'd defend: **consolidate the control plane, not necessarily every workload.** Having one Kubernetes cluster, one IAM model and one monitoring story is where the operational saving is. A managed transcoding service that works well on another cloud is not costing you the same complexity.

## What I'd tell someone starting one

**Terraform the target before you touch anything.** The temptation to click something into existence "just to test" is real and it produces resources nobody can account for six months later.

**Make DNS the switch.** If your cutover mechanism is a DNS record, your rollback is a DNS record. Anything where the rollback is materially harder than the rollout will eventually trap you.

**Separate "stop using it" from "delete it".** Different days, different PRs, different risk. This is the advice I'd give if I could only give one.

**Preprod for longer than feels necessary.** Every problem above surfaced under real traffic patterns rather than synthetic ones. Preprod's job is to make the boring outcome boring; it can't do that in an afternoon.
