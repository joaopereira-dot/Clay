# 💰 Ledger — Personal Finance Planner

A private, **local-first**, installable budgeting and financial-planning web app
in the spirit of YNAB / Monarch. Track expenses, plan budgets, monitor
investments and recurring bills, set goals, and get **tailored advice** derived
from your own financial profile — in a single static file, with your data kept
in your browser.

> Part of the **Clay** workspace. Like every project here it lives isolated in
> its own top-level folder ([`finance-planner/`](.)) and touches nothing else in
> the repo.

This build was tailored to a specific set of choices (see
[Design decisions](#design-decisions)): **flexible plan-&-track budgeting**,
**manual + CSV + quick-add** entry, **household sharing**, **full recurring
tracking**, **multi-currency**, an **installable PWA**, and an **optional,
opt-in AI coach**.

## What it does

| Area | Details |
| --- | --- |
| **Dashboard** | Net worth, liquid cash, portfolio value and savings rate; a 6-month income-vs-spending chart; top spending; upcoming recurring items; and the top advice items. |
| **Budget** | Flexible **plan & track** (Monarch-style) — set an expected amount per category and watch spending fill each bar, with an "income − plan" readout. No forced envelopes. Grouped categories, month switcher. |
| **Transactions** | Log expenses/income with date, category, account, note and (optionally) *who* spent. **Three entry methods**: manual, **CSV/statement import** (column mapping, sign handling, auto-categorisation, duplicate detection), and **quick-add templates**. **Split** a transaction across multiple categories. Linked account balances stay in step automatically. |
| **Recurring** | Bills, subscriptions and regular income with any cadence (every N days/weeks/months/years), next-due dates, monthly-equivalent totals, a 45-day upcoming list, and **"Post"** — which logs a real transaction and advances the next date. Overdue items are flagged. |
| **Investments** | Holdings with quantity, cost basis and current price → portfolio value, unrealized P/L, and an allocation donut by asset class. Per-holding currency. |
| **Goals** | Savings goals with target, saved amount and optional date → progress and the monthly pace needed to finish on time. |
| **Profile** | Income, age, dependents, risk tolerance, emergency-fund and savings-rate targets, debt, **advice priorities**, **household members**, accounts, base currency and **exchange rates**. |
| **Advice** | A rule-based engine reading your profile + goals + live data, **ordered by the priorities you pick** (debt payoff / investing & FIRE / everyday budgeting / big goals). Plus an **optional AI coaching** panel. |
| **Data** | JSON export/import, reset, **install-as-app**, **end-to-end-encrypted cloud sync**, and **AI-coaching** settings. |

The advice is educational and rule-based — not a substitute for a licensed
financial professional.

## Running & installing

No build step, no dependencies — one static file (plus a service worker and
manifest for offline/install).

- **Locally:** open [`index.html`](./index.html) in any modern browser.
- **Hosted:** serve the folder from any static host.
- **Install (PWA):** when served over HTTPS (e.g. GitHub Pages), use **Data →
  Install app** (or your browser's install button) to add Ledger to your phone's
  home screen or your desktop. It then works **offline** — the service worker
  ([`sw.js`](./sw.js)) caches the app shell; your data was always local anyway.

## Hosting the app

Because it's a static bundle, hosting is trivial and free:

- **GitHub Pages** — serve the repo and the app is at
  `https://<user>.github.io/<repo>/finance-planner/`. Installability and offline
  work here because Pages is HTTPS.
- **Netlify / Cloudflare Pages / Vercel** — publish directory `finance-planner/`.
- **Any web server** — it's just HTML/CSS/JS + a manifest + a service worker.

No backend to run, no server to patch, no secrets for the core app.

## Where your data lives

The central design decision (financial data is sensitive):

- **By default: local-only.** All data is stored in your browser via
  `localStorage` and **never leaves your device**. No account, no tracking. The
  header pill shows `Local · this device`.
- **Backups in your hands.** The Data tab exports/imports a full JSON snapshot.
- **Claude Artifact aware.** Inside a Claude Artifact it uses the account-synced
  Artifact storage API instead of `localStorage`.

### Household sharing = optional end-to-end-encrypted sync

Sharing with a partner and syncing across your own devices are the **same
mechanism**: an **optional** encrypted vault that is **off until you configure
it**. Your entire dataset is **encrypted in the browser** (AES-GCM; key derived
from a passphrase via PBKDF2) *before* upload — the sync server only stores
ciphertext and never sees your passphrase. Anyone using the same project URL +
Vault ID + passphrase shares the vault. Setup (a one-time Supabase project you
control) and the SQL schema are in [`sync/README.md`](./sync/README.md) and
[`sync/schema.sql`](./sync/schema.sql).

`Push` uploads this device's data; `Pull` replaces this device's data with the
cloud copy — a deliberate, manual last-write-wins model. Sync at the end of a
session on one device before switching to the other.

### Optional AI coaching (opt-in, off by default)

The **only** feature that can send data off-device. When you enable it in
**Data → AI coaching** and supply **your own API key** (Anthropic or an
OpenAI-compatible provider), the Advice tab can send an **anonymized numeric
snapshot** — no names, account names or transaction notes — for narrative
coaching. **Preview exactly what would be sent** from the Advice tab before it
sends anything. Your key is stored locally only and is excluded from sync
uploads; calls go directly from your browser to the provider and are billed to
your own account.

Decision guide:

| You want… | Use |
| --- | --- |
| Maximum privacy, one device | Default local-only (do nothing). |
| Backups / moving browsers | Data-tab JSON export & import. |
| Same vault on phone + laptop, or share with a partner | Optional encrypted cloud sync. |
| Narrative, AI-written coaching | Optional AI panel with your own key. |

## Multi-currency

Set a **base currency** in Profile. Each account and holding can be in its own
currency; you maintain a small **exchange-rate table** by hand (Profile →
Exchange rates), which keeps the app fully offline — nothing is fetched online.
All aggregates (net worth, budgets, spending, advice) convert to the base
currency; individual items also show their native amount.

## Design decisions

This build reflects these explicit choices:

- **Budgeting:** flexible *plan & track*, not strict zero-based envelopes.
- **Entry:** manual, CSV/statement import, and quick-add templates + splits.
- **Users:** household (multiple people) via the shared encrypted vault, with
  optional per-transaction *who* tags.
- **Recurring:** full tracking (cadence, due dates, forecast, post-to-ledger).
- **Advice focus:** chosen in-app in Profile; weights which advice surfaces first.
- **Currency:** multi-currency with manual rates.
- **Platform:** responsive, installable PWA for phone + desktop, offline-capable.
- **AI:** optional, opt-in, bring-your-own-key; rule-based engine otherwise.

## Data model

A single JSON document (also what export/import moves around):

```
{ version, profile, settings, accounts[], categories[], txns[],
  investments[], goals[], recurring[], templates[], sync, ai, meta }
```

- `profile` — income, age, dependents, riskTolerance, emergencyMonths,
  savingsRateGoal, debt*, `advicePriorities[]`, `members[]`.
- `settings` — `baseCurrency`, `locale`, `rates{}` (currency → units of base),
  `budgetMode`.
- `accounts[]` — `{ name, type, balance, currency }`; `credit`/`loan` are liabilities.
- `categories[]` — `{ name, group, budget, color }` (budget in base currency).
- `txns[]` — `{ date, type, amount, currency, categoryId, accountId, note,
  memberId?, splits?[] }`.
- `investments[]` — `{ name, ticker, assetClass, quantity, costBasis, price, currency }`.
- `goals[]` — `{ name, target, saved, targetDate }`.
- `recurring[]` — `{ name, type, amount, currency, categoryId, accountId,
  cadence{unit,every}, nextDue, active, memberId? }`.
- `templates[]` — quick-add presets.
- `sync` — cloud-sync config; the passphrase is **never** persisted.
- `ai` — provider/model/enabled; the API key stays local and is stripped from sync uploads.

Loading old/partial data runs through a `migrate()` step that backfills new
fields (including the v1 single-currency → base-currency migration).

## How the advice engine works

`buildAdvice()` derives figures via the `Sel` selectors (all converting to the
base currency) and applies transparent rules, each producing a card
(`alert` → `warn` → `good`), then **re-ordered to surface your chosen
priorities first**. Rules cover: emergency fund, savings rate, over-budget
categories, spending concentration, recurring-cost load, overdue recurring
items, high-interest debt, allocation vs. a risk-adjusted `110 − age` glide
path, idle cash, and goal pacing.

## Tech

Vanilla HTML/CSS/JS, no framework. Core app makes **no network calls** (charts
are hand-rolled inline SVG; fonts fall back to system fonts, so it works fully
offline). The Web Crypto API powers sync encryption; a service worker enables
offline/install. The only outbound calls are the two opt-in features you
configure yourself (cloud sync, AI coaching).
