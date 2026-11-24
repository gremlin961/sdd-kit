---
description: Draft OpenSpec artifacts for user approval
---

Run the propose phase with the `spec-writer` agent.

STEPS:
1. Read ONLY openspec/project.md and the saved exploration findings
   (openspec/changes/<id>/exploration.md if present). If concept.md exists,
   read it as INPUT and COMPRESS it into the proposal (Why/What/Non-goals
   absorb it) — never copy sections verbatim.
2. Have spec-writer draft proposal.md, specs/, design.md (if needed), tasks.md
   under openspec/changes/<change-id>/.
3. Present the proposal. Do NOT write source code.
4. User edits/approves the artifacts.
5. On approval: tell the user to start a FRESH session and run /opsx-apply.
