# Software Design Principles

<principles>
## Core Principles
- [12 Factor App](https://12factor.net/)
- [SOLID Design](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design#introduction)
- [GoF Design Patterns](https://www.digitalocean.com/community/tutorials/gangs-of-four-gof-design-patterns#gof-design-pattern-types) - use when appropriate
- [SemVer v2.0.0](https://semver.org/) - for all versioning
- [Domain Driven Design](https://www.digitalocean.com/community/tutorials/an-introduction-to-domain-driven-design)
  - Fluent API
  - Code First
</principles>

<requirements>
## Application Requirements
- **Testing**: Unit + integration tests with substantial coverage
- **Documentation**: README, OpenAPI/Swagger for APIs
- **Initialization**: Startup scripts for easy setup
- **Containerization**: Docker + Docker Compose
- **Logging**: Structured output to stdout/stderr + files
- **Infrastructure**: Terraform definitions for deployable apps
</requirements>

<standards>
## Code Standards
- Warnings as errors (disable specific warnings only when necessary)  **MANDATORY on all projects. Exceptions ONLY WITH EXPLANATION & APPROVAL**
- XML documentation for **ALL** members (description, parameters, return, exceptions)
- XML documentation on **ALL** types: classes, interfaces, fields, properties, and methods (including non-public)
- Environment variables for configuration
- Pin dependency versions precisely **NO RANGES**
</standards>
