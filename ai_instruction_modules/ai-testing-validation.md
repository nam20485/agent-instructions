# Testing & Validation Instructions

## Testing Approach

- Use the TDD (Test-Driven Development) approach for all code changes.
- Write unit tests before implementing new features or changes.
- Iterate, cycling between running tests and writing code until the feature is complete.
- **After tests are written**, start implementing the feature.
- **After the feature or a part of the feature is implemented**, run the tests to validate the implementation.
- Coverage should be substantial, aim for at least 80% coverage.
- Always run `dotnet build` before suggesting changes are complete
- Use `dotnet test` for unit test validation  
- Test Docker builds with `docker build` when Dockerfile changes are made

## Frameworks / Packages

### For C#
* xUnit
* Moq
* Bunit (Blazor)
* Fluent Assertions
* Coverlet
* Coverage Reports
#* Stryker.NET
#* TesdtDriven.NET
* [Testcontainers](https://testcontainers.com/guides/getting-started-with-testcontainers-for-dotnet/) 

### Powershell
* Pester

### Docker
* The best Docker testing frameworks you can find.

### C++
* Catch2

## Continuous Integration
- Use GitHub Actions for CI/CD workflows.
- Include workflows for:
  - Automated builds
  - Automated tests
  - Docker image builds and pushes to the repository's GitHub package registry

## Links for TDD with AI Agents:
- [Test-Driven Development with AI Agents](https://www.flowhunt.io/blog/test-driven-development-with-ai-agents/)
- [TDD with AI Agents](https://www.flowhunt.io/blog/tdd-with-ai-agents/)

## Validation Steps

- Compile/build before marking tasks complete
- Provide specific test commands for user verification
- Include error handling and retry logic in instructions
- Run tests to verify that they all pass begore decalaring implementation complete

## Documentation Standards

- Include xml doc comments on all classes, fields, properties, and methods (including non-public)
- Link to xml doc comments: <https://learn.microsoft.com/dotnet/csharp/language-reference/xmldoc/>
- Enable project options for generating xml documentation.
- For APIs, include OpenAPI/Swagger documentation.
- Add Swagger description attributes to API endpoint/action controller methods.
- For Blazor, include component documentation.
- For desktop apps, include UI documentation.
- For console apps, include command documentation.
- For databases, include schema documentation.
- For infrastructure, include Terraform documentation.
- For Docker, include Dockerfile documentation.
- For CI/CD, include GitHub Actions documentation.

## References
- Include relevant Microsoft Learn links: <https://learn.microsoft.com/>
- Reference Google Cloud docs: <https://cloud.google.com/docs>
- Link to ASP.NET Core guides: <https://learn.microsoft.com/aspnet/core/>
