---
description: Install the SDD kit into this project from the cloned sdd-kit repo (detects greenfield/brownfield, adapts templates, offers to start the first phase)
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Task
---

Install the SDD kit into the CURRENT project. The kit source is a cloned
repo; its path is recorded in `~/.config/sdd-kit/repo` (written by the
repo's install.sh). If that file is missing, ask the user for the clone
path and verify it contains `kit/`.

STEPS:

1. Resolve the source: read `~/.config/sdd-kit/repo`. Verify
   `<source>/kit/AGENTS.md` exists. If not, STOP and ask for the path.
2. Follow `<source>/INSTALL.md` Steps 1–4 EXACTLY: detect repo state
   (greenfield / brownfield / existing-kit) → ask the one harness question
   → copy `kit/` from `<source>/kit/` into this repo preserving paths and
   `chmod +x .claude/hooks/*.sh` → adapt the `<!-- SDD-SETUP -->` template
   placeholders. INSTALL.md is the canonical procedure; this command only
   changes the FINAL HANDOFF (step 3 below).
3. Final handoff (replaces INSTALL.md Step 5):
   - GREENFIELD: tell the user the next step is `/opsx:bootstrap` (fresh
     session) and STOP. Do not run bootstrap now.
   - BROWNFIELD: ask ONE question — "Start by exploring the repo, or
     conceptualize first?" (Conceptualize if the idea is fuzzy; explore if
     it's concrete and scoped.) Then, on their answer, read the matching
     command file from `<source>/kit/.claude/commands/opsx/` — `explore.md`
     or `conceptualize.md` — and follow it NOW in this session. Both are
     cheap phases: explore dispatches the Haiku spec-explorer subagent;
     conceptualize is a main-session interview.
4. Hard rules (from INSTALL.md): never create or modify `opencode.json`;
   never overwrite existing `AGENTS.md`/`openspec/` content without showing
   the diff first; no application code; do not commit or push.
