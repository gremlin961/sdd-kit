# <PROJECT_NAME> — Agent Instructions (repo contract)

> **Budget note:** You are running against metered API tokens (Claude Code) or a
> finite local GPU (OpenCode). Every file you read is billed. Follow these rules
> or the session gets expensive.

## Stack
<!-- SDD-SETUP: replace this entire section with the detected stack -->
- <Language, framework, test runner>. No other frameworks without approval.
- Commands: `<test command>` (tests), `<lint command>` (lint)
- Runtime code lives in `<code dir>/`. Tests in `<test dir>/`.

## Token / context discipline (NON-NEGOTIABLE)
1. **Read spec, not codebase.** For any change, read
   `openspec/changes/<active-change>/` FIRST. Only read source files the spec
   names. Never bulk-read directories "to understand the codebase."
2. **One task per session.** Implement exactly the tasks checked next in
   `tasks.md`, then STOP and report. Do not continue to unchecked tasks.
3. **Fresh sessions.** If context is likely >50% used, stop and tell the user
   to start a new session — do not `/compact` through it.
4. **Grep before read.** Use search to find the ~3 relevant files before
   opening anything. Never cat files >200 lines without a reason.
5. **No speculative work.** No "while I'm here" refactors, no extra files, no
   docs for features not in the spec.
6. **Show the diff, not the file.** When reporting, summarize what changed,
   don't echo file contents back.

## Verification contract
- After any code change: run `<test command>` and report the exact output.
- You do not decide tests pass. The exit code decides. Report it verbatim.
- Never skip, weaken, or delete a failing test to make a change pass. Propose
  a spec amendment instead.

## Boundaries
- Never `git push`, never `git commit` unless the user asked for it explicitly.
- Never run destructive shell commands (`rm -rf`, `DROP TABLE`, force-push).
- Do not edit anything under `.claude/`, `.opencode/`, or `openspec/` unless
  the user invoked the corresponding workflow command.
- If a task cannot be done within the spec, STOP and report — do not improvise.

## Escalation
If the spec is ambiguous or contradicts the code you see, stop and ask.
The cheapest failure is the one caught before the first edit.
