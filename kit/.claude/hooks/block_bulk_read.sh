#!/bin/bash
# PreToolUse hook for Read: blocks bulk reads of source dirs, pushing the agent
# toward grep-first / spec-first behavior. Non-blocking advisory for spec files.
set -euo pipefail
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get("tool_input", {}).get("file_path", ""))
except Exception:
    print("")
')

case "$FILE_PATH" in
  openspec/*|.claude/*|.opencode/*)
    exit 0 ;;  # spec + config reads are always allowed and cheap
esac

# Block directory-wide sweep reads of common bulk targets
case "$FILE_PATH" in
  */__init__.py|*/conftest.py) exit 0 ;;
esac

if [ -d "$FILE_PATH" ]; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Bulk directory read blocked. Use Grep to find the 2-3 files the spec names, then read those individually."}}'
fi
