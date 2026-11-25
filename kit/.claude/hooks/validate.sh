#!/bin/bash
# SDD kit artifact validator: enforces the config.yaml rules that are
# otherwise just prompt text. Exit 1 = a rule is violated; print the
# violations. Wired into /opsx:verify (step 0) and usable standalone.
#
# Checks (per config.yaml):
#   - proposal.md      ≤ 500 words
#   - tasks.md         ≤ 15 tasks, every task names at least one file
#   - tasks.md         tasks use the '- [ ]'/'- [x]' checkbox format
#   - every scenario   has a matching test name recorded in tasks.md (grep-level)
set -euo pipefail

DIR="${1:-}"
if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then
  echo "usage: validate.sh <openspec/changes/<change-id>>" >&2
  exit 2
fi

fail=0
note() { echo "  ✗ $1"; fail=1; }

# --- proposal.md word count (≤500) ---
if [ -f "$DIR/proposal.md" ]; then
  WORDS=$(wc -w < "$DIR/proposal.md")
  if [ "$WORDS" -gt 500 ]; then
    note "proposal.md is $WORDS words (limit 500). Cut it — the proposal is a decision record, not an essay."
  else
    echo "  ✓ proposal.md $WORDS words (≤500)"
  fi
else
  note "proposal.md missing."
fi

# --- tasks.md checks ---
if [ -f "$DIR/tasks.md" ]; then
  TASKS=$(grep -c '^\s*- \[[ x]\]' "$DIR/tasks.md" || true)
  if [ "$TASKS" -gt 15 ]; then
    note "tasks.md has $TASKS tasks (limit 15). Split into another change."
  else
    echo "  ✓ tasks.md $TASKS tasks (≤15)"
  fi

  # every task names at least one file (backtick path, extension, or dir/)
  BAD=0
  while IFS= read -r line; do
    if ! echo "$line" | grep -qE '(`[^`]+\.[A-Za-z0-9]+`|[A-Za-z0-9_./-]+/)'; then
      BAD=$((BAD+1))
    fi
  done < <(grep '^\s*- \[[ x]\]' "$DIR/tasks.md" || true)
  if [ "$BAD" -gt 0 ]; then
    note "$BAD task(s) name no files — every task must list the files it touches."
  else
    echo "  ✓ all tasks name files"
  fi

  # checkbox format sanity: lines starting with a number but no checkbox
  MALFORMED=$(grep -cE '^\s*[0-9]+\. ' "$DIR/tasks.md" || true)
  if [ "$MALFORMED" -gt 0 ]; then
    note "$MALFORMED line(s) look like tasks but don't use the '- [ ]' checkbox format."
  fi
else
  note "tasks.md missing."
fi

# --- scenario → test mapping (grep-level: scenario names should appear in tasks.md) ---
if [ -d "$DIR/specs" ] && [ -f "$DIR/tasks.md" ]; then
  UNMAPPED=0
  while IFS= read -r scen; do
    KEY=$(echo "$scen" | sed 's/.*[Ss]cenario: *//; s/[][\.*^$(){}?+|/\\]//g' | cut -c1-40)
    [ -z "$KEY" ] && continue
    if ! grep -qiF "$KEY" "$DIR/tasks.md"; then
      UNMAPPED=$((UNMAPPED+1))
      echo "  ⚠ scenario not referenced in tasks.md: \"$scen\""
    fi
  done < <(grep -h 'Scenario:' "$DIR"/specs/*/spec.md 2>/dev/null || true)
  [ "$UNMAPPED" -eq 0 ] && echo "  ✓ all scenarios referenced in tasks.md"
fi

if [ "$fail" = "1" ]; then
  echo "VALIDATION FAILED for $(basename "$DIR")" >&2
  exit 1
fi
echo "VALIDATION OK for $(basename "$DIR")"
