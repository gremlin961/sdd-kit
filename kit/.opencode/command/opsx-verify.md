---
description: Verify a change: deterministic tests + spec-conformance eval + independent review
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/verify.md.md. Bodies differ on purpose (OpenCode delegates to agents; the user runs tests), but STEP LOGIC must match — if you change steps here, change them there too.

Run the verify phase. Verification is FOUR things:

0. VALIDATE: the user runs `bash .claude/hooks/validate.sh
   openspec/changes/<active>/` (OpenCode doesn't run hooks itself). Report
   its output verbatim; a failing validation is a REQUEST CHANGES on its
   own. This turns the config.yaml limits from prompt-text rules into
   checked ones.

1. DETERMINISTIC: the user runs the test and lint commands from the
   AGENTS.md Stack section in their own terminal. Report exit codes as the
   only accepted evidence.
2. EVAL: for each scenario in openspec/changes/<active>/specs/, confirm a
   named test exercises it. List untested scenarios as gaps.
3. REVIEW: delegate to the `reviewer` agent (read-only, did not write the
   code) on the full diff vs main. Report VERDICT + findings.

If REQUEST CHANGES: blocking findings become new tasks via /opsx-propose
amendment — never fixed ad hoc in this session.

On full pass: the user runs /opsx-archive manually. You never archive.
