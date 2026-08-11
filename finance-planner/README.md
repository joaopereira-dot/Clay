# 💰 Ledger — Personal Finance Planner

A private, **local-first** budgeting and financial-planning web app in the
spirit of YNAB. Track expenses, categorize spending, monitor investments, set
goals, and get **tailored, rule-based advice** derived from your own financial
profile — all in a single static HTML file, with your data kept in your browser.

> Part of the **Clay** workspace. Like every project here it lives isolated in
> its own top-level folder ([`finance-planner/`](.)) and touches nothing else in
> the repo.

## What it does

| Area | Details |
| --- | --- |
| **Dashboard** | Net worth, liquid cash, portfolio value and savings rate at a glance; 6-month income-vs-spending chart; top spending categories; the two most important advice items. |
| **Budget** | Category-based, envelope-style monthly budgeting. Plan an amount per category, grouped (Essentials / Lifestyle / …), and watch spending fill each bar. Flip between months. |
| **Transactions** | Log expenses and income with date, category, account and note. Search and filter by month or category. Balances on the linked account stay in step automatically. |
| **Investments** | Holdings with quantity, cost basis and current price → portfolio value, unrealized P/L, and an allocation donut by asset class. |
| **Goals** | Savings goals with target, amount saved and optional target date. Ledger computes the monthly pace needed to finish on time. |
| **Profile** | Your income, age, dependents, risk tolerance, emergency-fund target, savings-rate goal, debt, currency and accounts. Everything that personalizes the advice. |
| **Advice** | A rule-based engine that reads your profile + goals + live data and surfaces prioritized guidance: emergency-fund adequacy, savings rate, over-budget categories, spending concentration, high-interest debt, investment allocation vs. risk tolerance, idle cash, and goal pacing. |
| **Data** | JSON export/import backup, reset, and optional end-to-end-encrypted cloud sync. |

The advice is educational and rule-based — not a substitute for a licensed
financial professional.

## Running it

No build step, no dependencies. It's one static file.

- **Locally:** open [`index.html`](./index.html) in any modern browser.
- **Hosted:** serve the folder from any static host.

## Hosting the app

Because it's a static single file, hosting is trivial and free:

- **GitHub Pages** — enable Pages for this repo and the app is served at
  `https://<user>.github.io/<repo>/finance-planner/`. This matches how the rest
  of the Clay workspace is published.
- **Netlify / Cloudflare Pages / Vercel** — drag-and-drop or point at the repo;
  set the publish directory to `finance-planner/`.
- **Any web server or even a USB stick** — it's just HTML/CSS/JS.

There is no backend to run, no server to patch, and no secrets to manage for the
core app.

## Where your data lives

This was the central design decision (financial data is sensitive), so it's
worth being explicit:

- **By default: local-only.** All data is stored in your browser via
  `localStorage` and **never leaves your device**. No account, no tracking, no
  server sees your finances. The header pill shows `Local · this device`.
- **Backups are in your hands.** The Data tab exports a full JSON snapshot you
  can store anywhere (or drop into a private cloud drive), and imports it back
  on another browser.
- **Claude Artifact aware.** If the app runs inside a Claude Artifact, it
  transparently uses the account-synced Artifact storage API instead of
  `localStorage`.

### Optional: end-to-end-encrypted cloud sync

If you want the same vault on multiple devices, Ledger ships an **optional** sync
layer that is **off until you configure it**. When enabled, your entire dataset
is **encrypted in the browser** (AES-GCM; key derived from a passphrase you
choose via PBKDF2) *before* upload — the sync server only ever stores an opaque
ciphertext blob and never sees your passphrase. Losing the passphrase means the
data can't be recovered, which is the point.

Setup is a one-time Supabase project you control. Full instructions and the SQL
schema are in [`sync/README.md`](./sync/README.md) and
[`sync/schema.sql`](./sync/schema.sql).

Decision guide:

| You want… | Use |
| --- | --- |
| Maximum privacy, one device | Default local-only (do nothing). |
| Backups / moving browsers | Data-tab JSON export & import. |
| Same vault on phone + laptop | Optional encrypted cloud sync. |

## Data model

A single JSON document (also what export/import moves around):

```
{ version, profile, settings, accounts[], categories[], txns[],
  investments[], goals[], sync, meta }
```

- `profile` — income, age, dependents, riskTolerance, emergencyMonths,
  savingsRateGoal, debtTotal, debtApr, debtMonthly.
- `accounts[]` — `{ name, type, balance }`; `credit`/`loan` count as liabilities.
- `categories[]` — `{ name, group, budget, color }`.
- `txns[]` — `{ date, type: expense|income, amount, categoryId, accountId, note }`.
- `investments[]` — `{ name, ticker, assetClass, quantity, costBasis, price }`.
- `goals[]` — `{ name, target, saved, targetDate }`.
- `sync` — cloud-sync config (URL, anon key, table, vaultId); the passphrase is
  **never** persisted.

## How the advice engine works

`buildAdvice()` in `index.html` derives figures from your data (via the `Sel`
selectors) and applies transparent rules, each producing a prioritized card
(`alert` → `warn` → `good`). Examples:

- **Emergency fund** — liquid cash ÷ average monthly spend vs. your target
  months.
- **Savings rate** — `(income − spending) / income` vs. your goal.
- **Allocation** — growth-asset share vs. a `110 − age` glide path adjusted for
  your risk tolerance.
- **Debt** — flags balances at ≥ 7% APR as a payoff priority.
- **Goal pacing** — remaining ÷ months left → required monthly contribution.

Every rule reads only local data, so the guidance updates the instant you edit
anything.

## Tech

Vanilla HTML/CSS/JS, no framework, no external network calls for the core app
(charts are hand-rolled inline SVG). The Web Crypto API powers the optional sync
encryption. Fonts fall back to system fonts, so it works fully offline.
