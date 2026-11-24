---
description: Implement the next unchecked task (one task per session)
---

Run the apply phase with the `implementer` agent.

STEPS:
1. Load the `implementer` agent. It implements exactly the first `- [ ]`
   task in openspec/changes/<active>/tasks.md, test-first.
2. It reports: task done, exact pytest/ruff output, `git diff --stat`.
3. If tasks remain, tell the user to start a FRESH session and re-run
   /opsx-apply. Do not chain tasks in one session.

You do not need to verify the tests yourself — the user runs them in their
own terminal after the session. "The agent says tests pass" is not evidence.
