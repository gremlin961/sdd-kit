---
description: Archive a completed change (human-gated)
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/archive.md. Bodies differ on purpose (OpenCode delegates to agents; Claude dispatches subagents in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Archive the active OpenSpec change:

1. Confirm with the user that verify passed (all three legs).
2. Run: openspec archive <change-id>
3. Confirm the change moved to openspec/changes/archive/ and that
   openspec/specs/ reflects the new capability.
4. Remind the user to commit the archived spec — it is the durable record.

Human-gated. Never run automatically at the end of an implementation session.
