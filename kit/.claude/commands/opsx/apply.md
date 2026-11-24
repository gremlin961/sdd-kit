---
description: Implement the next unchecked task from tasks.md (one task per session)
allowed-tools: Read, Edit, Write, Bash(pytest*), Bash(ruff*), Bash(git diff*), Bash(git status*), Task
---

Start the SDD apply phase. STRICT SCOPE: one unchecked task, nothing else.

Steps:
1. Read ONLY: openspec/changes/<active>/tasks.md. Find the first `- [ ]`.
2. Read ONLY the files that task names, plus the spec scenarios it implements.
3. Write the test(s) for those scenarios FIRST, watch them fail, then
   implement the minimum code that makes them pass.
4. Run: pytest tests/ -q and ruff check . — report the exact output.
5. Mark the task `- [x]` in tasks.md.
6. STOP. Report: task done, test output, files changed (`git diff --stat`).
   If another task remains, tell the user to run /opsx:apply in a fresh session.

If the task cannot be completed as specced, STOP and report — do not
improvise, do not touch neighboring code.
