---
description: Verify a completed change: tests + independent review + spec conformance
allowed-tools: Task, Read, Grep, Glob, Bash
---

> Parity: the OpenCode twin of this file is kit/.opencode/command/opsx-verify.md. Bodies differ on purpose (Claude dispatches subagents and runs tests in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Start the SDD verify phase. Verification is FOUR things; run all four.

0. VALIDATE: run `scripts/validate.sh openspec/changes/<active>/` and
   include its output verbatim. A failing validation (proposal >500 words,
   >15 tasks, tasks without named files) is a REQUEST CHANGES on its own —
   fix the artifacts before reviewing code. This turns the config.yaml
   limits from prompt-text rules into checked ones.

1. DETERMINISTIC: run the test and lint commands from the AGENTS.md Stack
   section yourself (exactly as written there) and report exact output. Do
   not ask the agent to interpret — exit codes rule.
2. EVAL: for each scenario in openspec/changes/<active>/specs/, confirm a
   named test exercises it. List any scenario with no test as a gap.
3. REVIEW: dispatch the `spec-reviewer` subagent (Sonnet, read-only, it did
   NOT write this code) on the full diff vs main. It returns
   APPROVE / REQUEST CHANGES with findings.

If REVIEW = REQUEST CHANGES: report blocking findings to the user. Fixes go
through /opsx:apply as new tasks — never by editing the reviewer's findings
away in this session.

On full pass: tell the user to run /opsx:archive (they run it; you may not).
