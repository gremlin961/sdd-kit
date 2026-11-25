---
description: Verify a change: deterministic tests + spec-conformance eval + independent review
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/verify.md. Bodies differ on purpose (OpenCode delegates to agents; Claude dispatches subagents in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Run the verify phase. Verification is FOUR things:

0. VALIDATE: run `scripts/validate.sh openspec/changes/<active>/` yourself
   and include its output verbatim. A failing validation (proposal >500
   words, >15 tasks, tasks without named files) is a REQUEST CHANGES on its
   own — fix the artifacts before reviewing code. This turns the
   config.yaml limits from prompt-text rules into checked ones.

1. DETERMINISTIC: run the test and lint commands from the AGENTS.md Stack
   section yourself (exactly as written there). Report the VERBATIM output
   and the EXIT CODE of each command — raw output is the evidence, never a
   summary like "all tests pass". If a command cannot run, report the
   error verbatim instead of claiming success.
2. EVAL: for each scenario in openspec/changes/<active>/specs/, confirm a
   named test exercises it. List untested scenarios as gaps.
3. REVIEW: delegate to the `reviewer` agent (read-only, did not write the
   code) on the full diff vs main. Report VERDICT + findings.

If REQUEST CHANGES: blocking findings become new tasks via /opsx-propose
amendment — never fixed ad hoc in this session.

On full pass: the user runs /opsx-archive manually. You never archive.
