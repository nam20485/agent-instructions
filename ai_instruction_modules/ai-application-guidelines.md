---
description: Technology stack and framework selection guidelines for applications.
scope: application-guidelines
prerequisites: ai-core-instructions.md
---
# Application Guidelines

<xml>
<instructions role="architect" scope="application-guidelines">

<technology_stack>
## Technology Stack

### Core
- **Platform:** .NET 9.0.102+ (C# 10+).
- **Config:** Use `global.json` to pin SDK version.
- **References:** [What's New in .NET 9](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-9/overview).

### Web Applications
- **Backend:** ASP.NET Core Web API (Controllers preferred over Minimal APIs).
- **Frontend:** Blazor WASM (or MAUI Hybrid for mobile).
- **Container:** Docker, Aspire.
- **Frameworks:** CommunityToolkit, ABP (large scale).

### Desktop & Console
- **UI:** Avalonia UI (Cross-platform), Fluent UI.
- **TUI:** Spectre.Console (CLI + Testing), Consolonia (Advanced).
- **CLI:** CliFx, CommandDotNet.

### Data & Storage
- **Databases:** PostgreSQL, MSSQL, MongoDB, Redis, Neo4j.
- **Testing:** EF Core InMemory, LiteDB.
- **ORM:** EF Core (Code First, Fluent API).

### Development Practices
- **Testing:** TDD/BDD, >80% coverage. See [ai-testing-validation.md](./ai-testing-validation.md).
- **Docs:** Swagger/OpenAPI, XML Comments (Required).
- **Logging:** Serilog (Structured: File + Console).
- **CI/CD:** Build, Test, Docker Push (GitHub Registry).
- **IaC:** Terraform (Docker providers).
- **Scripting:** PowerShell Core 7.1+.

### Libraries
- **Resilience:** Polly.
- **Modules:** Carter, Nancy.
- **Utils:** CommunityToolkit.

## Examples
<see example="examples/app-guidelines-examples.md" />

</technology_stack>
</instructions>
</xml>
