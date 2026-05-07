---
domain: <short-slug>
watches:
  - src/path/to/watched/**
  - src/another/specific-file.ts
last_verified: YYYY-MM-DD
---

# <Domain Name>

## Purpose
One or two sentences: what this domain does and who consumes it.

## Entry points
- UI: `src/path/to/route.tsx`
- API: `src/app/api/...`
- Server actions: `src/lib/actions/...`

## Key files
| File | Responsibility |
|---|---|
| `src/path/to/file.tsx` | One-line description |

## Data flow
3–8 lines of prose or an ASCII diagram describing the main flow.

## Invariants & gotchas
Bulleted list of NON-obvious rules that are easy to break. This is the most
valuable section. Test-related gotchas (brittle areas, setup quirks,
intentionally untested paths) go here — NOT a coverage matrix.

## Related
- `docs/architecture/reference/<neighbour>.md`
- `docs/superpowers/specs/<relevant-spec>.md`

## Open questions / TODO
Optional — known unresolved issues or planned changes.
