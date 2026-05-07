# <Project> Architecture

> Шаблон. Заполни главы под свой проект; структура (1–7) — переносимая.
> Главы 1, 2, 5 — обязательны. Главы 3, 4, 6, 7 — по необходимости.

## 1. What this is and who it's for

<!-- 2-4 абзаца:
- что делает система (на уровне основной ценности, без архитектурных деталей)
- основные пользовательские journey (a/b/c/d)
- для кого эта документация (инженеры, новые в проекте)
- куда смотреть за командами и repo rules (AGENTS.md в корне) — не дублируй
-->

---

## 2. Architecture map

<!-- ASCII-диаграмма основных слоёв и внешних сервисов. Пример:

```
┌──────────────────────────────────────┐
│  Frontend / Backend stack            │
└──────────┬───────────────────────────┘
           │
    ┌──────┴──────┐
    ▼             ▼
┌─────────┐  ┌──────────┐
│  DB      │  │  External│
└─────────┘  └──────────┘
```
-->

---

## 3. Domain model

<!-- Сущности и отношения между ними. Можно текстом, можно псевдо-ER:

```
Users → Projects (many-to-many)
  → Documents → Versions
```
-->

---

## 4. Code layout

<!-- Краткая карта основных директорий: что где лежит. Пример:

- `src/app/` — routes
- `src/lib/actions/` — server-side write logic
- `src/components/` — UI

Подробности — в per-domain reference из главы 7.
-->

---

## 5. Key patterns

<!-- Список конвенций, которые применяются по всему коду. Пример:

- ES Modules only
- Server Components by default; `'use client'` только для интерактива
- Forms — React Hook Form + Zod
- Path alias: `@/*` → `src/*`
-->

---

## 6. External services

<!-- Перечень внешних зависимостей: что, для чего, какие credentials, где
конфиг. Пример:

- Supabase (Auth + DB) — env: `SUPABASE_URL`, ...
- S3 (storage) — ...
-->

---

## 7. Domain references

| Domain | Status | Reference |
|---|---|---|
| <domain-1> | ✅ ready | [`reference/<domain-1>.md`](reference/<domain-1>.md) |
| <domain-2> | ⏳ pending | — |

> **Status legend:**
> - ✅ ready — reference exists and is verified
> - ⏳ pending — domain identified but reference not yet written (см.
>   правило 4 в `AGENTS.md`)
