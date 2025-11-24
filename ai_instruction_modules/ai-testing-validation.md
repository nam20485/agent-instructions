---
description: Instructions for testing, validation, and documentation standards.
scope: testing-validation
prerequisites: none
---
# Testing & Validation Instructions

<xml>
<instructions role="assistant" scope="testing-validation">

<testing_approach>
## Testing Approach
- **Methodology:** TDD (Test-Driven Development) mandatory.
- **Workflow:** Write tests -> Fail -> Implement -> Pass -> Refactor.
- **Coverage:** Target ≥80%.
- **Validation:**
    - `dotnet build` (Mandatory before completion)
    - `dotnet test` (Mandatory validation)
    - `docker build` (If Dockerfile changed)
</testing_approach>

<frameworks>
## Frameworks & Packages

### C# / .NET
- **Unit Testing:** xUnit
- **Mocking:** Moq
- **Blazor:** Bunit
- **Assertions:** Fluent Assertions
- **Coverage:** Coverlet
- **Integration:** Testcontainers

### PowerShell
- **Testing:** Pester

### C++
- **Testing:** Catch2
</frameworks>

<ci_cd>
## Continuous Integration
- **Platform:** GitHub Actions.
- **Workflows:**
    - Automated builds.
    - Automated tests.
    - Docker image builds & push to registry.
</ci_cd>

<validation_steps>
## Validation Steps
1.  **Compile/Build:** Verify no errors.
2.  **Test:** Verify all tests pass.
3.  **Verify:** Provide specific test commands to user.
4.  **Resilience:** Include error handling/retry logic.
</validation_steps>

<documentation_standards>
## Documentation Standards
- **Code:** XML doc comments on ALL members (public & non-public).
- **API:** OpenAPI/Swagger with description attributes.
- **Components:** Blazor component documentation.
- **Infrastructure:** Terraform/Docker documentation.
- **CI/CD:** GitHub Actions workflow documentation.
</documentation_standards>

<resources>
## References
- [Microsoft Learn](https://learn.microsoft.com/)
- [ASP.NET Core Guides](https://learn.microsoft.com/aspnet/core/)
- [Google Cloud Docs](https://cloud.google.com/docs)
- [XML Doc Comments](https://learn.microsoft.com/dotnet/csharp/language-reference/xmldoc/)
</resources>

</instructions>
</xml>
