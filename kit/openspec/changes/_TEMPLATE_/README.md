# Change: add-rate-limiter  ← (replace with real change name)

> Keep every file in this directory small. This directory IS the session
> context. The implementing agent should need nothing else except the files
> named in tasks.md.

## proposal.md (≤500 words)
- **Why:** a single client can hammer `/calc/*` and starve others.
- **What:** token-bucket rate limiter as FastAPI middleware, configurable
  per-route via `RateLimitConfig`, `429` on breach with documented body.
- **Non-goals:** no distributed rate limiting, no Redis, no admin UI.

## specs/<capability>/spec.md (the contract)
### ADDED Requirements
#### Requirement: The service SHALL return HTTP 429 when a client exceeds its route budget.
##### Scenario: burst within budget
- GIVEN a budget of 5 requests/second
- WHEN a client sends 5 requests in one second
- THEN all 5 return 200

##### Scenario: budget exceeded
- GIVEN a budget of 5 requests/second
- WHEN a client sends a 6th request within the same second
- THEN it receives 429 with body `{"detail": "rate limit exceeded"}`

##### Scenario: budget recovers
- GIVEN the bucket is exhausted
- WHEN one second elapses
- THEN the next request returns 200

## design.md (only if >3 files touched)
- `RateLimitMiddleware` lives in `src/api/rate_limit.py`; pure ASGI
  middleware, no framework imports beyond `starlette`.
- Config in `src/api/config.py::RateLimitConfig(route -> (capacity, refill_rate))`.
- No state outside the process (see non-goals).

## tasks.md (each = one session, each names its files)
- [ ] 1. Add `RateLimitConfig` to `src/api/config.py` + unit tests in
        `tests/test_rate_limit_config.py`
- [ ] 2. Implement `RateLimitMiddleware` in `src/api/rate_limit.py` +
        tests in `tests/test_rate_limit.py` (Scenario 1 & 2)
- [ ] 3. Wire middleware in `src/api/main.py` + Scenario 3 test
- [ ] 4. Run full suite `pytest tests/ -q`, ruff, update README
