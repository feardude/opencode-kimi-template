---
description: Inspect the current repo, detect its shape (single-app / multi-module / multi-unit), and fill AGENTS.md + docs/architecture/ skeletons accordingly. Run after init-project.sh.
---

You are bootstrapping architecture documentation for this repository. The
`init-project.sh` script has already placed three skeleton files. Your job
is to inspect the repo and replace the TODO placeholders with real content.

## Files in scope

- `AGENTS.md` — TODOs in: "Project Overview", "Commands", "Architecture".
  **Do NOT touch the "Documentation" section — it is fixed across all repos.**
- `docs/architecture/README.md` — TODOs in chapters 1–7.
- `docs/architecture/reference/_template.md` — leave as-is.

## Workflow

### 1. Detect project shape (do this FIRST)

Different repo shapes need different domain strategies. Run this detection
before anything else.

| Signal | Shape | Strategy |
|---|---|---|
| `settings.gradle.kts` / `settings.gradle` with `include(...)` lines | **multi-module-jvm** | Read module list, group by capability |
| `pom.xml` with `<modules>`, or many sub-poms | **multi-module-jvm** | Same as Gradle |
| `pnpm-workspace.yaml` / `lerna.json` / `turbo.json` / `package.json` with `workspaces` | **js-monorepo** | Read workspace list, group by capability |
| Many sibling directories with the same shape (each has its own `pyproject.toml` / `setup.py` / `package.json`) | **multi-unit** | Each unit = its own domain |
| Single `package.json` / `pyproject.toml` / `go.mod` / `Cargo.toml` at root, conventional `src/` layout | **single-app** | Top-level `src/` subdirs = domains |
| `Cargo.toml` with `[workspace]` | **multi-module-rust** | Each crate = candidate domain, group by capability |
| `go.work` | **multi-module-go** | Same |

Read the relevant manifests in parallel. Confirm shape before proceeding.
If signals are mixed (e.g., a monorepo containing a multi-unit subdir),
treat the **outermost** shape as primary and note the nested one in chapter 4.

### 2. Inspect (shape-aware)

Read everything that tells you what this is:

- Stack manifest(s) from step 1 — versions, scripts, dependencies
- Top-level `README.md` — project purpose
- Top-level directory tree (Glob `*` or LS)
- `Makefile`, `Dockerfile`, `docker-compose.yml`, `compose.yml` — commands
- Framework configs: `tsconfig.json`, `next.config.*`, `vite.config.*`,
  `pytest.ini`, `build.gradle.kts` (root), etc.

For **multi-module-jvm / js-monorepo**:
- Read `settings.gradle.kts` / workspace manifest to enumerate modules
- For each module, glance at its name and (optionally) its
  `build.gradle.kts` / `package.json` to understand what it is
- DO NOT read each module's source — that's for the per-domain reference
  later, not now

For **multi-unit** (e.g., many Python calculators):
- Enumerate the sibling directories
- Peek at each directory's `README.md` or top-level file to grasp purpose
- Each unit will become its own domain candidate

### 3. Fill `AGENTS.md`

- **Project Overview** — 2–3 sentences. What does this system do, for whom.
- **Commands** — dev, build, test, lint. For Gradle: `./gradlew build`,
  `./gradlew test`, etc. For multi-unit: explain the convention (e.g.,
  "each calculator has its own `pyproject.toml`; run `pytest` inside the
  calculator dir").
- **Architecture** — short high-level note. Mention the shape explicitly
  ("This is a Gradle multi-module repo with N modules organized into
  microservices and libraries") and defer detail to `docs/architecture/`.
- **Documentation section** — DO NOT MODIFY.

### 4. Fill `docs/architecture/README.md`

Mandatory chapters:

- **Chapter 1** (What this is and who it's for) — 2–3 paragraphs.
- **Chapter 2** (Architecture map) — ASCII diagram. For multi-module,
  show modules grouped by capability, not all individually.
- **Chapter 5** (Key patterns) — conventions: build system, module
  layout, dependency rules between modules, code style, etc.
- **Chapter 7** (Domain references) — see shape-specific rules below.

Optional chapters (3, 4, 6):
- **Chapter 4** (Code layout) — for multi-module / multi-unit, this
  becomes important: explain how modules/units are organized, naming
  conventions, where shared code lives.
- Chapters 3, 6 — fill only if obvious.

#### Chapter 7 — domain strategy per shape

**single-app:**
- Top-level `src/` subdirs that look like coherent domains.
- Target: 5–10 entries. If fewer, that's fine.
- Each row: domain name, status (`⏳ pending`), "—" for Reference, and
  a one-sentence Notes describing what the domain does.

**multi-module-jvm / js-monorepo / multi-module-rust / multi-module-go:**
- DO NOT list every module individually if there are more than 10.
- Group modules by capability (e.g., `payment` covers `payment-service`,
  `billing-service`, `invoice-service`).
- 5–8 groups is the target. If you can't group naturally, fall back to
  one entry per module — but flag this in the table notes.
- The Notes column lists the modules that belong to each group, in
  parentheses: `payment-service, billing-service, invoice-service`.
- Tip for grouping: prefix patterns (`auth-*`, `user-*`), shared
  dependencies, README hints, or the directory layout in `settings.gradle.kts`.

**multi-unit:**
- Each unit gets its own row.
- Status: `⏳ pending` for all.
- Notes: one sentence per unit describing what that unit computes/does.

For ALL shapes: **DO NOT create per-domain reference files now.** Only
the table in chapter 7. References are written lazily, on the first real
task that touches that domain — this is what keeps docs from going stale
before being read.

#### Chapter 7 table format

```
| Domain | Status | Reference | Notes |
|---|---|---|---|
| <name> | ⏳ pending | — | <one sentence; for grouped, list constituent modules> |
| <name> | ⏳ pending | — | <...> |
```

### 5. Verify before reporting done

- Re-read both files.
- Confirm no `<!-- TODO: ... -->` placeholders remain in mandatory
  chapters or the AGENTS.md sections you committed to filling.
- Confirm "Documentation" section in `AGENTS.md` is unchanged.
- Confirm chapter 7 table has entries proportionate to the repo shape
  (not 30 entries for 30 modules, not 1 entry for a true monorepo).

### 6. Stop and ask if ambiguous

Do NOT guess on these — pause and ask the user:

- Project's primary purpose, if README is missing or unclear.
- Canonical command set, if Makefile and root manifest disagree.
- **For multi-module: how to group modules** if naming patterns are
  ambiguous (e.g., "Should `notification-service` and `mailer-service`
  be one domain or two?"). Show your proposed grouping and ask.
- For multi-unit: confirm the unit-as-domain mapping is right, especially
  if some "units" look like shared utilities not standalone things.

## Hard rules

- **Do not invent information.** If a fact isn't in the repo, mark it
  with `<!-- TODO: needs human input — could not detect X -->`.
- **Do not create per-domain reference files** in this pass. Only the
  table in chapter 7.
- **Do not touch any code files** — this command writes only to
  `AGENTS.md` and `docs/architecture/README.md`.
- **For multi-module: never list 30 rows in chapter 7.** Group them.
  If you can't find a grouping, stop and ask the user.
