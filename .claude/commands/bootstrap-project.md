---
description: Inspect the current repo and fill AGENTS.md + docs/architecture/ skeletons (run after init-project.sh)
---

You are bootstrapping architecture documentation for this repository. The
`init-project.sh` script has already placed three skeleton files. Your job
is to inspect the repo and replace the TODO placeholders with real content.

## Files in scope

- `AGENTS.md` — TODOs in: "Project Overview", "Commands", "Architecture".
  **Do NOT touch the "Documentation" section — it is fixed across all repos.**
- `docs/architecture/README.md` — TODOs in chapters 1–7.
- `docs/architecture/reference/_template.md` — leave as-is; this is the
  template that future per-domain references will be copied from.

## Workflow

### 1. Inspect

Read everything that tells you what this project is. Read in parallel
where possible:

- `package.json` / `pyproject.toml` / `pom.xml` / `Cargo.toml` / `go.mod`
  (whichever exist) — stack, scripts, dependencies
- Top-level `README.md` if present — project purpose
- Top-level directory tree (Glob `*` or LS) — to understand layout
- `Makefile`, `Dockerfile`, `docker-compose.yml`, `compose.yml` — commands
- Framework configs: `tsconfig.json`, `next.config.*`, `vite.config.*`,
  `pytest.ini`, etc. — stack details and aliases

### 2. Fill `AGENTS.md`

- **Project Overview** — 2–3 sentences. What does this system do, for whom.
- **Commands** — dev, build, test, lint. Pull from `package.json` scripts
  or Makefile targets. Use the bash block format already in the template.
- **Architecture** — short high-level note (stack + main layers). Defer
  detail to `docs/architecture/`.
- **Documentation section** — DO NOT MODIFY.

### 3. Fill `docs/architecture/README.md`

Mandatory chapters:

- **Chapter 1** (What this is and who it's for) — 2–3 paragraphs.
- **Chapter 2** (Architecture map) — ASCII diagram of the main layers
  and external services.
- **Chapter 5** (Key patterns) — bullet list of conventions you can
  observe: module system (ESM/CJS), framework defaults, path aliases,
  form library, server/client split, etc.
- **Chapter 7** (Domain references) — scan top-level source dirs
  (`src/`, `lib/`, `app/`, or whatever applies) and list candidate
  domains in the table as `⏳ pending`. **Do NOT create reference files
  yet** — those are written lazily, on the first real task that touches
  the domain (this avoids docs that go stale before being read).

Optional chapters (3, 4, 6) — fill ONLY if obvious from inspection.
Otherwise leave the TODO blocks intact.

### 4. Verify before reporting done

- Re-read both files.
- Confirm no TODO placeholders remain in chapters you committed to filling.
- Confirm "Documentation" section in `AGENTS.md` is unchanged.

### 5. Stop and ask if ambiguous

Do NOT guess on these — pause and ask the user:

- Project's primary purpose, if README is missing or unclear.
- Canonical command set, if Makefile and package.json disagree.
- Whether a given top-level dir counts as a "domain" (e.g., `tests/`,
  `scripts/`, `vendor/` usually do NOT — but ask if unsure).
- If repo is a monorepo — confirm scope before treating sub-packages
  as domains.

## Hard rules

- **Do not invent information.** If a fact isn't in the repo, mark it
  with `<!-- TODO: needs human input — could not detect X -->`.
- **Do not create per-domain reference files** in this pass. Only list
  candidates in chapter 7 of `README.md`.
- **Do not touch any code files** — this command writes only to
  `AGENTS.md` and `docs/architecture/README.md`.
