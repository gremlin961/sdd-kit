---
description: Explore the codebase read-only for a new OpenSpec change
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/explore.md.md. Bodies differ on purpose (OpenCode delegates to agents; the user runs tests), but STEP LOGIC must match — if you change steps here, change them there too.

Run the explore phase with the `explorer` subagent. Context budget: near zero.

STEPS:
1. Decide the change-id with the user (kebab-case).
2. If `openspec/changes/<change-id>/concept.md` exists, read it — its "Open
   questions" section IS the investigation list. If not, phrase the request
   as ONE question.
3. Delegate ALL investigation to the `explorer` agent with that
   question(s). Give it no context beyond openspec/project.md and
   concept.md (if present).
3. Report findings verbatim. Ask the user clarifying questions. STOP.
4. Hand off to /opsx-propose in a FRESH session.

This command never edits files.
