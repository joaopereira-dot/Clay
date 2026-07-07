# Changelog

All notable changes to this repository are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- The dog view is split into **Plan** and **Journal** sub-tabs to cut scrolling.
  The Journal tab shows the current streak in its label; sharing and profile
  actions remain visible under both tabs.

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

[Unreleased]: https://github.com/joaopereira-dot/Clay/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/joaopereira-dot/Clay/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/joaopereira-dot/Clay/releases/tag/v1.0.0
