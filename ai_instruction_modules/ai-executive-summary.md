# Executive Summary: Core Principles

<hierarchy>
Priority Order (conflict resolution):
1. User explicit request
2. Repo-specific docs / active issue goals
3. Tech stack guidelines (ASP.NET / Blazor / GCP / Docker)
4. General design (SOLID, 12-Factor, DDD)
</hierarchy>

<focus_areas>
Focus Areas:
- Issue/task workflow; granular checklists
- TDD: ≥80% coverage target; tests precede feature when feasible
- Small diffs; clear intent; validation before completion
- Deployment readiness (container, logs, docs, security basics)
</focus_areas>

<quality_bar>
Quality Bar:
- Clean build (warnings handled)
- Tests green (unit + integration if applicable)
- OpenAPI updated for API changes
- Docs (README or issue notes) updated
</quality_bar>

<communication>
Communication:
- Concise bullets; minimal prose
- Provide options w/ pros/cons when design choice exists
- Explicit assumptions
</communication>

<security_reliability>
Security & Reliability:
- Least privilege IAM
- Secrets external (env / secret manager)
- Input validation & structured logging
</security_reliability>

<performance>
Performance:
- Identify potential hotspots; measure before optimize
</performance>

<documentation>
Documentation Minimum:
- What changed, why, validation steps, rollback approach
</documentation>

End of file.
