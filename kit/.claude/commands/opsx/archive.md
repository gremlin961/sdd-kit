---
description: Archive a completed OpenSpec change and fold it into spec history
allowed-tools: Bash(openspec *), Read
---

> Parity: the OpenCode twin of this file is kit/.opencode/command/opsx-archive.md. Bodies differ on purpose (Claude dispatches subagents and runs tests in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Archive the active change:
1. Confirm with the user that verify passed (tests + eval + review).
2. Run: openspec archive <change-id> (or the current CLI equivalent).
3. Confirm the change moved to openspec/changes/archive/ and the specs/
   directory reflects the new capability.
4. Remind the user to commit: the archived spec is the durable record.

This is a human-gated action. Never run archive as part of an implementation
session.
