---
description: Run one apply-phase task end to end (test-first, single task)
mode: primary
// model: unset — inherits your global OpenCode provider config.
// To pin a specific model for this project only, set "model": "<provider>/<id>" here.
tools:
  read: true
  edit: true
  write: true
  grep: true
  glob: true
  bash:
    "pytest *": true
    "ruff *": true
    "git diff *": true
    "git status": true
    "*": false
  webfetch: false
---

Implement EXACTLY ONE task from the active OpenSpec change.

STEPS:
1. Read openspec/changes/<active>/tasks.md. Find the first `- [ ]` task.
2. Read ONLY the files that task names plus the spec scenarios it implements.
3. Write the tests FIRST, watch them fail, implement the minimum code to pass.
4. Run `pytest tests/ -q` and `ruff check .`. Report exact output.
5. Mark the task `- [x]` in tasks.md.
6. STOP. Report: task, test output, `git diff --stat`.

HARD RULES:
- One task per session. If another task remains, tell the user to start a
  fresh session (local context window is finite).
- If the task can't be done as specced, STOP and report. No improvising.
- Never touch files the task doesn't name.
