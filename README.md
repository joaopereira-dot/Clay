# Clay

A personal workspace repository. Projects are kept **isolated in their own
top-level folders** so they don't mix, and each project carries its own README.

## Projects

| Project | Folder | Description |
| --- | --- | --- |
| 🐾 Field Journal — Personalized Puppy Training | [`puppy-training-tracker/`](./puppy-training-tracker/) | A single-file web app that builds a personalized, source-backed training plan for each of your dogs and tracks your progress. See its [README](./puppy-training-tracker/README.md). |
| 💰 Ledger — Personal Finance Planner | [`finance-planner/`](./finance-planner/) | A local-first, installable (PWA) budgeting app: flexible budgets, manual/CSV/quick-add transactions, recurring bills, investments, goals, multi-currency, household sharing, and priority-weighted advice. Data stays in your browser, with optional end-to-end-encrypted sync and an opt-in AI coach. See its [README](./finance-planner/README.md). |

## Published site

[`index.html`](./index.html) at the repository root is a **project launcher**
that lists the projects above. It is deliberately generic — the site root does
not redirect to any single project, so the root URL stays stable as projects are
added or retired:

```
https://<user>.github.io/Clay/                        → launcher (this list)
https://<user>.github.io/Clay/puppy-training-tracker/ → Field Journal
https://<user>.github.io/Clay/finance-planner/        → Ledger
```

To add a project, create its top-level folder with its own `README.md` and add a
card to the launcher plus a row to the table above.

## Conventions

This repo follows lightweight version-control practices — [Conventional
Commits](https://www.conventionalcommits.org/), [Semantic
Versioning](https://semver.org/) with `vX.Y.Z` tags, and a
[`CHANGELOG.md`](./CHANGELOG.md).

Changes land on the default branch through **pull requests** — feature branch →
PR → review → merge, with no direct pushes to the default branch. See
[`CONTRIBUTING.md`](./CONTRIBUTING.md).
