#!/usr/bin/env bash
# Bootstraps a target repo with AGENTS.md and docs/architecture/ skeletons.
# Idempotent: refuses to overwrite existing files. Pass --force to override.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

place() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && $FORCE -eq 0 ]]; then
    echo "  skip (exists): $dst"
  else
    mkdir -p "$(dirname "$dst")"
    cp -R "$src" "$dst"
    echo "  added:         $dst"
  fi
}

echo "==> Bootstrapping in: $(pwd)"
place "$SRC/AGENTS.md"                                 "./AGENTS.md"
place "$SRC/docs/architecture/README.md"               "./docs/architecture/README.md"
place "$SRC/docs/architecture/reference/_template.md"  "./docs/architecture/reference/_template.md"

echo
echo "Next step: let the agent fill these in."
echo "  In OpenCode (in this repo): /bootstrap-project"
echo
echo "Edit manually only if you prefer. As work progresses, copy"
echo "docs/architecture/reference/_template.md to reference/<domain>.md"
echo "on the first task that touches a new domain."
