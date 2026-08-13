---
title: A Go notification service for fan-out at population scale
summary: Targeting users by district, state, party and circle, then dispatching push notifications through FCM without touching the main API's request path. Gin, GORM, Asynq and Redis.
date: '2026-04-02'
period: '2024 – present'
role: Backend engineer
tags: ['backend', 'go', 'notifications']
stack: ['Go', 'Gin', 'GORM', 'Asynq', 'Redis', 'MySQL', 'Firebase FCM']
---

Garuda is the notification dispatch service for the Praja platform. A political social network's notifications are unusual in shape: they are frequently geographic and demographic rather than social. "Everyone in this district", "everyone affiliated with this party", "everyone in this circle" — not "the people who follow you."

That makes fan-out a query problem before it's a delivery problem.

## Why a separate service in a different language

The main API is Ruby on Rails, and the natural instinct is to put this there. Two reasons not to:

**The audience query is expensive and unbounded.** Resolving "everyone in this state with this party affiliation" can return an enormous set. Doing that in a request thread of the main API, or even in its Sidekiq workers, means a notification campaign competes with user-facing work for the same capacity — the queue-starvation problem I've hit repeatedly on this platform.

**Dispatch is embarrassingly concurrent and Ruby is not.** The work is a very large number of independent, IO-bound FCM calls. Go's concurrency model fits this precisely; a Ruby process does not, and the workaround is more processes, which is more memory for the same throughput.

So: a Go service with its own API and its own worker binary, reading the same MySQL database for user targeting, with Redis carrying the job queue.

| Rails concept | Garuda equivalent |
|---|---|
| Rails / Sinatra | Gin |
| ActiveRecord | GORM |
| Sidekiq | Asynq |
| Separate Sidekiq process | Separate worker binary |
| `config/routes.rb` | routes declared in the app entrypoint |

The repository has an architecture document written specifically for engineers arriving from Ruby, with that mapping and Go idioms explained in Rails terms. Writing it was worth more than it cost: the service is otherwise a place where the rest of the team can't help.

## The interesting problems

### Device tokens are the actual data model

The obvious model is "notify a user." The real unit is a device — a user may have several, tokens expire, get replaced on reinstall, and go stale silently. FCM will accept a dead token and report success.

A refactor I made was moving app OS and version onto a `UserDevice` model and deprecating those fields on the token record, because the token is the ephemeral thing and the device is the durable one. Attributes about the device were living on the wrong object, which meant they were lost whenever a token rotated.

### Delivery statistics are the only feedback loop

You cannot observe a push notification arriving. There is no acknowledgement from a phone that a user saw something. So the service tracks dispatch statistics, and those numbers are the only signal distinguishing "we sent 400,000 notifications" from "we sent 400,000 notifications to dead tokens."

Per-state logging was added specifically so campaigns could be diagnosed regionally, and per-user log analytics for tracing individual complaints — when a user says they didn't get a notification, the question is which of five links in the chain broke, and without targeted logs the answer is a shrug.

### Sharing Redis, then not, then not again

A small saga in the commit history. Garuda originally had its own Redis. It was moved to a shared instance for cost, then reverted, then reverted again to a sentinel setup.

The reason it kept coming back: **Asynq's queue and the main application's cache have incompatible failure requirements.** A cache can be evicted under memory pressure — that's what a cache is for. A job queue cannot; evicting a queued job loses work. Sharing an instance means one `maxmemory` policy has to serve both, and any policy that is safe for the queue is wasteful for the cache.

The cost saving was real and it was not worth the coupling.

## What it does well

The separation is the win. Notification campaigns can be enormous and slow without any effect on API latency, because they execute in a different process, in a different language, drawing from a different queue. The main API's involvement is one call to enqueue.

The other thing I'd note is unglamorous: the Redis story above is the kind of decision that gets made for a defensible reason (cost), reverted for a better reason (correctness), and only makes sense if someone writes down why. That's most of what the architecture document is for.
