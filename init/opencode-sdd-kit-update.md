---
description: Update this project's SDD kit files from the cloned sdd-kit repo (refreshes harness files, leaves user-adapted contract files alone unless approved)
---

Update the SDD kit in the CURRENT project from the cloned sdd-kit repo.
The clone path is in `~/.config/sdd-kit/repo`; if missing, ask the user.

STEPS:

1. Resolve the source: read `~/.config/sdd-kit/repo`, verify
   `<source>/kit/AGENTS.md` exists. If this project has no kit
   (no `AGENTS.md` and no `openspec/`), STOP and tell the user to run
   `/sdd-kit-init` instead.
2. Update the clone: run `git -C <source> pull --ff-only`. If it fails,
   report the error and continue with the current clone state.
3. REFRESH (copy over unconditionally — these are never user-adapted):
   `.opencode/agent/*`, `.opencode/command/*`, `openspec/changes/_TEMPLATE_/`,
   `GREENFIELD.md`, and if present `.claude/hooks/*`, `.claude/agents/*`,
   `.claude/commands/opsx/*`, `.claude/settings.json` (chmod +x hooks).
4. REVIEW (user-adapted; show a unified diff for each and ask keep-or-
   replace, defaulting to keep): `AGENTS.md`, `CLAUDE.md`,
   `openspec/config.yaml`, `openspec/project.md` (if present). The user's
   edits (stack, conventions) always win unless they explicitly approve
   the replacement.
5. NEVER touch: `openspec/changes/*` (except `_TEMPLATE_`),
   `openspec/specs/*`, any application code, `opencode.json`.
6. Report: files refreshed, files reviewed and their outcomes, current
   clone commit (`git -C <source> rev-parse --short HEAD`).
