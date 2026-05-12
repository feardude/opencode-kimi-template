# OpenCode + Kimi K2.6 — шаблон под рабочий ноут

Этот каталог — переносимый шаблон, повторяющий схему работы с
документацией и скиллами, отлажённую в Sistrum. Цель — поднять на рабочем
ноуте (OpenCode + Kimi K2.6 on-prem) аналогичный опыт.

## Что внутри

```
.
├── install.sh                         # глобальная установка скиллов/агентов/команд
├── init-project.sh                    # bootstrap AGENTS.md + docs/ в репо
├── opencode.json.example              # шаблон конфига с Kimi-провайдером
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

## Установка

Два слоя: **глобальный** (один раз на ноут — скиллы, сабагенты, команды)
и **per-project** (в каждом рабочем репо — `AGENTS.md` и
`docs/architecture/`).

### 1. Глобально, один раз на ноут

```bash
git clone https://github.com/feardude/opencode-kimi-template.git ~/opencode-kimi-template
cd ~/opencode-kimi-template
./install.sh
```

Скрипт идемпотентно копирует:
- `.claude/skills/`   → `~/.config/opencode/skills/`
- `.claude/agents/`   → `~/.config/opencode/agents/`
- `.claude/commands/` → `~/.config/opencode/commands/`

После — настроить эндпоинт Kimi (если ещё нет `~/.config/opencode/opencode.json`):

```bash
cp opencode.json.example ~/.config/opencode/opencode.json
# отредактировать baseURL и apiKey под on-prem-эндпоинт Райфа
```

### 2. В каждом рабочем репо

```bash
cd /path/to/work-repo
~/opencode-kimi-template/init-project.sh
```

Скрипт добавляет (только если ещё нет — не перезатирает):
- `AGENTS.md` — заполнить TODO под проект
- `docs/architecture/README.md` — главы 1, 2, 5 минимум
- `docs/architecture/reference/_template.md` — копировать в
  `<domain>.md` по мере появления доменов

Передать `--force`, чтобы перезатереть.

После запуска — закоммитить эти файлы в репо. Дальше команда работает с
ними как с обычной документацией.

### 3. Обновление

```bash
cd ~/opencode-kimi-template
git pull
./install.sh   # доливает новые скиллы/агентов/команды
```

### Масштабирование на команду

Дай коллегам три команды:

```bash
git clone https://github.com/feardude/opencode-kimi-template.git ~/opencode-kimi-template
~/opencode-kimi-template/install.sh
cp ~/opencode-kimi-template/opencode.json.example ~/.config/opencode/opencode.json
# заполнить baseURL/apiKey
```

В рабочих репо — `~/opencode-kimi-template/init-project.sh` один раз.
`AGENTS.md` и `docs/architecture/` уезжают в git того же репо, поэтому
дальнейшие правки доков расходятся обычным `git pull`-ом — настройку на
ноуте трогать не нужно.

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
