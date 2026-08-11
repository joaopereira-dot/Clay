# Changelog

All notable changes to this repository are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.4.0] - 2026-08-11
### Added
- **Root project launcher** (`index.html`): the site root now lists every
  project as a card instead of redirecting to one of them, so the root URL
  stays generic as projects are added or retired.
- **Pull-request workflow** documented in `CONTRIBUTING.md`: feature branch →
  PR against the default branch → review → merge, with no direct pushes.
### Changed
- Root `README.md`: replaced the stale, branch-specific "This branch" section
  with a "Published site" section covering the launcher and project URLs.
### Removed
- The root `<meta http-equiv="refresh">` redirect (and its `canonical` link) to
  `puppy-training-tracker/`.

## [1.3.0] - 2026-08-11
### Added
- **Ledger** (`finance-planner/`): major feature expansion tailoring the app to
  a real workflow, informed by a review of current products (YNAB, Monarch,
  Copilot, Actual Budget) and 2026 best-practice sources.
  - **Recurring** tab: bills/subscriptions/income with any cadence, due dates,
    monthly-equivalent totals, upcoming forecast, and "Post" (logs a real
    transaction and advances the next date). Overdue items flagged.
  - **CSV / bank-statement import** with column mapping, sign handling,
    auto-categorisation and duplicate detection.
  - **Quick-add templates** and **split transactions** across categories.
  - **Household**: members + optional per-transaction "who" tags; sharing via
    the encrypted vault.
  - **Multi-currency**: per-account/holding currency, a base currency, and a
    manually-maintained (offline) exchange-rate table; all aggregates convert.
  - **Advice priorities** chosen in Profile now weight which advice surfaces
    first; new recurring-cost/overdue advice rules.
  - **Installable PWA**: web manifest, service worker, offline app-shell cache,
    and an in-app install button.
  - **Optional, opt-in AI coaching** (bring-your-own key; Anthropic or
    OpenAI-compatible) that sends only an anonymized numeric snapshot, with an
    in-app preview of exactly what is sent. Off by default.
### Changed
- Budget tab reframed as flexible **plan & track** (income − plan readout).
- Data model bumped to v2 with a `migrate()` step backfilling new fields and the
  v1 single-currency → base-currency migration.

## [1.2.0] - 2026-08-11
### Added
- **Ledger — Personal Finance Planner** (`finance-planner/`): a new, isolated
  local-first budgeting and financial-planning app in the spirit of YNAB.
  Category (envelope) budgeting, expense/income transactions, investment
  tracking with allocation and P/L, savings goals with pacing, a financial
  profile, and a rule-based advice engine (emergency fund, savings rate,
  over-budget categories, spending concentration, high-interest debt,
  allocation vs. risk tolerance, idle cash, goal pacing). Data stays in the
  browser by default, with JSON backup/restore and an **optional
  end-to-end-encrypted cloud-sync** adapter (AES-GCM / PBKDF2 in-browser;
  Supabase schema and docs under `finance-planner/sync/`).

## [1.1.0] - 2026-07-04
### Added
- **Daily journal with streaks** (`puppy-training-tracker`): log dated entries
  per dog — quick tags (training, socialisation, potty, walk, play, handling,
  vet, win), an optional mood, and notes — shown as a timeline with current and
  longest day-streaks. Entries sync in real time for shared dogs.

## [1.0.0] - 2026-07-04
First documented release of the **Puppy Training Tracker** (`puppy-training-tracker/`).

### Added
- Personalized, source-backed training plans tailored by **age** (from a birth
  date, so the developmental stage self-advances), **breed type**, **known
  skills**, **goals**, and **challenges**.
- 17 training modules with step-by-step guidance, "you've got it when…"
  milestones, and **"Take it further"** advanced progressions; a **"Today's
  focus"** daily action card; new-stage nudges and breed-insight notes.
- Sources spanning US **and European** practice (AVSAB, AKC, ASPCA, Karen Pryor,
  Ian Dunbar, Cornell, Whole Dog Journal, Purina; Dogs Trust, The Royal Kennel
  Club, Turid Rugaas, RSPCA).
- Multiple dogs; optional **live multi-user sharing** via Firebase (share code /
  invite link).
- Offline-first storage, responsive layout, and a self-contained Artifact build.

[Unreleased]: https://github.com/joaopereira-dot/Clay/compare/v1.4.0...HEAD
[1.4.0]: https://github.com/joaopereira-dot/Clay/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/joaopereira-dot/Clay/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/joaopereira-dot/Clay/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/joaopereira-dot/Clay/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/joaopereira-dot/Clay/releases/tag/v1.0.0
