---
title: Lessons from the first few years
summary: A list I wrote in 2024, two years into the job, revisited now with the benefit of having been wrong about some of it.
date: '2024-03-01'
tags: ['reflection', 'engineering practice']
---

I wrote a list of lessons about two years into working as an engineer. Reading it back, most of it holds up, some of it was the kind of thing you write because it sounds correct rather than because you'd learned it, and one item I'd now argue against.

Here's the honest version.

## The ones that held up

**Focus beats multitasking.** I wrote this as a productivity observation. It's actually a correctness one. Working two changes simultaneously means both get shallow attention, and the bug you ship isn't in the hard part — it's in the easy part you did while thinking about the hard part.

**Learn one framework properly.** Depth in one thing transfers. Breadth across five doesn't, because what transfers is the *shape* of the problems — how ORMs handle relationships, how job queues handle retries, how routers dispatch — and you only see the shape after going deep enough in one to hit its edges.

**Test locally before deploying.** Obvious, and I'd sharpen it: the value isn't catching bugs, it's the feedback loop. If your only way to know whether something works is to deploy it, you'll iterate at the speed of your pipeline, which is a hundred times slower than iterating locally.

**Own your mistakes.** Still the highest-return item on the list. The engineer who says "that was my change, I'm reverting it" is more useful than the one who is right more often. Especially given that on a platform of any size you *will* break something — I have 88 reverts to my name.

**Clear commit messages.** I undersold this. I've spent the last few weeks reading my own commit history from four years ago to write up work I'd half-forgotten. The commits that say what and why are the ones that gave anything back. `Fix: dims` gave me nothing.

**Ask for review.** Yes, and the reframe I'd add: a review request is not a request for approval. If you present a change as finished, you get approval. If you present the decision you're unsure about, you get help with it.

## The one I'd argue with

**"It's okay to implement your initial thoughts and optimize later."**

I wrote that under the heading of not overthinking, and there's a version of it I still believe — shipping a working simple thing beats designing a perfect thing.

But as written it's dangerous, and it cost me real time. I have a set of abandoned pull requests where I built an optimisation for something that turned out not to be the bottleneck. One of them was a full day's work on a layout path that wasn't the slow part at all. I'd have known in an hour with a profiler.

So the corrected version: **it's fine to implement your first idea for the structure of the code. It is not fine to implement your first idea about where the slowness is.** For correctness, act and iterate. For performance, measure or don't touch it.

The strongest version of this I've internalised since: every performance change I've made that actually worked started with a trace showing where the time went. Every one that wasted a day started with a hypothesis.

## What I'd add now

Four things that weren't on the list because I hadn't learned them yet.

**Make changes small enough to revert.** Not as process, as design. A change you can back out in one merge means a bad deploy is a five-minute event. A change touching forty files across six concerns means a bad deploy is an evening of debugging under pressure, which is when people make things worse.

**The failure you can't see is worse than the failure that pages you.** The worst bug I've fixed was a backup that completed, reported success, and produced an inconsistent snapshot. No error, no alert, false confidence — and you find out during a restore. I now spend a real fraction of my time making invisible failures loud, and I'd call that the most valuable habit I've picked up.

**Configuration is architecture.** The queue a job runs in, the key an autoscaler watches, a connection pool size. These live in YAML that looks like settings, and they determine behaviour under load more than most application code does. I've caused more production incidents with configuration than with logic.

**Write down why you backed something out.** My reverts that carry a sentence of reasoning taught me something twice. The ones that just say `Revert "..."` are archaeology I can no longer do.

## The one I'd keep unchanged

**Consistency.** I wrote "don't start something and then abandon it," and I meant finishing side projects, which is a fine but minor point.

The version that turned out to matter is smaller and duller: the same instinct applied daily. Instrumenting the thing you just debugged, so next time it's visible. Adding the alert after the incident. Writing the commit message properly when nobody's watching. None of those feel like progress on the day. Four years of them is the difference between a system you can reason about and one you're afraid of.
