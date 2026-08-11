# Contributing & conventions

Lightweight version-control practices this repository follows.

## Branches
- Work happens on descriptive feature branches
  (e.g. `claude/puppy-training-tracker-ta3u1u`).
- Keep changes scoped — one logical change per commit.
- Never commit directly to the default branch.

## Pull requests
Every change reaches the default branch through a pull request — no direct
pushes.

- Open the PR against the repository's **default branch**.
- Title the PR like a commit: `type(scope): summary`.
- The body states **what** changed, **why**, and **how it was verified**
  (manual steps, browser checks, or test output).
- Keep one PR per logical change so it can be reviewed and reverted on its own.
- Update [`CHANGELOG.md`](./CHANGELOG.md) in the same PR as the change it
  describes.
- Merge only after review; delete the branch once merged.

## Commit messages — [Conventional Commits](https://www.conventionalcommits.org/)
Format: `type(scope): summary` (imperative, ≤ ~72 chars), e.g.
`feat(journal): add daily streaks`.

Types used here:

| type | when |
| --- | --- |
| `feat` | a new user-facing feature |
| `fix` | a bug fix |
| `docs` | documentation only |
| `style` | formatting / CSS with no behaviour change |
| `refactor` | code change that neither fixes a bug nor adds a feature |
| `perf` | performance improvement |
| `test` | adding or fixing tests |
| `build` | build tooling / dependencies |
| `chore` | housekeeping (config, .gitignore, etc.) |

## Versioning — [Semantic Versioning](https://semver.org/)
- `MAJOR.MINOR.PATCH`; tag releases `vX.Y.Z`.
- Every release gets an entry in [`CHANGELOG.md`](./CHANGELOG.md).

## Builds are generated, not hand-edited
- `puppy-training-tracker/index.html` is the **source of truth**.
- `puppy-training-tracker/dist/artifact.html` is **generated** — run
  `python3 build.py` after editing the source; never edit `dist/` by hand.
