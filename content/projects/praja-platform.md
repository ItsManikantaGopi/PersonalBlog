---
title: The Rails monolith at the centre of a social platform
summary: 185 models, 211 background workers and roughly 28 Sidekiq queues serving a regional social network. Four years of feature work, performance work, and the slow discipline of keeping a large monolith habitable.
date: '2026-04-01'
period: '2022 – present'
role: Core backend engineer
featured: true
weight: 10
tags: ['backend', 'rails', 'scale']
stack: ['Ruby on Rails', 'MySQL', 'Redis', 'Sidekiq', 'OpenSearch', 'Docker']
---

Praja is a regional social platform — feeds, circles, messaging, and a paid tier built around personalised political posters. The centre of it is a Ruby on Rails API that has been running and growing since well before I joined. Most of my ~470 pull requests to it are in service of one idea: a monolith is not a problem to be escaped, it is a system to be kept legible.

## What it actually is

Some numbers, because "large Rails app" means nothing on its own:

| | |
|---|---|
| ActiveRecord models | 185 |
| Sidekiq worker classes | 211 |
| Named queues in production | ~28, weighted |
| Primary store | MySQL |
| Search | OpenSearch |
| Cache, queues, locks, rate limits | Redis |

The queue list is the most informative thing about the system. `payments`, `send_otp`, `dm_notifications` and `critical` carry the highest weights; `video_posters_generation`, `campaign_poster_generation` and `pose_generation` handle the media pipeline; `posts_indexing` and `hashtags_indexing` feed search; `event_tracking` and lead-scoring queues feed the analytics and CRM side.

That shape tells you the real architectural fact about this application: **it is mostly asynchronous.** The HTTP layer is comparatively thin. The interesting behaviour, the expensive behaviour, and most of the failure modes live in background jobs.

## Where I spent my time

### Queue weighting as a reliability tool

The single highest-leverage lever in a Sidekiq deployment is which queue a job sits in, and almost nobody treats it as a design decision.

We learned this the direct way. Poster generation is bursty and slow — it composites images and renders video. When those jobs shared queue capacity with payments, a generation burst would starve charge processing. Not break it; delay it. Delayed charges look like failed charges to a scheduler with a deadline.

A recurring class of change in my PR history is moving a specific worker to a specific queue: event tracking to `default`, video poster generation to `low` during cron-driven bulk runs, payment-gateway submission to `payments`. Each one is a small diff and each one came from watching a latency graph.

The general rule I ended up with: **queues should be separated by the consequence of delay, not by subject matter.** A notification and a payment are both "user-facing", but one can wait ten minutes and the other cannot.

### Subscription and payment correctness

The paid tier meant building the full subscription lifecycle: charge scheduling, grace periods, cancellation and downgrade flows, plan extensions offered as a cancellation save, and partial refunds.

The hard part was never the happy path. It was the payment gateway, which is an untrusted, unordered, at-least-once event source:

- **Duplicate callbacks.** The same charge confirmation arrives twice. Without an idempotency guard you have double-credited a subscription or double-refunded a user. We added a uniqueness constraint at the database level for plan logs, plus explicit duplicate-handling on the auth-payment callback path — and an alert that fires when two charges are raised for the same user, because the guard should never actually be needed and it's worth knowing when it is.
- **Late callbacks.** A confirmation arrives after we'd already given up and scheduled the next charge date. Next-charge computation had to become a function of the gateway's timeline rather than ours.
- **Declines that look like silence.** A declined auth charge needed to be handled as an event, not an absence.

None of this is glamorous. All of it is the difference between a billing system and a billing incident.

### Making the test suite fast enough to trust

The suite had grown to the point where the feedback loop discouraged running it. A slow suite doesn't just cost time; it changes behaviour, because people stop waiting for it.

I moved testing from GitHub Actions to CircleCI with **timing-based test splitting across parallel containers** — each container gets a slice balanced by historical duration rather than filename, so all of them finish at roughly the same time. Coverage reports from the parallel runs are combined afterwards so the number still means something.

This took two attempts. The first parallelisation had to be reverted, then redone once the coverage merge and the timing data were right. That sequence is in the commit history and I'd rather it were: the revert is the honest part.

### Performance work, specifically

Recurring themes, each one traceable to a New Relic trace:

- **Response-time reduction through CDN and compression.** Static and media responses moved behind CloudFront with gzip; the win was in the region of 200ms on affected endpoints. One caveat we hit: compression had to be disabled for some image responses so a `Content-Length` header could be sent, which some clients needed.
- **Query optimisation on hot endpoints.** The poster page and poster-photos APIs were the worst offenders — N+1s and unbounded result sets. Optimising them was mostly about eager loading and pagination, which is unexciting and is usually the answer.
- **Connection-pool sizing.** Both Redis and the database pool were misconfigured relative to Sidekiq's concurrency — a classic mismatch that shows up as intermittent timeouts under load rather than as an obvious error.
- **Custom instrumentation.** Adding `user_id` to New Relic traces and custom instrumentation to the feed path, so that "the feed is slow" could become "the feed is slow for users with this characteristic".

## What I'd tell someone inheriting it

Three things I believe more strongly after four years than before:

**The queue configuration is architecture.** It's in a YAML file that looks like configuration, and it determines your failure modes under load more than most of your code does.

**A revert is a feature.** There are 88 reverts across my pull requests on this platform. Being able to undo a change in one merge — because deploys are automated and the change was small enough to isolate — is worth more than being right the first time.

**Instrument before you optimise, every time.** Every performance change above started with a trace showing where the time went. The ones I've seen go wrong elsewhere started with someone's intuition about where it went.
