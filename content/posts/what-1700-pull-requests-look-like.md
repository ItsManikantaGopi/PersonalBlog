---
title: What 1,700 pull requests actually look like
summary: I pulled the numbers on four years of my own work on one platform. The distribution was not what I would have guessed, and the 88 reverts turned out to be the part I'm least embarrassed by.
date: '2026-08-10'
tags: ['engineering practice', 'reflection']
---

I generated a report of every pull request I've opened across the platform I work on. 1,741 of them, across 15 repositories, from December 2021 to now. Then I categorised them, which is a slightly uncomfortable exercise, because the distribution of what you *actually did* rarely matches your sense of what you do.

Here's what was in there.

## The distribution

| | |
|---|---|
| Total opened | 1,741 |
| Merged | 1,621 (93%) |
| Closed unmerged | 118 (7%) |
| Still open | 2 |

By year: 4 in 2021, 227 in 2022, 354 in 2023, 498 in 2024, 485 in 2025, 173 so far in 2026.

By repository, the top four account for over 80%:

| Repository | PRs |
|---|---|
| Rails API monolith | 469 |
| GitOps fleet config | 380 |
| Messaging service | 339 |
| Mobile app | 220 |
| Terraform infrastructure | 171 |

## The thing I got wrong about myself

I would have described myself as a backend engineer who does some infrastructure. The numbers say something closer to a 50/50 split, and if you count the GitOps repository as infrastructure — it is — then infrastructure is the larger half.

That's not a complaint. But it's a gap between self-image and evidence, and I only found it by counting.

## The 88 reverts

Roughly 5% of my pull requests are reverts. My first reaction to that number was mild embarrassment. My considered reaction is that it's a healthy number, and a much lower one would worry me.

Here's the reasoning. A revert is only cheap if three things are true:

- **The change was small enough to isolate.** You can't revert one thing out of a 40-file pull request that did six things.
- **Deployment is automated.** If deploying is a manual ceremony, reverting is a manual ceremony, and people will patch forward instead — adding a second change on top of a broken one, under time pressure, which is how small incidents become large ones.
- **The system's state is described in version control.** In a GitOps repository, `git revert` genuinely returns production to a known state. Where that isn't true, a revert is just a hopeful gesture.

All three of those are properties I want. The revert count is evidence of them. A team with near-zero reverts either ships nothing risky, or patches forward over its mistakes, and the second is much more common than the first.

There's a specific pattern in my history I'd defend: `Revert "X"` followed weeks later by `X` again. Video processing service moved in-cluster, reverted, moved again. NATS stream configuration added, reverted, re-added, later removed entirely. Each of those pairs is a change that was right in principle and wrong in some detail, backed out in minutes rather than debugged in production for hours.

## The 118 closed pull requests

The abandoned ones are more interesting than the reverts, because they represent work that never shipped at all.

Reading back through them, most fall into three groups:

**Superseded by a better version.** I opened a PR, learned something reviewing it myself, and opened a cleaner one. Several appear as near-duplicate titles a day apart.

**Correct but not worth it.** A background-removal optimisation that dropped a dependency and worked, and wasn't worth the risk for the gain. A batching change for payments that added complexity for a saving we couldn't measure.

**Wrong premise.** The ones worth remembering. A change to make campaign generation use a different layout path, closed after it turned out the layout wasn't the bottleneck. I'd spent a day on it before measuring.

The last group is the argument for measuring first, and the fact that it's the smallest group is the only reason I feel okay writing about it.

## What the titles say about the work

I ran the titles through some rough keyword grouping. Non-exclusive — a PR can touch several themes:

| Theme | PRs |
|---|---|
| Messaging & real-time | 327 |
| Cloud migration | 256 |
| Media / poster pipeline | 178 |
| Kubernetes & Helm | 177 |
| Observability | 123 |
| CI/CD | 118 |
| Performance & caching | 77 |
| Payments & subscriptions | 72 |
| Testing | 69 |
| Autoscaling | 63 |

The one that surprised me is **observability at 123**. That's more than payments and testing combined. Nobody has ever asked me to spend a quarter on instrumentation, and yet it accumulated into one of the larger categories — one alert at a time, each after an incident that was harder to diagnose than it should have been.

## The one-line PRs

A large fraction of the GitOps pull requests are a single line: a chart version, a replica count, a memory limit. `updating vps scaling metrics` appears five times on consecutive days.

Early on I found this slightly humiliating to look at. Now I think it's the most defensible thing in the list.

Five one-line pull requests over three days is what tuning an autoscaler *honestly* looks like. The alternative — one pull request that changes six parameters at once, merged after a week of local reasoning — gives you no information about which parameter mattered. When something regresses you have one commit and six suspects.

Small commits are how you keep the ability to attribute cause. The tidier history is the less useful one.

## What I'd tell myself in 2022

**Measure before you build.** The wrong-premise pull requests all skipped this. Every one of them cost a day I'd have saved with an hour of instrumentation.

**Make the change small enough to revert.** Not as a process rule — as a design constraint on how you decompose work. It is what makes everything else recoverable.

**Write down why you backed something out.** The revert commits that just say `Revert "..."` are the ones I can't reconstruct now. The ones with a sentence of reasoning are the ones that taught me something twice.

**Count things about yourself occasionally.** I've worked on this platform for four years and I could not have told you the split between feature work and infrastructure work before running this report. Four years is a long time to be wrong about what you do all day.
