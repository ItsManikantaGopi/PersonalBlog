---
title: 'sidekiq-assured-jobs: not losing the job when the worker dies'
summary: A Ruby gem that tracks in-flight Sidekiq jobs and re-enqueues whatever a killed worker was holding. Written because Kubernetes evicts pods and Sidekiq, by design, does not remember what it lost.
date: '2025-07-03'
period: '2025'
role: Author, published as a gem
featured: true
weight: 80
tags: ['open source', 'ruby', 'reliability']
stack: ['Ruby', 'Sidekiq', 'Redis', 'RSpec']
links:
  - label: 'github.com/praja/sidekiq-assured-jobs'
    href: 'https://github.com/praja/sidekiq-assured-jobs'
---

Sidekiq has a well-documented gap. When a worker process exits cleanly it finishes what it is holding, or pushes it back. When a worker is killed — `SIGKILL`, an OOM kill, a node that goes away — the jobs it had fetched are simply gone. They are not in the queue, because they were fetched. They are not in the retry set, because nothing raised. They are not anywhere.

For most jobs this is survivable. For the ones that raise a payment, or send a one-time notification, or advance a state machine, it is not.

## Why this became a real problem

Running Sidekiq on Kubernetes turns a rare event into a routine one. Pods get evicted during node consolidation. Deployments roll. Spot capacity is reclaimed. Memory limits are enforced by the kernel, and the kernel does not send `SIGTERM`.

Every one of those is a `SIGKILL` to a process that was midway through a batch of work. We were losing jobs on a schedule, and the loss was invisible — no error, no retry, no alert. Just a user whose poster never generated, discovered days later from a support ticket.

The standard answers didn't fit:

- **Sidekiq Pro's reliable fetch** uses a `RPOPLPUSH` working list, which is the right shape, but it was a licensing decision we weren't ready to make at the time, and it doesn't cover jobs already handed to a thread.
- **Making every job idempotent and retryable from a cron sweep** is the correct long-term answer, and we did it for the most critical flows. It's also a per-job engineering cost that scales with the number of workers — we had over 200.

What I wanted was something that worked at the middleware layer, once, for every job that opted in.

## The design

Three moving parts, all in the Redis connection Sidekiq already has.

**A heartbeat.** Each worker process registers an instance key and refreshes it on an interval. If the key expires, that instance is dead — not slow, dead, because a live process refreshes it.

**Job tracking.** A server middleware records the job's payload under the instance's tracking set before `yield`, and removes it after. So at any moment, the set for a given instance is exactly the work that instance is holding.

**Orphan recovery.** On startup, a worker looks for tracking sets whose instance heartbeat is gone, and re-enqueues their contents.

```ruby
class MyCriticalWorker
  include Sidekiq::Worker
  include Sidekiq::AssuredJobs::Worker   # opt in

  def perform(charge_id)
    # If the pod dies here, this comes back.
  end
end
```

The recovery pass is the part that needed care.

## The parts that were harder than they looked

### Recovery has to be exclusive

If three pods start at once — which is exactly what a rolling deploy does — all three see the same orphaned set and all three re-enqueue it. One lost job becomes three duplicated ones, which for a payment worker is considerably worse than the original bug.

Recovery takes a distributed lock in Redis, with a TTL longer than the recovery pass and shorter than the interval between passes. Whoever gets the lock recovers; the others move on.

### Dead and starting-up look identical

A process that has registered its heartbeat but not yet begun processing has an empty tracking set and a fresh key. A process killed one second after registering has an empty tracking set and a key that is about to expire. The heartbeat TTL has to be comfortably longer than the refresh interval, or a slow-to-schedule pod gets declared dead by its own colleagues while it is still booting.

The defaults are a 15-second refresh against a TTL several multiples of that. Generous, because the cost of waiting a little longer to recover a job is much lower than the cost of recovering a job that was never lost.

### One pass is not always enough

A node failure can take several workers at once, and the recovery lock means they are processed by whoever happens to be up. If the recovering process is itself killed mid-pass, some orphans stay orphaned.

So recovery is configurable to run additional delayed passes after startup, rather than exactly once. This was the change in the gem's second release, and it came directly from watching a real node failure only half-recover.

## What it is not

It is not exactly-once delivery. There is no such thing over a network and a process boundary. A job can be re-enqueued after it had already completed its side effects but before the middleware removed it from the tracking set — a window of microseconds, but real.

**Jobs still have to be idempotent.** What the gem changes is the failure mode: from *silently lost* to *possibly run twice*. The second is a problem you can solve in the job with an idempotency key. The first is a problem you cannot solve at all, because you don't know it happened.

That framing is the actual value. It converts an invisible, unfixable failure into a visible, fixable one.

## Outcome

Adopted for the payment, notification and media-generation workers in the Rails monolith — the flows where a lost job produces a support ticket. It ships with a Sidekiq web dashboard extension for inspecting orphans, because the first question anyone asked was "is it doing anything?" and the honest answer needed a screen rather than a log line.

The gem is public, versioned, and documented well enough that someone else can decide whether they have this problem.
