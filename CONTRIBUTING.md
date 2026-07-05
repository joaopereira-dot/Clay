# Contributing & conventions

Lightweight version-control practices this repository follows.

## Branches
- Work happens on descriptive feature branches
  (e.g. `claude/puppy-training-tracker-ta3u1u`).
- Keep changes scoped — one logical change per commit.

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
