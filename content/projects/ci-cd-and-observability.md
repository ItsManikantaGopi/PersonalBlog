---
title: The release path, and knowing when it broke
summary: Moving CI to CircleCI with timing-based test splitting, running build capacity on our own cluster, and the instrumentation and backup work that makes production legible. The unglamorous half of the job.
date: '2026-02-12'
period: '2024 – present'
role: Owner
tags: ['infrastructure', 'ci/cd', 'observability']
stack: ['CircleCI', 'GitHub Actions', 'New Relic', 'Prometheus', 'Grafana', 'Loki', 'Velero', 'Honeybadger']
---

Two things nobody asks for in a roadmap and everybody notices the absence of: a release path you trust, and enough instrumentation to answer "what is happening right now."

Around 120 of my pull requests touch CI/CD and another 120 touch observability. This is what that was for.

## The release path

### Why we left GitHub Actions

Not because it's bad. Because our test suite had outgrown how we were using it.

The Rails suite is large — 185 models with corresponding specs, request specs, worker specs. Run serially it was slow enough that people stopped waiting for it, which is the failure mode that matters. A test suite nobody waits for is a test suite that isn't protecting you.

We moved tests and deployments to **CircleCI**, and the specific reason was **timing-based test splitting**. Splitting by filename gives you containers that finish at wildly different times, so your wall-clock is the slowest arbitrary slice. Splitting by historical timing balances them, so total time approaches the ideal division. This needs the JUnit formatter emitting timing data that CircleCI stores between runs, and coverage reports from the parallel containers combined afterwards so the coverage number still means something.

It took two attempts. The first parallelisation was merged and reverted within days, then redone once the coverage merge was right. Both are in the history.

Deployments followed the tests — production, preprod, and the two numbered pre-production environments — so that the thing which gates a release and the thing which performs it live in the same system.

### Build capacity on our own cluster

CI runners moved to **ARC runners on EKS**, which means build capacity comes from the same cluster, the same node autoscaling and the same spot capacity as production workloads. One capacity model instead of two.

The side effect I didn't anticipate: CI became subject to the same observability as everything else. A slow build is a pod with metrics.

### Small things that mattered disproportionately

- **Removing media uploads from the test suite.** Tests were writing real objects to real buckets. This is slow, costs money, and pollutes storage with test artefacts. There's a PR titled `Fix: media being uploaded to s3 from tests` that was closed and superseded by properly removing the access, which is the better fix: if the credentials aren't there, the mistake can't recur.
- **Deploy notifications that are readable.** Several PRs fix Slack deployment messages — a stray `*` breaking the formatting, a missing commit SHA. A deploy notification that doesn't say *what* was deployed is decoration. Adding the commit ID meant the message became usable during an incident.
- **PR title and branch naming enforced in CI.** Requiring a ticket ID and a non-empty description sounds bureaucratic. It's what makes the commit history searchable two years later, which is the only reason I could write these case studies.
- **Concurrency keys on workflows**, so a rapid series of pushes doesn't leave three deploys racing.

## Knowing when it broke

### Instrumentation you add on purpose

Default APM tells you an endpoint is slow. It rarely tells you why, and for anything asynchronous it barely tells you anything.

The additions that paid off:

**User attribution in traces.** Adding `user_id` as a custom attribute to New Relic traces changed the class of question we could answer. "The feed is slow" is unactionable. "The feed is slow for users with a large number of circle memberships" is a query plan problem you can go and fix.

**Custom instrumentation on the feed path.** The most-hit and most-complex read path in the application, and the one where the aggregate number hid the distribution.

**Excluding request parameters from custom attributes.** The other direction, and important: we had been attaching request params to traces, which meant potentially sensitive values in a third-party monitoring system. Removing that was a small PR and the right call.

**Honeybadger alongside New Relic,** with user attribution, across the Rails app, the Node services and the Go service. APM and error tracking answer different questions and the overlap is worth the cost.

### Alerts that come from incidents

Every alert worth having was written after something happened. A partial list, each one traceable to a bad day:

- **Duplicate charges for the same user.** There are database-level guards against this. The alert exists because a guard that silently saves you is a guard you don't know is load-bearing.
- **OpenSearch disk usage,** via Prometheus, after a disk filled. The alert and a disk resize shipped together.
- **Velero backup failures,** because a backup system that fails quietly is worse than no backup system — it produces false confidence.
- **Video generation pipeline errors,** specifically, separate from generic error rates, because a pipeline failing for one template doesn't move an aggregate error rate enough to notice.

### Backups, and the one that lied

The most useful reliability bug I've fixed: **a Redis backup failing due to a race with `BGSAVE`.** Velero was snapshotting while Redis was mid-save. The backup completed. It reported success. The snapshot was inconsistent.

This is the worst category of failure — not an outage, but a false negative on your recovery plan. You find out during a restore, which is the moment you least want to be finding things out.

Which led to the rule I now apply generally: **alert on backups that succeed suspiciously, not just on backups that fail.** Duration, size and consistency, not just exit code.

### Cost as a signal

**OpenCost** in the cluster, giving per-namespace cost attribution. This turned out to be an observability tool more than a finance one. A service whose cost jumps without a corresponding traffic change is telling you something — a retry loop, a leak, a scaler stuck at maximum. Cost is a lagging indicator of a lot of bugs.

## The pattern

Reading these back, nearly every item follows the same shape: something broke in a way that was invisible, and the fix was making that class of failure visible in future. Not preventing it — making it observable.

I've come to think that's the actual deliverable of this kind of work. You cannot prevent the failure you haven't imagined. You can make sure that when it happens, it is loud.
