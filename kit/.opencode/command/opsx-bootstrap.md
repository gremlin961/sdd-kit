---
description: Bootstrap a brand-new project from a raw idea — no codebase yet
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/bootstrap.md.md. Bodies differ on purpose (OpenCode delegates to agents; the user runs tests), but STEP LOGIC must match — if you change steps here, change them there too.

Greenfield entry point (no code in the repo yet).

STEPS:
1. Confirm: project name, one-paragraph idea, GitHub repo exists? (SSH can't
   create repos — browser or gh CLI first.)
2. If not a repo yet: `git init -b main` in the project dir.
3. Run the greenfield blueprint workflow yourself (no subagent delegation —
   local model quality is best preserved by doing it in the main session):
   a. Ask the user up to 10 clarifying questions, batched. Priorities: scope,
      what "v1 done" means, hosting target, data model shape, riskiest unknown.
   b. Write openspec/project.md: what-this-is (3 sentences), stack WITH
      one-line rationale per choice, architecture skeleton (planned dirs,
      one line each), verification commands, generous Non-goals. Cap: ~80 lines.
   c. Write openspec/roadmap.md: ordered change-ids, each PR-sized, first is
      ALWAYS `bootstrap` (scaffold + tooling + first vertical slice + tests).
      Add an estimated-sessions column.
4. User reviews/edits both files. That review is the project's most important
   gate — do not rush it.
5. Copy openspec/changes/_TEMPLATE_/ to openspec/changes/bootstrap/ and draft
   the bootstrap change artifacts strictly from project.md.
6. User approves. STOP. Tell them: fresh session → /opsx-apply per task.

HARD RULES:
- No application code in this session. No `git push`.
- If the idea is vague, ask again rather than guess — a wrong project shape
  is the most expensive mistake in SDD.
