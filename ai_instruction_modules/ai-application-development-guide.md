---
description: Comprehensive guide for creating, modifying, and refactoring applications.
scope: application-development
prerequisites: ai-core-instructions.md
---
# AI Application Development Guide

<xml>
<instructions role="app-developer" scope="application-development">

<purpose>
## Purpose
**Use when:** Creating, modifying, or refactoring applications.
**Role:** Application developers and architects.

## When to Use This Guide
- Creating new applications (Web API, Blazor, Console)
- Adding features or refactoring existing code
- Making architectural decisions (DDD, SOLID)
- Reviewing code for best practices
</purpose>

<quick_reference>
## Quick Reference

### Technology Stack (Latest Versions)
- **Core:** .NET 9.0.102+, C# 10+, ASP.NET Core (Controllers), Blazor WASM.
- **Data:** PostgreSQL/MSSQL, EF Core (Code First), Redis.
- **Infra:** Docker, Aspire, Terraform.
- **UI:** Avalonia/Fluent (Desktop), Spectre.Console (TUI).

### Core Design Principles
- **12-Factor:** Config in env, backing services attached, stateless processes.
- **SOLID:** SRP, OCP, LSP, ISP, DIP.
- **DDD:** Ubiquitous language, bounded contexts, aggregates, repositories.
- **Quality:** Warnings as errors, XML docs on ALL members, pinned dependencies.

### ASP.NET Core Standards
- **Structure:** Controllers, Services, Models, Data folders.
- **Naming:** `PascalCase` (public), `camelCase` (private), `IInterface`.
- **API:** RESTful, attribute routing, global exception middleware, Swagger.
- **Security:** Identity, JWT/Cookie, HTTPS, input validation.

## Canonical Reference Files

**[ai-application-guidelines.md](./ai-application-guidelines.md)**
- Detailed tech stack, framework selection, global.json config.

**[ai-design-principles.md](./ai-design-principles.md)**
- 12-Factor, SOLID, GoF patterns, DDD, SemVer.

**[ai-instructions-aspnet-guidelines.md](./ai-instructions-aspnet-guidelines.md)**
- ASP.NET Core style guide, error handling, EF Core, testing.

## Common Workflows

### Creating a New Application
1. **Define:** Requirements, app type, bounded contexts, data model.
2. **Setup:** `global.json` (.NET 9+), solution structure, warnings as errors.
3. **Infra:** DI container, EF Core DbContext, AutoMapper, Serilog.
4. **Domain:** Entities (DDD), value objects, domain services, XML docs.
5. **API:** Controllers, DTOs, validation, Swagger, auth.
6. **Test:** Unit (business logic), Integration (API), Mocking.
7. **Deploy:** Dockerfile, docker-compose, Terraform.
8. **Docs:** README, XML docs, Architecture diagrams.

### Implementing a New Feature
1. **Design:** Requirements, data models, API contracts.
2. **Branch:** Feature branch from main/develop.
3. **Domain:** Entities, services, business logic, XML docs.
4. **Data:** EF Core migration, repository updates.
5. **UI/API:** Controllers/Components, DTOs, validation.
6. **Test:** Unit, Integration, UI tests.
7. **Review:** SOLID check, refactor, static analysis.
8. **PR:** Description, link issues, code review, merge.

### Refactoring Existing Code
1. **Identify:** Code smells, SOLID violations, perf bottlenecks.
2. **Safety:** Ensure test coverage BEFORE changing code.
3. **Apply:** Extract Method/Class/Interface, Polymorphism.
4. **Modernize:** Records, pattern matching, file-scoped namespaces.
5. **Verify:** Run tests after EACH step.
6. **Document:** Update XML docs and comments.

### Code Review Checklist
- **Functional:** Meets requirements? Handles edge cases?
- **Design:** SOLID? Patterns? Separation of concerns?
- **Quality:** Naming? XML docs? No hardcoded config? Warnings as errors?
- **Security:** Validation? Auth? Secrets? HTTPS?
- **Perf:** Async/await? No N+1? Caching? Disposal?
- **Tests:** Unit/Integration coverage? Meaningful assertions?

### Testing Strategy
- **Unit:** Isolate business logic, mock dependencies (Moq).
- **Integration:** End-to-end API tests (WebApplicationFactory).
- **Data:** Builders/Factories, clean up after tests.

## Troubleshooting

### Common Issues
- **Warnings as Errors:** Fix them. Do not disable.
- **Dependency Conflicts:** Pin exact versions. No ranges.
- **EF Core Errors:** Check Fluent API, recreate migrations.
- **NullRefs:** Use `??=`, `?.`, enable nullable reference types.
- **DB Connection:** Check env vars, firewall, credentials.
- **Swagger Missing:** Enable XML docs output.

### Performance
- **Slow API:** Use `async/await`, projections, indexes.
- **High Memory:** Dispose objects (`using`), monitor usage.

## Examples

<see example="examples/app-dev-examples.md" />

## Summary

**Key Takeaways:**
- **Stack:** .NET 9+, ASP.NET Core, EF Core, Docker.
- **Quality:** 12-Factor, SOLID, Warnings as Errors, XML Docs.
- **Process:** Plan -> Infra -> Domain -> API -> Test -> Deploy.

**References:**
- [ai-application-guidelines.md](./ai-application-guidelines.md)
- [ai-design-principles.md](./ai-design-principles.md)
- [ai-instructions-aspnet-guidelines.md](./ai-instructions-aspnet-guidelines.md)

</quick_reference>
</instructions>
</xml>
