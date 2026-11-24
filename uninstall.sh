#!/usr/bin/env bash
# SDD kit — machine-level uninstall.
# Removes the user-level files created by install.sh. Does NOT touch any
# project that has the kit installed; see README "Removing the kit from a
# project" for that (it's git surgery, and your spec artifacts deserve care).
#
# Usage:
#   ./uninstall.sh           remove user-level command files + marker
#   ./uninstall.sh --purge   also delete the kit clone (this repo dir)
set -euo pipefail

PURGE=0
[ "${1:-}" = "--purge" ] && PURGE=1

CLAUDE_DIR="$HOME/.claude/commands/sdd-kit"
OPENCODE_DIR="$HOME/.config/opencode/command"
MARKER_DIR="$HOME/.config/sdd-kit"

removed=0
# Capture the marker BEFORE removing anything — the --purge safety check
# needs it, and we're about to delete it.
MARKER_VALUE=""
[ -f "$MARKER_DIR/repo" ] && MARKER_VALUE="$(cat "$MARKER_DIR/repo")"
for f in "$CLAUDE_DIR/init.md" "$CLAUDE_DIR/update.md" \
         "$OPENCODE_DIR/sdd-kit-init.md" "$OPENCODE_DIR/sdd-kit-update.md"; do
  if [ -f "$f" ]; then
    rm "$f"
    echo "removed: $f"
    removed=1
  fi
done

# Remove the marker file, then the dir only if nothing else lives in it.
if [ -f "$MARKER_DIR/repo" ]; then
  rm "$MARKER_DIR/repo"
  echo "removed: $MARKER_DIR/repo"
fi
if [ -d "$MARKER_DIR" ]; then
  rmdir "$MARKER_DIR" 2>/dev/null && echo "removed: $MARKER_DIR" || \
    echo "kept: $MARKER_DIR (contains other files — remove manually if intended)"
fi

# Drop empty dirs we may have created.
rmdir "$CLAUDE_DIR" 2>/dev/null || true
[ "$removed" = "1" ] && echo "SDD kit commands removed (user level)." || \
  echo "Nothing to remove — no SDD kit user-level files found."

# --purge: also delete the clone itself. Requires the captured marker value
# to name this directory so we never purge an arbitrary directory by accident.
if [ "$PURGE" = "1" ]; then
  KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [ -n "$MARKER_VALUE" ] && [ "$MARKER_VALUE" = "$KIT_DIR" ]; then
    echo "purging clone: $KIT_DIR"
    rm -rf "$KIT_DIR"
  else
    echo "refusing to purge: marker file missing or points elsewhere."
    echo "Delete the clone manually if that's what you want: rm -rf $KIT_DIR"
  fi
fi
