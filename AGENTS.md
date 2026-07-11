# AGENTS.md — personal-site

This is the **work product** repo. Interpretation, decisions, and plans live in the sibling vault:

`../personal-site-brain` → `~/Projects/personal-site-brain`

Do not grow interpretive docs in this Rails tree. Keep README/ops thin.

## Plan-based execution (required)

**Highly encourage planning before implementing features, refactors, or multi-file changes.**

Before writing code for a feature or non-trivial change:

1. **Search the brain for an existing plan** with qmd (run from the vault so the collection resolves):

```bash
cd ../personal-site-brain && qmd update && qmd search "<feature keywords>" -c personal-site-brain
```

   Prefer hits under `plans/`. Skim related ADRs if they appear.

2. **If a relevant active plan exists** — read it, follow it, and note deviations for a later session wrap / Outcomes update. Do not silently ignore it.

3. **If nothing relevant is found** — **do not start implementing yet.** Tell the user clearly that no vault plan matched, and ask them to run **`/documented-plan`** (skill: `documented-plan`) so intent is planned and written to `plans/` before build work.

Exceptions (no plan required): typo fixes, one-line obvious fixes, pure questions, or the user explicitly says to skip planning.

## Stack reminders

- Rails 8, Hotwire, Tailwind, Slim, ViewComponent, RSpec, dry-types / dry-initializer
- Brain ADRs are source of truth for *why* (especially `ADR-003`, `ADR-004`)

## Capture

Durable “why” → vault ADRs/plans. App PRs can include a short Why; promote to the brain when it matters.
