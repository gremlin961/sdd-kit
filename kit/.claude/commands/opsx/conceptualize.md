---
description: Brainstorm a raw idea into concept.md (optional phase before /opsx:explore)
allowed-tools: Read, Write
---

Start the SDD conceptualize phase. This is a DIVERGENT thinking session —
the goal is to turn a half-formed idea into a structured concept.md, not to
design anything. Main session only: do NOT dispatch subagents. This is an
interview, not an investigation.

Steps:
1. Decide the change-id with the user (kebab-case, e.g. `add-rate-limiter`).
   The concept file will live at openspec/changes/<change-id>/concept.md.
2. Interview the user in small batches. Probe: what hurts today, who notices,
   what "done" looks like. CHALLENGE the idea — steelman the opposite position,
   name at least one alternative approach, and argue against their first
   instinct. A concept that names no alternative is not done.
3. Draft `openspec/changes/<change-id>/concept.md` from their answers, using
   the template below. Cap: ~60 lines. If a section can't be filled honestly,
   leave it as an open question instead of inventing an answer.
4. The user edits/approves the file. THIS IS THE GATE — the local-model or
   cheap-model draft is raw material, not authority.
5. STOP. Tell the user: fresh session → /opsx:explore. The concept's
   "Open questions" section becomes the explore phase's investigation list.

TEMPLATE (copy verbatim, fill, delete nothing):

# Concept: <one-line title, not a change-id yet>

> Status: DRAFT — this file is INPUT to explore/propose, not a spec.
> It is absorbed into proposal.md and never referenced after that.

## Problem
<!-- 3 sentences max. What hurts, for whom, today. No solutions here. -->

## Users / impact
<!-- Who notices this change? What do they see differently? -->

## Goals & success signal
<!-- ≤3 bullets, outcome-phrased (not implementation). The LAST bullet is
     the success signal: one observable thing true after this change that
     wasn't before. This becomes the verify phase's eval anchor. -->

## Approach sketch
<!-- 2-3 bullets, explicitly non-binding. The proposal may pick a different
     approach — this is a starting position, not a decision. -->

## Alternatives considered
<!-- At least one REQUIRED. If you can't name an alternative, you haven't
     thought about it yet — make the model argue against your sketch. -->

## Open questions
<!-- Things that MUST be answered before proposal. These become the
     explore phase's investigation questions, verbatim. -->
- [ ]

## Non-goals
<!-- Copy from openspec/project.md, extend for this change. No new scope. -->
- (inherited from openspec/project.md: ...)

HARD RULES:
- No source code, no file reads beyond openspec/project.md and the concept file.
- Do not copy the approach sketch into any spec artifact — the proposal
  compresses this file, it never inherits it blindly.
- This phase is OPTIONAL. For small obvious changes, skip straight to
  /opsx:explore.

DUAL-HARNESS NOTE: if the user also runs OpenCode with a local model, the
cheapest way to run this phase is THERE (divergent thinking is the local
model's best use, and re-rolls are free). The concept.md file is the handoff
into Claude Code's billed phases. If this session IS the local-model session,
just follow the steps above.
