#!/bin/bash
# Stop hook: end-of-session gate. Validates artifact limits (proposal word
# count, task count, checkbox format) and reminds the model to stop after the
# checked task — this is what keeps sessions small and artifacts in spec.
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"
ACTIVE=$(find openspec/changes -maxdepth 1 -mindepth 1 -type d \
  ! -name '_TEMPLATE_' ! -name 'archive' | head -n 1 || true)
if [ -n "$ACTIVE" ]; then
  if [ -x .claude/hooks/validate.sh ]; then
    .claude/hooks/validate.sh "$ACTIVE" || true   # report, never block the stop
  fi
  REMAINING=$(grep -c '^\- \[ \]' "$ACTIVE/tasks.md" || true)
  echo "Session end. Tasks remaining in $(basename "$ACTIVE"): ${REMAINING:-0}."
  echo "If >0: stop here. Next session starts fresh and reads only tasks.md."
  echo "Record actual cost with /cost before closing."
fi
