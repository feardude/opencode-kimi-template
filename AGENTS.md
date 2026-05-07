# AGENTS.md

> Шаблон. Перед использованием на рабочем репо — заполнить секции «Project
> Overview», «Commands», «Architecture» под свой проект. Секцию
> «Documentation» **не трогать** — это и есть переносимый паттерн.

This file provides guidance to AI coding assistants (OpenCode + Kimi K2.6,
Claude Code, etc.) when working with code in this repository.

## Project Overview

<!-- TODO: 2-3 предложения про проект: что это, кто пользователи, какая
основная ценность. Замени этот блок на содержимое из README или brief. -->

## Commands

### Development
```bash
# TODO: dev-команды (запуск dev-сервера, сборка, линт)
```

### Testing
```bash
# TODO: тесты (unit / e2e / coverage)
```

### Database / infra (если есть)
```bash
# TODO: db-миграции, локальный стек, деплой
```

## Architecture

> **Start here for any non-trivial work:** [`docs/architecture/README.md`](docs/architecture/README.md)
> gives the full system walkthrough; per-domain references live in
> [`docs/architecture/reference/`](docs/architecture/reference/). These docs
> exist specifically to shortcut the exploration you'd otherwise do by grep —
> read the relevant one before diving into code. See the Documentation section
> below for the full rules.

<!-- TODO: краткая высокоуровневая карта (стек, основные слои), ссылки на
основные директории. Подробности — в docs/architecture/. -->

## Documentation

Architecture docs live under `docs/architecture/`. These docs exist to
accelerate navigation — follow the rules in BOTH directions (read first,
update after).

1. **Read the reference before touching a domain.** Before non-trivial work
   on code that matches any `watches:` list in
   `docs/architecture/reference/*.md`, open that reference first. Its
   `Purpose`, `Entry points`, `Data flow`, and especially
   `Invariants & gotchas` sections will save grep-and-read rounds. Start of
   session and start of a new task are the natural moments. For cross-cutting
   work, also skim `docs/architecture/README.md` for the bigger picture.
2. **Reference update on code change.** Before creating any commit that
   modifies code, mentally run `git diff --cached --name-only` against every
   `watches:` list in `docs/architecture/reference/*.md`. For each reference
   whose `watches:` matches a changed path, update the reference and bump its
   `last_verified:` to today's date — in the same commit.
3. **README update on structural change.** If the change is structural (new
   code layer, new external service, new domain entity, code moving between
   layers), also update `docs/architecture/README.md`.
4. **Touching a pending domain.** If the task touches a domain marked
   `⏳ pending` in chapter 7 of `docs/architecture/README.md`, propose at the
   start of the task that a reference be created as part of this task. Let
   the user decide — they may decline, in which case the domain stays
   `pending`.
5. **Creating a brand-new domain.** If a change creates a domain not listed
   in chapter 7 (a new `src/components/<area>/` directory, or a new coherent
   group of Server Actions / API routes), ask the user whether to add a
   reference. Never create one silently.
