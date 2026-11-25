---
description: Implement the next unchecked task (one task per session)
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/apply.md. Bodies differ on purpose (OpenCode delegates to agents; Claude dispatches subagents in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Run the apply phase with the `implementer` agent.

STEPS:
1. Load the `implementer` agent. It implements exactly the first `- [ ]`
   task in openspec/changes/<active>/tasks.md, test-first.
2. It reports: task done, exact test/lint output (commands from the
   AGENTS.md Stack section), `git diff --stat`.
3. If tasks remain, tell the user to start a FRESH session and re-run
   /opsx-apply. Do not chain tasks in one session.

EVIDENCE RULE: "the agent says tests pass" is not evidence. The implementer
must run the test and lint commands itself (from the AGENTS.md Stack
section) and report VERBATIM output plus exit codes — raw output, never a
summary. The user may still re-run them in their own terminal; treat that
as the gold standard when it happens.
