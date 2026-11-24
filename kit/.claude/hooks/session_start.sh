#!/bin/bash
# SessionStart hook: injects the minimal context bundle instead of letting the
# agent explore. Cheap: one small file read, done by the harness, not tokens
# burned on exploration.
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"

# Find the active change (first dir in openspec/changes that isn't _TEMPLATE_/archive)
ACTIVE=$(find openspec/changes -maxdepth 1 -mindepth 1 -type d \
  ! -name '_TEMPLATE_' ! -name 'archive' | head -n 1 || true)

if [ -n "$ACTIVE" ] && [ -f "$ACTIVE/tasks.md" ]; then
  PROGRESS=$(grep -c '^\- \[x\]' "$ACTIVE/tasks.md" || true)
  TOTAL=$(grep -c '^\- \[' "$ACTIVE/tasks.md" || true)
  cat <<EOF
Active change: $(basename "$ACTIVE")
Progress: ${PROGRESS:-0}/${TOTAL:-0} tasks complete.
Read ONLY: $ACTIVE/tasks.md, then the files each task names.
Do not explore the codebase. First unchecked task is your entire scope.
EOF
else
  echo "No active OpenSpec change. If the user asks for code changes, run the"
  echo "spec workflow first (see .claude/commands/opsx/). Do not improvise."
fi
