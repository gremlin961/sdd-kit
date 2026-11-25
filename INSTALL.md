# SDD Kit — Agent Installation Procedure

This document is written for AI coding agents (Claude Code, OpenCode) to
follow when the user says "install the SDD kit in this repo." It is the
single source of truth for installation. Follow it in order; do not skip
detection and do not guess the stack — the adapted templates ARE the value.

Note: if `~/.config/sdd-kit/repo` exists, the user has user-level init
commands (`/sdd-kit:init` in Claude Code, `/sdd-kit-init` in OpenCode) that
run Steps 1–4 of this procedure in the current project and then offer to
start explore or conceptualize immediately. Those commands defer to this
file for everything except their final handoff.

Source repo: this repository (the one containing this file). Everything the
install needs is inside it, under `kit/`. The kit's own documentation
(README.md, llms.txt, GREENFIELD.md) is NOT part of a target repo's payload
— GREENFIELD.md is the exception, see the tree below.

## The kit payload (kit/ → target repo root)

```
kit/AGENTS.md                          ← shared repo contract (both harnesses)
kit/CLAUDE.md                          ← thin Claude wrapper
kit/GREENFIELD.md                      ← greenfield flow doc (yes, ship this one)
kit/openspec/config.yaml               ← artifact rules
kit/openspec/changes/_TEMPLATE_/README.md   ← artifact shape example
kit/scripts/validate.sh                 ← artifact validator (HARNESS-NEUTRAL — install for BOTH)
kit/.claude/settings.json              ← permissions + 4 hooks
kit/.claude/hooks/{session_start,block_bulk_read,token_audit,session_end}.sh
kit/.claude/agents/{architect,ci-triage,spec-explorer,spec-reviewer,spec-writer}.md
kit/.claude/commands/opsx/{bootstrap,conceptualize,explore,propose,apply,verify,archive}.md
kit/.opencode/agent/{explorer,implementer,reviewer,spec-writer}.md
kit/.opencode/command/opsx-{bootstrap,conceptualize,explore,propose,apply,verify,archive}.md
```

NOTE: this repo does NOT ship `openspec/project.md`. Brownfield installs
create it in Step 4; greenfield repos get theirs from `/opsx:bootstrap`.
This repo's own distribution docs (root README.md, llms.txt, INSTALL.md)
are NOT payload — never copy them into a target repo.

## Step 1 — Detect repo state

In the TARGET repo root (not this kit repo):

1. `git rev-parse --is-inside-work-tree` — is it a git repo?
2. Inventory the root: `ls -A`.
3. Count source files: glob for
   `**/*.{py,ts,tsx,js,jsx,go,rs,java,kt,rb,php,cs,c,cpp,h,sh}` plus
   manifests (`package.json`, `pyproject.toml`, `requirements*.txt`,
   `go.mod`, `Cargo.toml`, `pom.xml`, `build.gradle`, `Gemfile`,
   `composer.json`, `*.csproj`).
4. Check for pre-existing SDD artifacts: `AGENTS.md`, `openspec/`, `.claude/`, `.opencode/`.

### Classification

| Condition | State |
|---|---|
| Zero source files AND zero manifests (docs like README/LICENSE only) | **GREENFIELD** |
| Any source file or manifest exists | **BROWNFIELD** |
| `AGENTS.md` or `openspec/` already present | **EXISTING KIT** — do not clobber |

**EXISTING KIT handling:** diff the incoming files against the existing
ones, show the user the conflicts, and merge non-destructively (their edits
to AGENTS.md/config.yaml win; kit-only files like hooks and commands install
unless the user objects). Never overwrite a user-edited contract file
without explicit approval.

## Step 2 — Detect harness preference

Ask the user ONE batched question (or infer): will this repo use **Claude
Code**, **OpenCode**, or **both**?

- **Both (default if unanswered):** install everything.
- **Claude Code only:** install everything EXCEPT `.opencode/`. Keep
  `AGENTS.md` (it is the shared contract; CLAUDE.md imports it).
- **OpenCode only:** install everything EXCEPT `.claude/` and `CLAUDE.md`.
  The kit deliberately ships NO `opencode.json` — model/provider config
  belongs to the user's global OpenCode config; never create or modify one.
  `kit/scripts/validate.sh` installs for EVERY harness choice — it is
  harness-neutral (plain bash reading openspec/ artifacts), so OpenCode
  users run it manually or via /opsx-verify; only the Claude hooks and
  agents stay Claude-only.

## Step 3 — Copy the kit

Copy the selected files from this repo's `kit/` into the target repo root,
preserving paths. `kit/scripts/validate.sh` → `scripts/validate.sh` (repo
root, not inside `.claude/`) for every harness choice. Then, if Claude
Code files were installed:

```bash
chmod +x .claude/hooks/*.sh scripts/validate.sh
```

If the target repo is not yet a git repo, note it — greenfield bootstrap
will `git init` later; do not init here unless the user asks.

## Step 4 — Adapt the templates to the detected state (the actual work)

### BROWNFIELD — inspect and fill

