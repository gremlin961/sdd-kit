---
description: Explore the codebase for a new change (read-only, cheap model)
allowed-tools: Task, Read, Grep, Glob, Bash(openspec *)
---

Start the SDD explore phase. Context budget: this session should cost almost
nothing — delegate ALL investigation.

Steps:
1. If there is no active change directory yet, decide the change-id with the
   user (kebab-case, e.g. `add-rate-limiter`).
2. If `openspec/changes/<change-id>/concept.md` exists, read it. Its
   "Open questions" section IS the investigation list — turn each into an
   investigation question. If no concept.md exists, phrase the user's
   feature request as ONE investigation question instead.
3. Dispatch the `spec-explorer` subagent (Haiku) with the investigation
   question(s). Give the subagent NO repository context beyond
   openspec/project.md and concept.md (if present).
3. Report the findings to the user verbatim. Ask the user any clarifying
   questions the findings raise. STOP — do not propose yet.
4. On user confirmation, hand off to /opsx:propose in a FRESH session.
