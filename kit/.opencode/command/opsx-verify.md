---
description: Verify a change: deterministic tests + spec-conformance eval + independent review
---

Run the verify phase. Verification is THREE things:

1. DETERMINISTIC: the user runs `pytest tests/ -q` and `ruff check .` in their
   own terminal. Report exit codes as the only accepted evidence.
2. EVAL: for each scenario in openspec/changes/<active>/specs/, confirm a
   named test exercises it. List untested scenarios as gaps.
3. REVIEW: delegate to the `reviewer` agent (read-only, did not write the
   code) on the full diff vs main. Report VERDICT + findings.

If REQUEST CHANGES: blocking findings become new tasks via /opsx-propose
amendment — never fixed ad hoc in this session.

On full pass: the user runs /opsx-archive manually. You never archive.
