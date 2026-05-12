#!/usr/bin/env bash
# Installs skills, agents, and commands globally for OpenCode.
# Idempotent: safe to re-run after `git pull`.
set -euo pipefail

DEST="${OPENCODE_CONFIG_HOME:-$HOME/.config/opencode}"
SRC="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing to: $DEST"
mkdir -p "$DEST/skills" "$DEST/agents" "$DEST/commands"

echo "==> Skills"
cp -R "$SRC/.claude/skills/." "$DEST/skills/"

echo "==> Agents"
cp -R "$SRC/.claude/agents/." "$DEST/agents/"

echo "==> Commands"
cp -R "$SRC/.claude/commands/." "$DEST/commands/"

echo
echo "Installed:"
echo "  Skills:   $(ls "$DEST/skills"   | wc -l | tr -d ' ')"
echo "  Agents:   $(ls "$DEST/agents"   | wc -l | tr -d ' ')"
echo "  Commands: $(ls "$DEST/commands" | wc -l | tr -d ' ')"

if [[ ! -f "$DEST/opencode.json" ]]; then
  echo
  echo "==> No $DEST/opencode.json found"
  echo "   Copy the template and fill in Kimi endpoint:"
  echo "     cp $SRC/opencode.json.example $DEST/opencode.json"
  echo "     edit  $DEST/opencode.json"
fi

echo
echo "Per-repo setup: in each work repo run"
echo "  $SRC/init-project.sh"
