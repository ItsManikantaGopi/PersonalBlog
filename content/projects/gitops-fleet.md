---
title: Running a 24-service fleet from a Git repository
summary: Helm charts, per-environment values and automated image bumps describing every service on the production Kubernetes cluster. ~380 pull requests, most of them small, deliberately.
date: '2026-04-08'
period: '2024 – present'
role: Owner
featured: true
weight: 20
tags: ['infrastructure', 'kubernetes', 'gitops']
stack: ['Kubernetes', 'Helm', 'Flux', 'ArgoCD', 'KEDA', 'Karpenter', 'AWS EKS']
---

One repository describes what runs in production. Around 24 services on the primary AWS cluster, plus preprod and two numbered pre-production environments, each as a Helm chart with environment-specific values. Nothing reaches the cluster except by a merge to that repository.

I have roughly 380 pull requests and 460 commits here — more than any other repository I work in, and the individual diffs are tiny. That ratio is the point.

## Why the diffs are small

A GitOps repository is a log of every intentional change to production, and it is only useful as a log if the entries are atomic.

"Update the video processing service chart to 0.1.28 and adjust the memory utilisation target" is a complete, revertible thought. When it turns out that memory target was wrong, the fix is `git revert` and a merge — no console, no `kubectl edit`, no divergence between what the cluster is doing and what the repository says it is doing.

This is also why there are 88 reverts across my pull-request history and why I don't consider that a defect. A revert in a GitOps repository is not an admission of failure; it is the mechanism working.

## What lives in the repository

```
clusters/aws/
├── ror-api/                 # Rails API — production
├── ror-api-preprod/
├── ror-api-pp1/             # numbered pre-production environments
├── ror-api-pp2/
├── sidekiq/                 # background workers, separate scaling
├── messaging-service/
├── garuda-api/              # notification dispatch
├── garuda-workers/
├── video-processing-service/
├── poster-campaign-service/
├── background-removal/      # GPU-scheduled ML service
├── media-service/
├── image-processor/
├── jathara/                 # internal admin tooling
├── praja-web/
└── ...
```

Each directory is a chart with its own values. The API and its Sidekiq workers are separate deployments because they scale on entirely different signals — one on request rate, the other on queue depth — and coupling them would mean scaling the wrong thing.

## The automation that matters

The part that makes this maintainable rather than tedious: **image tags are bumped by a workflow, not by hand.**

When a service's CI builds an image, a workflow opens a pull request against this repository updating that service's tag. A human reviews and merges. The commit message is literally `Update image of [aws] video-processing-service to <sha>`.

Two properties fall out of that:

- **The deploy is the merge.** There is no separate deploy step to forget, and no way to deploy something that isn't recorded.
- **A rollback is a revert of a known-good commit,** not an archaeology exercise in a CI dashboard.

## Autoscaling on the right signal

The most consequential design decision in the fleet is what each service scales on.

CPU-based HPA is the default and it is wrong for most of what we run. A worker pulling from a Redis queue is not CPU-bound while it waits, so CPU utilisation lags the actual backlog badly — you scale up after the queue is deep and scale down while it is still draining.

We use **KEDA with Redis queue depth** as the scaler for the queue-driven services: video processing, poster generation, campaign generation. The signal is the thing you actually care about — how much work is waiting — so scale-up leads the backlog instead of trailing it.

Getting this right took several iterations, visible as a run of PRs adjusting scaling metrics on consecutive days. Two lessons:

- **The scaler key has to be exactly right.** A typo in the Redis key means KEDA reads a queue that is always empty, the deployment sits at minimum replicas, and nothing appears broken until the backlog is enormous. This bit us once and is now the first thing I check.
- **Minimum replicas are a latency decision.** Scaling from zero is free but the first request pays a cold start. For interactive paths we hold a floor; for batch paths we let it hit zero.

**Karpenter** handles nodes underneath, including spot capacity, so a scale-up isn't gated on a pre-provisioned node pool.

## Seasonal capacity

This platform has an unusual and useful property: its traffic peaks are on the calendar. Festival days produce sharp, predictable spikes — an order of magnitude over baseline, on a known date.

So capacity planning is a scheduled activity rather than a reactive one. Before each major festival there is a deliberate upgrade — larger node capacity, raised replica floors, database instance class bumped, scaling thresholds loosened — and afterwards a deliberate scale-down. Those changes appear in the repository named after the festivals they were for.

Two things make this work:

**The scale-down is as planned as the scale-up.** The expensive failure mode isn't under-provisioning for the peak; it's staying provisioned for a peak that ended a week ago. Every upgrade PR has a matching revert.

**Rehearsed, not improvised.** By the third or fourth cycle this was a known sequence of changes with known outcomes, which is a much better position than a war room.

## Supporting infrastructure

The cluster's own components are managed as Terraform alongside the application charts: cert-manager for certificates, the AWS load balancer controller, APISIX at the gateway, Loki and Grafana Alloy for logs, Prometheus for metrics, Velero for backup, ArgoCD and Flux for reconciliation, KEDA and Karpenter for scaling.

Velero is worth a specific note, because a backup you have never restored is a hypothesis. One of the more instructive bugs I fixed was a Redis backup failing due to a race with `BGSAVE` — the backup was running, reporting success, and producing an inconsistent snapshot. Alerting on backup *failure* is necessary and insufficient; you also need alerts on backups that succeed suspiciously.

## What this buys

The honest summary: the cluster state is knowable. When someone asks why a service is behaving differently than last week, the answer is `git log` on a directory. When something needs undoing, it undoes cleanly. When a new environment is needed, it is a directory copy with different values — which is exactly how the two numbered pre-production environments came into being, in an afternoon.

That is not a glamorous outcome. It is the one that makes everything else possible.
