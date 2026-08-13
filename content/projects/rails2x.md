---
title: 'rails2x: translating Rails to Go through an AST'
summary: A migration engine that parses Ruby with tree-sitter, lifts it into a typed intermediate representation, and scaffolds Goravel code — with static gates that refuse to publish a partial tree.
date: '2026-07-22'
period: '2026'
role: Author
tags: ['open source', 'go', 'compilers']
stack: ['Go', 'tree-sitter', 'Ruby', 'Goravel']
links:
  - label: 'github.com/ItsManikantaGopi/rails2x'
    href: 'https://github.com/ItsManikantaGopi/rails2x'
---

A tool for translating a monolithic Rails application into Go on the Goravel framework. Around 17,000 lines of Go.

The framing that made it worth building: most "port this codebase" tooling is either regex substitution, which breaks on anything real, or an LLM generating text, which produces plausible code with no guarantee it corresponds to the input. Both fail the same way — you cannot tell what was translated and what was invented.

So this one is a compiler pipeline.

## Pipeline

**Parse.** `go-tree-sitter` with the Ruby grammar over models, controllers, workers, ActiveAdmin registrations, specs and seeds. A real AST, not lines of text.

**Lift into an IR.** Ruby AST nodes become a typed Go schema — `ir.Model`, `ir.Worker`, `ir.AdminController`. This is the layer that earns its place: the IR is where "a `has_many` with a dependent option" exists as a fact that can be inspected, rather than as a string that happens to match a pattern.

**Generate.** `text/template` consumes the IR and scaffolds Go source into a Goravel project structure.

What it maps:

| Rails | Go / Goravel |
|---|---|
| ActiveRecord models, associations, constraints | structs with GORM tags |
| RESTful controllers and routes | Goravel controllers, CRUD extracted |
| `ActiveAdmin.register` blocks | Goravel admin controllers |
| Sidekiq workers | Asynq queued jobs |
| Cron/scheduled tasks | Goravel CLI commands |
| Pundit policies | Goravel gates and policies |
| RSpec `describe`/`it` blocks | `testify/suite` scaffolds |
| `db/seeds.rb` | embedded in `database_seeder.go` for manual translation |

## The design decision I care about

**It fails closed.**

A migration tool that emits 80% of a codebase and shrugs at the rest is worse than useless, because the 20% is invisible. You have a directory of Go that compiles, looks complete, and is silently missing behaviour.

So conversion stages into a temporary directory and **publishes only after gates pass**:

- `--strict` refuses to publish on unsupported discovery entries, open high-risk diagnostics, or constructs it doesn't handle. Not a warning — a non-zero exit and no output tree.
- Static gates run `gofmt`, `go vet`, `go build` and `go test` against the generated tree before it is published.
- A machine-readable release report records what was translated, what was skipped, and why.
- Provenance is written alongside the output, so any generated file can be traced to its source.

There's also `--offline --starter-dir` to use a pinned local Goravel scaffold instead of cloning one, because a migration tool that requires network access at generation time is not reproducible.

And separate acceptance commands — `accept tree`, `accept static`, `accept contract` — so the output can be verified independently of the run that produced it.

## What it can't do

Worth being explicit, because the honest boundary is the useful part of a tool like this.

It scaffolds structure, not semantics. Method bodies containing real business logic are not translated — they can't be, not reliably, because Ruby's dynamism means the AST doesn't determine the behaviour. `method_missing`, `define_method`, monkey patches and metaprogramming are all things the parser can see and the generator cannot faithfully reproduce.

What it does is convert the mechanical 70% — schema, associations, routes, job definitions, policy shapes, test scaffolds — into correct Go, and then tell you precisely and loudly which 30% needs a human. `db/seeds.rb` is the clearest case: it gets embedded verbatim for manual translation rather than half-converted, because a half-converted seed file is a trap.

That division is the whole thesis. **The value isn't in translating everything; it's in knowing exactly what wasn't translated.**
