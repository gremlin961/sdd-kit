# Greenfield quick-start: idea → running project (both harnesses)

When the repo is empty (README at most), the SDD loop inverts: there is
nothing to explore, so the expensive phase moves UP FRONT to architecture.
You pay one expensive session to buy cheap sessions forever after.

## The flow (3 phases)

```
IDEA ──► (optional: CONCEPTUALIZE — brainstorm with a local/cheap model,
      │        draft concept.md if the idea is still fuzzy)
      └──► BOOTSTRAP (1 expensive session, Opus-grade)     ← the only costly one
           ──► BOOTSTRAP CHANGE (spec artifacts, you review)  ← the real gate
           ──► THE NORMAL LOOP (per-task sessions, cheap)     ← identical to brownfield
```

### Phase 1 — /opsx:bootstrap (or /opsx-bootstrap in OpenCode)

One session. The `architect` agent (Opus on Claude Code; the MAIN session on
OpenCode — don't delegate architecture to a subagent on local models) asks
you up to 10 batched clarifying questions, then writes:

- `openspec/project.md` — what it is, stack WITH rationale, planned
  architecture skeleton, verification commands, **generous non-goals**
- `openspec/roadmap.md` — ordered PR-sized change-ids, first is always
  `bootstrap` (scaffold + tooling + first vertical slice + tests)

**You edit both files before anything else happens.** This review is the
highest-leverage 30 minutes in the whole project — every future session
inherits your corrections for free, and every mistake you miss gets paid for
repeatedly.

### Phase 2 — the bootstrap change

The spec-writer drafts `openspec/changes/bootstrap/` artifacts STRICTLY from
project.md (not vibes). You approve. Still no application code.

### Phase 3 — the normal loop

Fresh session → /opsx:apply per task → verify → archive → next roadmap item.
From here, greenfield is identical to the brownfield flow; the only
difference is that `project.md` + `roadmap.md` are the durable context
instead of an existing codebase.

## Greenfield-specific rules (already baked into the commands)

1. **Non-goals do the constraining.** No legacy code means nothing stops the
   agent from gold-plating. Non-goals in project.md are the only fence — be
   generous, they're cheap to write and expensive to lack.
2. **Stack rationale is law.** Every stack choice gets a one-line "why" in
   project.md so no future agent relitigates it at 2am in a random session.
3. **First roadmap item is always `bootstrap`** — scaffold, tooling, tests
   running, one vertical slice. Never "build features" first; a repo with no
   test harness makes every later task more expensive.
4. **The architect session is the only expensive one.** Opus there, Sonnet/
   Haiku everywhere after. On OpenCode with local models, do architecture in
   the main session with maximum context budget — don't delegate it to a
   subagent, and don't rush it: a small model's architecture session IS your
   architecture review.
5. **Roadmap ≠ spec.** Roadmap items are one-liners; they only become real
   artifacts when you pull them via the normal propose flow. Don't spec
   change #7 while working on #1 — the spec for later items will be wrong by
   the time you get there.

## Token reality check

The bootstrap session should run ~$1-3 on Claude API (Opus, one-shot). Every
task session after should run $0.10-0.50 because it reads one tasks.md, three
files, writes tests, done. A project that skips Phase 1 and vibes its way
through Phase 3 pays the Opus cost — repeatedly, badly, with no artifact to
show for it — every single session.
