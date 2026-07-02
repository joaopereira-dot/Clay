# 🐾 Field Journal — Personalized Puppy Training

A single-file web app that builds a **personalized, source-backed training plan**
for each of your dogs. Add a dog, answer a few questions about their age, what
they already know, and what you're working toward, and the app assembles a plan
tuned to their developmental stage — then tracks your progress as you check
things off.

Built to be shared: send a friend the link and they manage their own dogs on
their own device.

---

## Live links

| Where | URL | Best for |
| --- | --- | --- |
| **Claude Artifact** | https://claude.ai/code/artifact/7777c718-8233-4b4a-8485-c0aadc3b077d | Cross-device use synced to your Claude account |
| **GitHub Pages** | `https://joaopereira-dot.github.io/Clay/puppy-training-tracker/` | Public sharing — no login required *(enable Pages first, see [Deploying](#deploying))* |

---

## Features

- **Multiple dogs.** Each dog is a tab; add, switch, edit, or remove any of them.
  Every dog keeps its own profile and progress.
- **Onboarding questionnaire.** Name, breed, **age**, the skills they **already
  know**, your **goals**, and any current **challenges**.
- **A plan tailored to the answers:**
  - **Age → developmental stage.** The app derives a life-stage briefing (what's
    happening in the dog's brain/body, this stage's priorities, and a safety
    caution). A 10-week puppy gets a *time-sensitive* socialization module with a
    vaccination caveat; a 10-month "teenager" gets a *Surviving Adolescence*
    module about regression and management.
  - **Known skills** drop into an "Already got it · maintain" section instead of
    being taught from scratch.
  - **Goals & challenges** float the most relevant of the 15 training modules to
    the top.
- **Actionable modules.** Each has step-by-step guidance, a "you've got it
  when…" milestone, and an inline citation to its source.
- **Automatic progress saving** (see [Data & privacy](#data--privacy)).
- **No dependencies, no tracking, works offline** (the Artifact build).

## How the personalization works

Age is normalized to weeks and mapped to a stage:

| Age | Stage | Emphasis |
| --- | --- | --- |
| < 12 weeks | Prime socialization window | Socialization (time-sensitive), marker/name, potty, crate, bite inhibition |
| 12–16 weeks | Closing the window | Finish socialization + first foundation cues |
| 4–6 months | Juvenile & teething | Legal chews, sit/down/stay, first vet-cleared outings |
| 6–12 months | Early adolescence | Back to basics, management, heavy rewards |
| 12–18 months | Adolescence | Consistency, proofing, ride out fear periods |
| 18 months+ | Young adult | Proof cues in distraction, daily enrichment |

Each module exposes a `score(dog)` function that returns a priority number
(or `null` to hide it) based on age, goals, challenges, and known skills. The
plan is the applicable modules sorted by score; modules matching an
already-known skill move to the maintenance section.

## Project structure

```
puppy-training-tracker/
├── index.html                 # The app — canonical source (links Google Fonts CDN)
├── build.py                   # Regenerates dist/artifact.html (offline, deterministic)
├── vendor/
│   └── fonts.embedded.css     # OFL web fonts inlined as data URIs (see Fonts & licensing)
├── dist/
│   └── artifact.html          # GENERATED self-contained build — do not hand-edit
├── archive/
│   └── v1-single-dog.html     # Original single-dog version, kept for reference
└── README.md
```

## Running locally

It's a static file — no server or build step required:

```bash
# open directly
xdg-open index.html        # macOS: open index.html

# or serve it (nicer for testing)
python3 -m http.server --directory . 8000
# then visit http://localhost:8000/
```

## Building the Artifact bundle

`index.html` is the source of truth. Some targets forbid external requests —
a Claude Artifact's strict Content-Security-Policy, or fully offline use — so
`dist/artifact.html` is a self-contained build with the fonts inlined and the
outer document wrapper stripped (the Artifact runtime supplies its own).

Regenerate it after editing `index.html`:

```bash
python3 build.py
```

The build is deterministic and offline (it only reads local files). It also
sanity-checks that the output leaks no wrapper tags or CDN links.

## Deploying

**GitHub Pages (public, no login — best for sharing):**

1. Repo → **Settings** → **Pages**.
2. Under *Build and deployment*, set **Source: Deploy from a branch**.
3. Branch: `claude/puppy-training-tracker-ta3u1u`, folder `/ (root)` → **Save**.
4. After ~1 minute the site is live at
   `https://joaopereira-dot.github.io/Clay/puppy-training-tracker/`.

> If the repo is **private**, GitHub Pages requires a paid plan; if it's
> public, the steps above just work.

**Claude Artifact:** publish `dist/artifact.html` as an Artifact. Redeploying to
the existing URL keeps the link (and everyone's saved progress) stable.

## Data & privacy

Progress is stored **locally and privately** — nothing is sent to a server and
nothing is shared between users. The `Store` module auto-selects the best
available backend:

| Backend | When | Scope |
| --- | --- | --- |
| Claude Artifact storage | Running inside a Claude Artifact | Synced to your Claude account (cross-device) |
| `localStorage` | A normal web host / GitHub Pages | Per-browser, per-device |
| In-memory | Neither available | This session only (a notice is shown) |

All data lives under the key `puppy-tracker-v2`.

## Sources

Guidance is drawn from established, positive-reinforcement-based sources; each
module links the specific one it's based on.

- [AVSAB — Puppy Socialization Position Statement](https://avsab.org/wp-content/uploads/2018/03/Puppy_Socialization_Position_Statement_Download_-_10-3-14.pdf)
- [AKC — Puppy Training Timeline](https://www.akc.org/expert-advice/training/puppy-training-timeline-teaching-good-behavior-before-its-too-late/)
- [AKC — Puppy Growth Timeline](https://www.akc.org/expert-advice/puppy-information/puppy-growth-timeline-transitions-puppyhood/)
- [AKC — Reliable Recall](https://www.akc.org/expert-advice/training/reliable-recall-train-dogs-to-come-when-called/)
- [ASPCA — House Training Your Dog or Puppy](https://www.aspca.org/news/house-training-your-dog-or-puppy)
- [ASPCA — Separation Anxiety](https://www.aspca.org/pet-care/dog-care/common-dog-behavior-issues/separation-anxiety)
- [Karen Pryor — Charging the Clicker](https://clickertraining.com/charging-the-clicker/)
- [Karen Pryor — Loose-Leash Walking](https://clickertraining.com/loose-leash-walking/)
- [Dr. Ian Dunbar — Teaching Bite Inhibition](https://www.dogstardaily.com/training/teaching-bite-inhibition)
- [Cornell Riney Canine Health Center — The Teenage Years](https://www.vet.cornell.edu/departments-centers-and-institutes/riney-canine-health-center/canine-health-topics/teenage-years-puppy-proofing-and-training-tips)
- [San Diego Humane Society — Loose-Leash Walking](https://sdhumane.org/resources/training-tips-loose-leash-walking/)
- [Whole Dog Journal — Teaching a Reliable Recall](https://www.whole-dog-journal.com/training/teaching-a-reliable-recall/)
- [Purina — Brain Games for Dogs](https://www.purina.com/articles/dog/behavior/play/brain-games-for-dogs)

> **Not veterinary advice.** This app is general education. Vaccination status
> changes what's safe for public socialization — confirm outdoor/public steps
> with your vet. For fear, aggression, or severe separation distress, consult a
> certified trainer or veterinary behaviorist.

## Fonts & licensing

The display, body, and mono typefaces — **Fraunces**, **Inter**, and
**IBM Plex Mono** — are all licensed under the
[SIL Open Font License 1.1](https://openfontlicense.org/), which permits
embedding and redistribution (including as the data URIs in
`vendor/fonts.embedded.css`). `index.html` loads them from the Google Fonts CDN.