1. Identify the stack from manifests and directory layout: language,
   frameworks, test runner, lint command, where runtime code lives, where
   tests live.
2. **Edit `AGENTS.md`** — replace the `<!-- SDD-SETUP -->` placeholder
   Stack section with the detected reality: stack bullet points, exact
   test/lint commands, code and test directory locations. Keep every other
   section word-for-word (the discipline rules are the point).
3. **Edit `openspec/config.yaml`** — replace the placeholder Conventions
   section with the detected conventions (commit style if visible from
   `git log`, test file layout). Keep the artifact Rules section verbatim.
4. **Non-Python stacks: rewrite the settings.json allow entries.** The kit
   ships Python defaults (`Bash(pytest tests/ -q*)`, `Bash(ruff check .*)`)
   in the allow list. Replace them with allow entries matching the Stack
   section's exact test/lint commands (prefix form, e.g.
   `Bash(<test command>*)`), and confirm `apply.md`/`verify.md` will find
   the right commands in AGENTS.md (they read from there at runtime).
5. **Create `openspec/project.md`** — a machine-readable brief, ≤30 lines:
   what the project is (from README or a 1-minute look), architecture map
   of the main modules (one line each, file → purpose), verification
   commands, and Non-goals (mark as TBD — the user refines these at first
   explore).
6. **Template caveat:** `kit/openspec/changes/_TEMPLATE_/README.md`
   contains a rate-limiter EXAMPLE (Python/FastAPI/pytest by design — it
   illustrates the artifact shape). Say so; it is not a spec to implement.

### GREENFIELD — minimal touch

1. Do NOT create `openspec/project.md` — the `/opsx:bootstrap` flow creates
   it from the user's idea. Creating it now would put your guesses where
   the architect's questions should be.
2. Do NOT edit `AGENTS.md`'s Stack section — leave the placeholder;
   bootstrap fills it.
3. Leave `GREENFIELD.md` in place and point the user at it.

## Step 5 — Report and hand off

Tell the user, concisely:

1. **Detected state:** greenfield or brownfield (+ evidence in one line:
   "N source files, manifest X" or "empty repo").
2. **Installed:** file counts per harness half, hooks made executable.
3. **Adapted:** what you filled into AGENTS.md/config.yaml/project.md
   (brownfield) or deliberately left for bootstrap (greenfield).
4. **Next command** — exactly one line, based on state and harness:

| State | Claude Code | OpenCode |
|---|---|---|
| Greenfield | `/opsx:bootstrap` | `/opsx-bootstrap` |
| Brownfield | `/opsx:explore` (or `/opsx:conceptualize` if fuzzy) | `/opsx-explore` (or `/opsx-conceptualize`) |

5. **The one human gate to remember:** the user reviews/edits spec artifacts
   between phases. The agent never commits, never archives, never pushes.

## Hard rules

- Never create or modify `opencode.json` (global or project).
- Never overwrite existing `AGENTS.md` / `openspec/` content without showing
  the user the diff first.
- Do not run any opsx workflow commands as part of setup — this session
  installs; the next session starts the loop.
- Do not write application code, period.

## Updating an installed project (/sdd-kit:update, /sdd-kit-update)

Run in a project that already has the kit. Steps:

1. Resolve the kit source from `~/.config/sdd-kit/repo` (same as init). If
   the project has no kit (no AGENTS.md, no openspec/), STOP and point the
   user at init instead.
2. `git -C <source> pull --ff-only` to refresh the clone. Report the result;
   continue even if the pull fails (offline is fine, the local clone is
   still usable).
3. REFRESH unconditionally — these files are never user-adapted, overwrite
   them from `<source>/kit/`:
   `.claude/hooks/*`, `.claude/agents/*`, `.claude/commands/opsx/*`,
   `.claude/settings.json`, `.opencode/agent/*`, `.opencode/command/*`,
   `openspec/changes/_TEMPLATE_/`, `GREENFIELD.md`,
   `scripts/validate.sh`. Then `chmod +x .claude/hooks/*.sh
   scripts/validate.sh`.
4. REVIEW — these files may hold user edits; show a unified diff for each
   and ask keep-or-replace (default keep, user edits win):
   `AGENTS.md`, `CLAUDE.md`, `openspec/config.yaml`, `openspec/project.md`.
5. NEVER touch: `openspec/changes/*` (except `_TEMPLATE_`),
   `openspec/specs/*`, application code, `opencode.json`.
6. Report: files refreshed, review outcomes, clone commit short SHA.

## Uninstall

- User asked to remove the kit from THIS machine (not a project):
  run `uninstall.sh` from the kit clone (add `--purge` to also delete the
  clone; it refuses unless the marker file names the script's own dir).
  Script has the exact file list — never hand-roll the deletion.
- User asked to remove the kit from THIS project: that's git surgery plus
  judgment — see README "Removing the kit from a project". Preserve
  `openspec/changes/*` (excluding `_TEMPLATE_`) and `openspec/project.md`
  unless the user explicitly says the project is dead; those are the user's
  spec work, not kit plumbing.
