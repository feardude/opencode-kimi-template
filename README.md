# OpenCode + Kimi K2.6 — шаблон под рабочий ноут

Этот каталог — переносимый шаблон, повторяющий схему работы с
документацией и скиллами, отлажённую в Sistrum. Цель — поднять на рабочем
ноуте (OpenCode + Kimi K2.6 on-prem) аналогичный опыт.

## Что внутри

```
.
├── AGENTS.md                          # инструкция для модели (читается
│                                       OpenCode и Claude Code; на работе —
│                                       канонический файл, без CLAUDE.md)
├── docs/architecture/
│   ├── README.md                      # шаблон обзора архитектуры (главы 1–7)
│   └── reference/
│       └── _template.md               # шаблон per-domain reference с
│                                       watches: и last_verified:
└── .claude/
    ├── skills/                        # 16 скиллов (cross-tool путь, видят
    │   ├── brainstorming/             # оба харнеса)
    │   ├── systematic-debugging/
    │   ├── verification-before-completion/
    │   ├── writing-plans/
    │   ├── executing-plans/
    │   ├── test-driven-development/
    │   ├── receiving-code-review/
    │   ├── requesting-code-review/
    │   ├── subagent-driven-development/
    │   ├── dispatching-parallel-agents/
    │   ├── using-git-worktrees/
    │   ├── finishing-a-development-branch/
    │   ├── writing-skills/
    │   ├── using-superpowers/
    │   ├── frontend-design/
    │   └── skill-creator/
    ├── agents/                        # сабагенты из feature-dev
    │   ├── code-architect.md
    │   ├── code-explorer.md
    │   └── code-reviewer.md
    └── commands/
        └── feature-dev.md             # /feature-dev слэш-команда
```

## Как разворачивать на рабочем ноуте

1. Распаковать архив в корень целевого репо.
2. Заполнить `AGENTS.md` (секции «Project Overview», «Commands»,
   «Architecture»). Секцию «Documentation» НЕ трогать — это и есть
   переносимый паттерн.
3. Заполнить `docs/architecture/README.md` (главы 1, 2, 5 обязательны).
4. По мере работы создавать per-domain reference в
   `docs/architecture/reference/` по шаблону `_template.md`. Каждая
   reference перечисляет файлы/глобы под `watches:` — это триггер для
   правила «read before / update after».
5. Скиллы и сабагенты подхватятся автоматически:
   - **OpenCode** читает `.claude/skills/` (Claude-compat путь) и
     `.claude/agents/`, `.claude/commands/` — проверь в логах при первом
     запуске. Если что-то не подцепляется, продублируй в `.opencode/skills/`,
     `.opencode/agents/`, `.opencode/commands/` симлинками.
   - **Claude Code** (если будет) читает все три из коробки.

## Главный риск — поведение Kimi

Скиллы и доки физически на месте — это полдела. Реальный вопрос: будет ли
Kimi K2.6 столь же дисциплинированно следовать инструкциям из `AGENTS.md`,
как Opus. Что проверить **сразу**:

- открывает ли модель `docs/architecture/reference/<domain>.md` перед
  правкой watched-путей (правило 1 в Documentation-секции)
- обновляет ли `last_verified:` после изменений (правило 2)
- срабатывают ли skill-триггеры (особенно `verification-before-completion`,
  `brainstorming`, `systematic-debugging`)

Если поведение слабое — добавить плагин на `tool.execute.before` в
`.opencode/plugins/` (TS), который перед `Edit`/`Write` в watched-путь
выводит warning «прочитал ли ты <reference>?». OpenCode плагин-API:
https://opencode.ai/docs/plugins/

## Что НЕ перенесено (сознательно)

- **Hooks** (peon-ping звуки, claude-island-state) — Claude-Code-специфика,
  чисто UX, не влияет на качество работы.
- **Auto-memory** (`~/.claude/projects/.../memory/`) — Claude-Code-харнес-
  специфика. Захочешь — реализуется как OpenCode-плагин на TS, но это
  отдельная задача.
- **Permissions allowlist** — переписывать с нуля под фактические команды
  на работе.
- **MCP servers** — не было в скоупе переноса; конфиг под каждый проект
  отдельно.
