#!/bin/bash
# Stop hook: end-of-session gate. Reminds the model to stop after the checked
# task and tells you what to do next — this is what keeps sessions small.
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"
ACTIVE=$(find openspec/changes -maxdepth 1 -mindepth 1 -type d \
  ! -name '_TEMPLATE_' ! -name 'archive' | head -n 1 || true)
if [ -n "$ACTIVE" ]; then
  REMAINING=$(grep -c '^\- \[ \]' "$ACTIVE/tasks.md" || true)
  echo "Session end. Tasks remaining in $(basename "$ACTIVE"): ${REMAINING:-0}."
  echo "If >0: stop here. Next session starts fresh and reads only tasks.md."
  echo "Record actual cost with /cost before closing."
fi
