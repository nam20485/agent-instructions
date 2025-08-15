# Application Guidelines

## Technology Stack

### Core
- **Language**: C# + .NET ≥9.0.0 with global.json:
  ```json
  {"sdk": {"version": "9.0.102", "rollForward": "latestFeature"}}
  ```

### Web Applications
- **Backend**: ASP.NET Core Web API (full controllers), Aspire, CommunityToolkit, Carter, Nancy, ABP (large projects)
- **Frontend**: Blazor WASM (Maui Hybrid if appropriate)

### Desktop
- **UI**: Avalonia UI (cross-platform)

### CLI Applications
- **TUI**: Spectre.Console + Cli + Testing ([best practices](https://spectreconsole.net/best-practices))
- **Advanced TUI**: Consolonia
- **CLI Frameworks**: CliFx, Commanddotnet

### Database
- **Options**: Redis, Memcache, Neo4J, MS SQL, PostgreSQL, MongoDB
- **Testing/Small**: .NET Core InMemory, LiteDB  
- **ORM**: EF Core (Fluent API, Code First)

### Development Practices
- **Testing**: TDD/BDD, 80%+ coverage → see [ai-testing-validation.md](./ai-testing-validation.md)
- **Containerization**: Docker + Docker Compose
- **Documentation**: Swagger/OpenAPI, XML comments
- **Logging**: Serilog structured (file + console)

### CI/CD
- **Required**: Build, tests, Docker push to GitHub registry
- **Optional**: Static analysis, releases, deployment

### Infrastructure & Scripting
- **IaC**: Terraform with Docker providers
- **Scripts**: PowerShell Core ≥7.1.x

### Optional Packages
- Polly, ABP, Carter, Nancy, CommunityToolkit
