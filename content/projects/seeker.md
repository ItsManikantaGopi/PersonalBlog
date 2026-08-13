---
title: 'Seeker: a search engine built from first principles'
summary: An inverted index, BM25, Levenshtein automata, FSTs, BKD trees, a byte-level segment format and a breakable cluster — about 20,000 lines of TypeScript, with a 43-chapter book and an interactive lab for every chapter.
date: '2026-08-13'
period: '2026'
role: Author
featured: true
weight: 70
tags: ['open source', 'search', 'data structures']
stack: ['TypeScript', 'Next.js', 'React']
links:
  - label: 'github.com/ItsManikantaGopi/seeker'
    href: 'https://github.com/ItsManikantaGopi/seeker'
---

I had used Elasticsearch for years without being able to explain why an FST is worth building. This project is the answer to that, written out in full: a working search engine implemented from the bottom up, with a book that derives each structure and an interactive lab where every number is computed live.

Roughly 20,000 lines of TypeScript across the engine, the labs and the test suite. The engine core has no dependency on React or the DOM — the same code runs in Node tests and in the browser.

## The method

> Build the simple version → discover the bottleneck → replace one component → understand why the advanced structure exists.

The rule I held to: **never skip the intermediate structure.** A trie is not a detour on the way to an FST. It is the thing that makes you notice suffixes are being stored twice, which is the only reason an FST is worth building at all.

So the repository keeps the slow versions. Both implementations of everything stay, and you can measure the difference:

| | Naive | Optimised | What the lab shows |
|---|---|---|---|
| Find a term | scan every document | inverted index | comparison counts, side by side |
| Fuzzy match | DP table per term | Levenshtein automaton + trie | 462 comparisons → 57 nodes visited |
| Term dictionary | sorted array | trie → DAWG → FST | 1802 nodes → 776; ~155 KB → ~6 KB |
| Range query | check every value | binary search / BKD | subtrees rejected without being read |
| Top-K | score every candidate | WAND with upper bounds | ~50% of scoring skipped, identical results |

That last column is the point of the whole project. Not "FSTs are compact" as an assertion, but a specific corpus going from 155 KB to 6 KB, computed on page load by the code being described.

## What's implemented

The full stack, not a toy subset:

- **Analysis** — character filters, five tokenizers, lowercasing, ASCII folding, stopwords, edge n-grams, and two stemmers including the real Porter algorithm.
- **Index** — inverted index with frequencies, positions and per-field norms.
- **Execution** — leapfrog conjunction, disjunction, required/optional, exclusion, phrase-with-slop, and galloping `advance`.
- **Scoring** — BM25 with `k1`/`b`, IDF, length normalisation, and a full explanation tree.
- **Query language** — an AST, a compiler, and a parser handling fields, phrases, fuzzy, prefix, wildcard, regex, ranges, booleans, boosts and grouping.
- **Fuzzy matching** — Levenshtein and Damerau distance with a traceable DP table, then an NFA over (position, edits) determinized to a DFA.
- **Dictionaries** — trie, bottom-up minimization into a DAWG, direct incremental minimal FST construction with min-sum output pushing, and a BlockTree-style dictionary with front-coded blocks.
- **Numerics** — sorted point index, KD tree, and BKD tree with leaf blocks and region rejection.
- **Storage** — a byte-level segment format: varints, zigzag, gap encoding, frame-of-reference bit packing, CRC32.
- **Lifecycle** — segments, tombstones, tiered merging, a translog, refresh/flush/commit, and crash recovery.
- **Systems** — an mmap page-cache simulation with LRU eviction, cost-based join ordering, WAND pruning, a discrete-event thread-pool simulation with backpressure, shards, routing, replicas, allocation and promotion.

## The testing rule, and three bugs it caught

Chapter 42's rule is the one the repository actually follows:

> **An optimisation is only allowed to be faster. Never to change the answer.**

Every fast path has a slow, obviously-correct reference implementation, and they are compared on every run. `naiveScan`, `bruteForceFuzzy`, `naivePointRange`, `exhaustiveTopK`, `buildNaiveIndex` — these exist purely to be the oracle. Around 1,000 checks in Node, plus 237 in the browser.

Three bugs this caught that I would otherwise have shipped:

**The Levenshtein automaton silently lost terms.** My subsumption pruning was discarding epsilon-successors that later transitions needed, so `"ubernetes"` failed to match `"kubernetes"` at edit distance 1. It didn't error — it returned fewer results. The pruning is gone and the DFA is larger (41 states rather than 31 at k=1) and correct. A fuzzy matcher that quietly drops results is worse than a bigger automaton, and only a differential test against brute-force DP finds it.

**Shard allocation invented data.** After a node died, allocation happily re-placed the lost shard onto a healthy node — conjuring a replica that had never existed. Now a shard with no surviving copy stays unassigned and the cluster goes red. That's what makes the argument for replicas real rather than asserted.

**A hydration mismatch in the playground,** which server-rendered a live timing value.

The first two are the interesting ones because both were *silent*. Neither threw. Both produced plausible output. That is precisely the class of bug that a reference implementation catches and code review does not.

## Why bother

Partly because I wanted the understanding. Mostly because I think a certain kind of knowledge only sticks if you can build the thing.

There's also a claim in the README I care about keeping honest: **nothing on the site is a recorded result.** Every number is computed on load by the same engine the chapter describes. Move a slider and the arithmetic underneath it moves with you. It would have been much easier to write the numbers into the prose, and it would have been a worse artefact — because a stated benchmark is a claim, and a computed one is a demonstration.
