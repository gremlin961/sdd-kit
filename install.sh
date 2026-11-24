#!/usr/bin/env bash
# SDD kit — one-time machine install.
# Copies the /sdd-kit:init command files to user level and records the
# clone path. The cloned repo remains the single source of truth for the
# kit payload; `git pull` here updates every future project init.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.claude/commands/sdd-kit" "$HOME/.config/opencode/command" "$HOME/.config/sdd-kit"

cp "$KIT_DIR/init/claude-sdd-kit-init.md"   "$HOME/.claude/commands/sdd-kit/init.md"
cp "$KIT_DIR/init/opencode-sdd-kit-init.md" "$HOME/.config/opencode/command/sdd-kit-init.md"
printf '%s\n' "$KIT_DIR" > "$HOME/.config/sdd-kit/repo"

echo "SDD kit installed (user level)."
echo "  Kit source:   $KIT_DIR  (git pull here to update)"
echo "  Claude Code:  run  /sdd-kit:init   inside any project"
echo "  OpenCode:     run  /sdd-kit-init   inside any project"
