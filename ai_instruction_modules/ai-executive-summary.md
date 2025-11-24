---
description: High-level executive summary of core principles, priorities, and quality standards.
scope: executive-summary
prerequisites: none
---
# Executive Summary: Core Principles

<xml>
<instructions role="executive" scope="executive-summary">

<hierarchy>
## Priority Order
1.  **User Request:** Explicit instructions override all else.
2.  **Repo Goals:** Active issue goals and repo-specific docs.
3.  **Tech Stack:** ASP.NET, Blazor, GCP, Docker guidelines.
4.  **Design:** SOLID, 12-Factor, DDD.
</hierarchy>

<focus_areas>
## Focus Areas
-   **Workflow:** Granular checklists, issue-driven.
-   **TDD:** ≥80% coverage, tests first.
-   **Diffs:** Small, clear intent, validated.
-   **Readiness:** Containerized, logged, documented, secure.
</focus_areas>

<quality_bar>
## Quality Bar
-   **Build:** Clean (warnings handled).
-   **Tests:** Green (unit + integration).
-   **API:** OpenAPI updated.
-   **Docs:** README/Issue notes updated.
</quality_bar>

<communication>
## Communication
-   **Style:** Concise bullets, minimal prose.
-   **Decisions:** Options with pros/cons.
-   **Transparency:** Explicit assumptions.
</communication>

<security_reliability>
## Security & Reliability
-   **IAM:** Least privilege.
-   **Secrets:** External (env/secret manager).
-   **Code:** Input validation, structured logging.
</security_reliability>

<performance>
## Performance
-   **Strategy:** Measure before optimizing. Identify hotspots.
</performance>

<documentation>
## Documentation
-   **Minimum:** What changed, why, validation steps, rollback approach.
</documentation>

</instructions>
</xml>
