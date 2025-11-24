---
description: Guidelines for ASP.NET Core development, code style, and best practices.
scope: aspnet-core
prerequisites: ai-application-development-guide.md
---
# ASP.NET Core Guidelines

<xml>
<instructions role="aspnet-developer" scope="aspnet-core">

<code_style>
## Code Style
- **Structure:** Standard folders (Controllers, Services, Models, Data).
- **Patterns:** OOP/FP, LINQ, Separation of Concerns.
- **Naming:** `PascalCase` (public), `camelCase` (private), `UPPERCASE` (const), `IInterface`.
</code_style>

<csharp_features>
## C# Features
- **Modern:** C# 10+ (records, pattern matching, null-coalescing).
- **Libraries:** Community Toolkit, EF Core (DbContext/Repo).
</csharp_features>

<error_handling_api>
## Error Handling & APIs
- **Exceptions:** Exceptional cases only. Global middleware.
- **Validation:** Data Annotations / Fluent Validation.
- **API:** RESTful, Attribute Routing, Action Filters.
</error_handling_api>

<performance_architecture>
## Performance & Architecture
- **Async:** `async/await` for ALL I/O.
- **Caching:** `IMemoryCache`, `IDistributedCache`.
- **Data:** Efficient LINQ, Pagination.
- **DI:** Built-in container.
- **Design:** DDD, Clean Architecture.
</performance_architecture>

<testing_security>
## Testing & Security
- **Test:** xUnit/NUnit, Moq/NSubstitute, TestServer.
- **Auth:** Identity, JWT/Cookie, Claims.
- **Security:** HTTPS, CORS, SSL.
</testing_security>

<documentation>
## Documentation
- **API:** Swagger/OpenAPI.
- **Code:** XML comments on Controllers/DTOs.
</documentation>

</instructions>
</xml>
