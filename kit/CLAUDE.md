# <PROJECT_NAME> — Claude Code session rules

@AGENTS.md

## Cost discipline (Anthropic API billing)
- Prompt caching is automatic: keep this file STABLE. Do not edit AGENTS.md or
  this file mid-session — any prefix change invalidates the cache.
- Default model: Sonnet. Escalate to Opus ONLY for design decisions during
  `/opsx:propose`. Use Haiku (Task tool subagent `model: haiku`) for search,
  triage, and review passes. (Model tiering also lives in agent frontmatter
  and settings.json env.ANTHROPIC_SMALL_FAST_MODEL — when models change,
  update all three; see README "When models change".)
- Check `/cost` at every phase exit. If a session exceeds $2, stop and
  continue in a fresh session with the spec as the only context.

## Session protocol
- Start of session: read `openspec/changes/<active>/tasks.md` — nothing else.
- End of session: report tasks completed, tests result, and tokens spent.
