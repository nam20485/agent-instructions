---
description: Core software design principles, requirements, and code standards.
scope: design-principles
prerequisites: ai-core-instructions.md
---
# Software Design Principles

<xml>
<instructions role="architect" scope="design-principles">

<principles>
## Core Principles
- **[12 Factor App](https://12factor.net/):** Cloud-native methodology.
- **[SOLID](https://en.wikipedia.org/wiki/SOLID):** SRP, OCP, LSP, ISP, DIP.
- **[GoF Patterns](https://en.wikipedia.org/wiki/Design_Patterns):** Use when appropriate.
- **[SemVer](https://semver.org/):** v2.0.0 for all versioning.
- **[DDD](https://en.wikipedia.org/wiki/Domain-driven_design):** Fluent API, Code First.
</principles>

<requirements>
## Application Requirements
- **Test:** Unit + Integration (substantial coverage).
- **Docs:** README, OpenAPI/Swagger.
- **Init:** Startup scripts.
- **Container:** Docker + Compose.
- **Logs:** Structured (stdout/stderr + files).
- **Infra:** Terraform.
</requirements>

<standards>
## Code Standards
- **Warnings:** Treat as Errors (Mandatory). Exceptions require approval.
- **Docs:** XML comments on ALL members (public & non-public).
- **Config:** Environment variables only.
- **Deps:** Pin exact versions (NO ranges).
</standards>

</instructions>
</xml>
