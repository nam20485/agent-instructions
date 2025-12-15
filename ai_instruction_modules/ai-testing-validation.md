---
description: Testing and validation standards
scope: testing-validation
---
# Testing & Validation

## Approach
- **TDD:** Write tests → Fail → Implement → Pass → Refactor
- **Coverage:** Target ≥80%
- **Mandatory:** `dotnet build`, `dotnet test`, `docker build` (if Dockerfile changed)

## Frameworks

| Platform   | Unit   | Mock | Assertions        |
| ---------- | ------ | ---- | ----------------- |
| .NET       | xUnit  | Moq  | Fluent Assertions |
| Blazor     | Bunit  | Moq  | Fluent Assertions |
| PowerShell | Pester | Mock | Should            |

## Validation Steps
1. Build (no errors)
2. Test (all pass)
3. Provide specific commands to user

## Documentation
- XML doc comments on ALL members
- OpenAPI/Swagger for APIs
- Terraform/Docker documentation
