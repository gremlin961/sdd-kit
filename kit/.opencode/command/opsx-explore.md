---
description: Explore the codebase read-only for a new OpenSpec change
---

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
