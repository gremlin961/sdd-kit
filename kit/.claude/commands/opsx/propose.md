---
description: Draft the OpenSpec change artifacts for user approval
allowed-tools: Task, Read, Write, Bash(openspec *)
---

> Parity: the OpenCode twin of this file is kit/.opencode/command/opsx-propose.md. Bodies differ on purpose (Claude dispatches subagents and runs tests in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Start the SDD propose phase. This session's output is the NEXT session's
context — keep the artifacts lean per the spec-writer agent's budget rules.

Steps:
1. Read ONLY: openspec/project.md and the exploration findings (user pastes
   them, or they are in openspec/changes/<id>/exploration.md if saved).
   If concept.md exists, read it as INPUT — but COMPRESS it: the proposal's
   Why/What/Non-goals absorb the concept. Do not copy sections verbatim;
   the concept is disposable once the proposal exists.
2. Dispatch the `spec-writer` subagent (Sonnet) to draft:
   proposal.md, specs/<capability>/spec.md, design.md (only if >3 files),
   tasks.md — under openspec/changes/<change-id>/.
3. Present the proposal to the user. Do NOT write any source code.
4. The user edits/approves the artifacts. If they edit by hand, re-read the
   edited files before proceeding.
5. On approval, tell the user: start a FRESH session and run /opsx:apply.
