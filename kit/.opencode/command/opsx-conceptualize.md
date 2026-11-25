---
description: Brainstorm a raw idea into concept.md (optional phase before /opsx-explore)
---

> Parity: the Claude Code twin of this file is kit/.claude/commands/opsx/conceptualize.md. Bodies differ on purpose (OpenCode delegates to agents; Claude dispatches subagents in-session), but STEP LOGIC must match — if you change steps here, change them there too.

Run the conceptualize phase in the MAIN session — no subagent delegation.
Divergent thinking is the one phase where a local model's free re-rolls are
an advantage; don't waste them delegating.

STEPS:
1. Decide the change-id with the user (kebab-case, e.g. `add-rate-limiter`).
   The concept file will live at openspec/changes/<change-id>/concept.md.
2. Interview the user in small batches: what hurts today, who notices, what
   "done" looks like. CHALLENGE the idea — steelman the opposite position,
   name at least one alternative approach, argue against their first instinct.
   A concept that names no alternative is not done.
3. Draft openspec/changes/<change-id>/concept.md from their answers (~60
   lines max, template below). If a section can't be filled honestly, leave
   it as an open question instead of inventing an answer.
4. The user edits/approves the file. THIS IS THE GATE.
5. STOP. Tell the user: fresh session → /opsx-explore. The concept's
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
- No source code; read only openspec/project.md and the concept file.
- The proposal COMPRESSES this file — never copy sections into spec artifacts.
- This phase is OPTIONAL. For small obvious changes, skip to /opsx-explore.

DUAL-HARNESS NOTE: if the user also runs Claude Code, the cheapest split is
brainstorm here (free re-rolls) and run explore/propose/apply/verify there
against the structured concept.md handoff.
