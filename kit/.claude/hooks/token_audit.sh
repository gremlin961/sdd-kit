#!/bin/bash
# PostToolUse hook: appends a running cost/audit line to .claude/cost.log after
# every Bash call. Gives you a per-session ledger without asking the model.
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"
INPUT=$(cat)
CMD=$(echo "$INPUT" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get("tool_input", {}).get("command", "")[:120])
except Exception:
    print("")
' 2>/dev/null || true)
echo "$(date +%H:%M:%S) bash: $CMD" >> .claude/cost.log
exit 0
