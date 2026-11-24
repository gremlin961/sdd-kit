# SDD Kit — spec-driven development for Claude Code and OpenCode

A copyable repo template implementing the spec-driven development (SDD)
workflow for **two harnesses**:

- **Claude Code** — Anthropic models via API key, Max subscription, or
  Bedrock/Vertex. Optimization target: dollars (or rate caps on subscription).
- **OpenCode** — any model you configure: local (Ollama, LM Studio, vLLM,
  llama.cpp), a hosted OpenAI-compatible endpoint, or even Anthropic models.
  Optimization target: context window + latency (tokens may be "free" but the
  window isn't — and small local models degrade fastest in long sessions).

The shared contract layer (`AGENTS.md`, `openspec/`, both command sets) is
identical for both, so the only variable is the harness and model.

## Repo layout (what lives where)

This repo is a distribution package, not a working project. Everything a
project receives is under `kit/`; the root holds only the docs an agent or
human reads to install it.

```
README.md     ← you are here
INSTALL.md    ← the canonical agent install procedure (single source of truth)
llms.txt      ← discovery file: point any coding agent here
kit/          ← the payload, copied verbatim into a target repo root:
  AGENTS.md                     ← shared repo contract (both harnesses read this)
  CLAUDE.md                     ← thin Claude wrapper: @AGENTS.md + $ discipline
  GREENFIELD.md                 ← greenfield flow doc
  openspec/
    config.yaml                 ← artifact rules (proposal ≤500w, tasks ≤15)
    changes/_TEMPLATE_/         ← the artifact shape (proposal/spec/design/tasks)
    (project.md is NOT shipped — brownfield setup creates it; bootstrap creates
     it for greenfield)
  .claude/
    settings.json               ← permissions (deny push/commit/bulk) + 4 hooks
    hooks/                      ← session_start, block_bulk_read, token_audit, session_end
    agents/architect.md         ← greenfield-only: idea → project.md + roadmap.md (Opus)
    agents/                     ← spec-explorer (Haiku), spec-reviewer (Sonnet),
                                  spec-writer (Sonnet), ci-triage (Haiku)
    commands/opsx/              ← /opsx:bootstrap :conceptualize :explore :propose :apply :verify :archive
  .opencode/
    agent/                      ← explorer, implementer, reviewer, spec-writer
                                  (no model pins — they inherit YOUR global provider config)
    command/                    ← /opsx-bootstrap -conceptualize -explore -propose -apply -verify -archive
```

## Installing into another project

### The quick way (user-level install, once per machine)

```bash
git clone https://github.com/gremlin961/sdd-kit ~/sdd-kit && ~/sdd-kit/install.sh
```

That copies the user-level command files to
`~/.claude/commands/sdd-kit/{init,update}.md` and
`~/.config/opencode/command/sdd-kit-{init,update}.md`, and records the
clone path. Then, in ANY project:

- **Claude Code:** `/sdd-kit:init` (install) · `/sdd-kit:update` (update)
- **OpenCode:** `/sdd-kit-init` (install) · `/sdd-kit-update` (update)

The init command follows [INSTALL.md](INSTALL.md) — detects
greenfield/brownfield/existing-kit, asks the harness question, copies
`kit/` from the clone (the repo stays the single source of truth; `git pull`
there updates every future init), adapts the templates to your stack, and
then asks how to start: **explore the repo** (concrete change, brownfield)
or **conceptualize first** (fuzzy idea) — and immediately runs that phase.
Greenfield repos get pointed at `/opsx:bootstrap` in a fresh session.

### Updating an installed project (`/sdd-kit:update`)

After `git pull` in the clone, run `/sdd-kit:update` (or `/sdd-kit-update`)
inside a project: it pulls the clone (`--ff-only`), **refreshes** files that
are never user-adapted (hooks, agents, opsx commands, settings.json,
`_TEMPLATE_`, GREENFIELD.md), **diffs** the user-adapted contract files
(`AGENTS.md`, `CLAUDE.md`, `openspec/config.yaml`, `openspec/project.md`)
and asks keep-or-replace per file — your edits win by default. It never
touches `openspec/changes/*`, `openspec/specs/*`, application code, or
`opencode.json`.

### The point-at-repo way (no user-level install)

Point your coding agent at this repo and say "install the SDD kit in this
repo." The agent reads [llms.txt](llms.txt) → follows
[INSTALL.md](INSTALL.md). Same procedure, no `install.sh` — useful on
machines you don't want to touch, or when you can't clone locally.

### Manual

Copy `kit/*` into your project root yourself, then fill the Stack section of
`AGENTS.md` and create `openspec/project.md` by hand (see INSTALL.md Step 4).

## Two entry points

- **Brownfield** (code exists): start at `/opsx:explore` — or `/opsx:conceptualize`
  first if the idea is fuzzy (see below).
- **Greenfield** (empty repo, just an idea): start at `/opsx:bootstrap` (Claude) or
  `/opsx-bootstrap` (OpenCode) — see **kit/GREENFIELD.md**. One expensive architecture
  session buys cheap sessions forever; from `bootstrap` onward the loop is identical.

## The optional conceptualize phase

For fuzzy ideas ("I think we should maybe add caching..."), run
`/opsx:conceptualize` (Claude) or `/opsx-conceptualize` (OpenCode) BEFORE
explore. It's a main-session interview that challenges the idea, forces one
named alternative, and drafts `openspec/changes/<id>/concept.md`. The
concept's "Open questions" become the explore phase's investigation list;
propose absorbs/compresses the concept into the proposal. For small obvious
changes, skip it — explore alone is fine. Dual-harness users: brainstorm in
OpenCode on a local model (free re-rolls), then run the billed phases in
Claude Code against the structured concept.md.

## After install (in the target repo)

```bash
chmod +x .claude/hooks/*.sh
# OpenCode users: nothing to configure — your global opencode.json provider
#   config applies as-is. This kit ships NO opencode.json by design: it never
#   touches your main config (models, providers, keys stay yours).
# Claude users: nothing to configure beyond auth.
git add -A && git commit -m "chore: SDD harness config (Claude Code + OpenCode)"
```

## Why each piece exists (the cost logic)

| Piece | Cost mechanism it attacks |
|---|---|
| `openspec/changes/<active>/` as the ONLY session context | Re-discovery: agent re-reading the codebase every session |
| One task per session, `/clear` between | Prefix resend: every turn re-bills the whole conversation |
| Subagents with scoped context (diff only, ≤5 files) | Reviewer/explorer burning 50K+ on repo-wide reads |
| Model tiering (Haiku explore/triage, Sonnet impl/review) | Paying frontier-model rates for grep |
| `block_bulk_read` hook | The #1 silent token sink: directory sweeps |
| Permission denies on `git commit/push`, `rm`, `curl` | Rework + incident cost, not tokens |
| Stable `AGENTS.md` (never edit mid-session) | Claude prompt-cache invalidation (~90% discount lost) |
| `session_end` hook forcing task-scoped stops | Context creep in long chats |
| Spec scenarios = GIVEN/WHEN/THEN = pytest cases | Eval cost; a scenario with no test is a gap you can see |

The asymmetry to remember: Claude Code bills tokens; self-hosted models bill
**context window and your patience**. The same discipline serves both, but
the failure modes differ — hosted sessions get *expensive*, local sessions
get *dumb* (long context degrades small models fastest).

## Side-by-side test protocol

Use the SAME change (rate limiter) against BOTH harnesses and compare.

### Round 1 — Claude Code
```bash
cd ~/git/your-repo
claude            # session 1: /opsx:explore  → answer questions → exit
claude            # session 2: /opsx:propose  → edit artifacts → exit
# you review + edit openspec/changes/<id>/ yourself. THIS IS THE GATE.
claude            # session 3: /opsx:apply    → one task → exit
claude            # repeat per task
claude            # final: /opsx:verify       → pytest + eval + reviewer
/opsx:archive     # you run it
```
Record after each session: `/cost` output (the hook also appends bash calls
to `.claude/cost.log`).

### Round 2 — OpenCode (same change, fresh branch or reset)
```bash
cd ~/git/your-repo
opencode          # /opsx-explore → /opsx-propose → /opsx-apply (per task)
                  # → /opsx-verify (reviewer agent) → /opsx-archive
```
Record after each session: tokens reported by OpenCode + wall-clock time +
whether output quality degraded toward the end of the session (the small-
model long-context signal).

### What to compare
1. **Total tokens / dollars** per phase (Claude) and per session (OpenCode).
2. **Re-rolls**: how many times did the agent redo work? Spec quality shows
   up here — cheap explore + review beats expensive fixes.
3. **Spec conformance**: did the diff implement exactly the scenarios?
4. **Session count**: per-task sessions should keep both harnesses' sessions
   small; if one needed `/compact`, the artifacts were too fat.
5. **The reviewer catches what the implementer breaks** — count findings by
   severity. If zero ever, the reviewer is rubber-stamping; tighten its prompt.

### Expected result
Claude Code with this config should land around 30-60% cheaper than an
unguided session doing the same change, mostly from (a) no re-discovery,
(b) no prefix-resend death spiral, (c) cheap-model exploration. Local models
won't show a dollar difference — their win shows up as *quality retention*
in sessions 4+ and in how many tasks fit in one context window.

## Notes / gotchas

- `.claude/settings.json` `env.ANTHROPIC_SMALL_FAST_MODEL` sets the background
  model; subagent `model:` fields set per-task tiering.
- Hooks use `$CLAUDE_PROJECT_DIR` so they work from any cwd.
- OpenCode permission keys use the exact strings above; `bash: {"*": "ask"}`
  with specific allows is the hybrid enforcement pattern (strict blocks for
  destructive actions, ask-gates elsewhere).
- **This kit deliberately ships no `opencode.json`.** Model providers, API
  keys, and global permissions belong in your own global OpenCode config
  (`~/.config/opencode/opencode.json`), not in a project template. The
  `.opencode/agent/*` files here are per-project only — they define agent
  behavior and tool restrictions, and inherit whatever model your global
  config provides. If a project genuinely needs per-project model or
  permission overrides, add a minimal `opencode.json` to THAT repo yourself;
  this template won't create one for you.
- The `_TEMPLATE_` dir is inert (excluded by hooks/find); copy it when starting
  a new change.
