---
description: Bootstrap a brand-new project from a raw idea — no codebase yet
allowed-tools: Task, Read, Write, Bash(git init*), Bash(mkdir*), Bash(git add*), Bash(git commit*)
---

> Parity: the OpenCode twin of this file is kit/.opencode/command/opsx-bootstrap.md. Bodies differ on purpose (Claude dispatches subagents and runs tests in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Greenfield entry point. Use this INSTEAD of /opsx:explore when the repo has
no code (README only, or not even that).

Steps:
1. Confirm with user: project name, one-paragraph idea, GitHub repo exists?
   (git over SSH cannot create repos — browser or gh first.)
2. If the repo doesn't exist locally: `git init -b main` in the project dir.
3. Dispatch the `architect` subagent (Opus — the one expensive session) with
   the idea. It produces openspec/project.md + openspec/roadmap.md and asks
   up to 10 clarifying questions first. Relay those to the user verbatim.
4. User reviews/edits both files. Ask: approve as-is?
5. Copy openspec/changes/_TEMPLATE_/ to openspec/changes/bootstrap/ and have
   the spec-writer agent draft the bootstrap change artifacts (scaffold,
   tooling, first vertical slice, tests) from project.md — NOT from vibes.
6. User approves the bootstrap artifacts. Then STOP.
7. Tell the user: fresh session → /opsx:apply per task, exactly as in the
   brownfield flow. From here on, greenfield and brownfield are the same loop.

HARD RULES:
- Do not write a single line of application code in this session.
- Do not git push. Do not scaffold beyond what the bootstrap change specced.
- If the user's idea is vague, ask more questions instead of guessing —
  guessing at the project's shape is the most expensive mistake in SDD.
