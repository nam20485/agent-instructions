# Executive Summary: Core Principles

Priority Order (conflict resolution):
1. User explicit request
2. Repo-specific docs / active issue goals
3. Tech stack guidelines (ASP.NET / Blazor / GCP / Docker)
4. General design (SOLID, 12-Factor, DDD)

Focus Areas:
- Issue/task workflow; granular checklists
- TDD: ≥80% coverage target; tests precede feature when feasible
- Small diffs; clear intent; validation before completion
- Deployment readiness (container, logs, docs, security basics)

Quality Bar:
- Clean build (warnings handled)
- Tests green (unit + integration if applicable)
- OpenAPI updated for API changes
- Docs (README or issue notes) updated

Communication:
- Concise bullets; minimal prose
- Provide options w/ pros/cons when design choice exists
- Explicit assumptions

Security & Reliability:
- Least privilege IAM
- Secrets external (env / secret manager)
- Input validation & structured logging

Performance:
- Identify potential hotspots; measure before optimize

Documentation Minimum:
- What changed, why, validation steps, rollback approach

End of file.
