---
description: Verify a completed change: tests + independent review + spec conformance
allowed-tools: Task, Read, Grep, Glob, Bash(git diff*), Bash(pytest*), Bash(ruff*)
---

> Parity: the OpenCode twin of this file is kit/.opencode/command/opsx-verify.md. Bodies differ on purpose (Claude dispatches subagents and runs tests in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Start the SDD verify phase. Verification is THREE things; run all three.

1. DETERMINISTIC: run `pytest tests/ -q` and `ruff check .` yourself and
   report exact output. Do not ask the agent to interpret — exit codes rule.
2. EVAL: for each scenario in openspec/changes/<active>/specs/, confirm a
   named test exercises it. List any scenario with no test as a gap.
3. REVIEW: dispatch the `spec-reviewer` subagent (Sonnet, read-only, it did
   NOT write this code) on the full diff vs main. It returns
   APPROVE / REQUEST CHANGES with findings.

If REVIEW = REQUEST CHANGES: report blocking findings to the user. Fixes go
through /opsx:apply as new tasks — never by editing the reviewer's findings
away in this session.

On full pass: tell the user to run /opsx:archive (they run it; you may not).
