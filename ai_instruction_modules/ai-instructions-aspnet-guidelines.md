# ASP.NET Core Guidelines

## Code Style
- Concise, idiomatic C#; standard folder structure (Controllers, Services, Models, Data)
- OOP/FP patterns, LINQ/lambdas, descriptive naming, separation of concerns
- **Naming**: PascalCase (classes/methods), camelCase (locals/privates), UPPERCASE (constants), "I" prefix (interfaces)

## C# Features
- C# 10+ features (records, pattern matching, null-coalescing)
- ASP.NET Core + Community Toolkit libraries, EF Core with DbContext/repository patterns

## Error Handling & APIs
- Exceptions for exceptional cases only, built-in logging, Data Annotations/Fluent Validation
- Global exception middleware, appropriate HTTP status codes, RESTful design
- Attribute-based routing, action filters for cross-cutting concerns

## Performance & Architecture  
- async/await for I/O, IMemoryCache/IDistributedCache, efficient LINQ, pagination
- Built-in DI, repository pattern/EF Core, AutoMapper for DTOs, IHostedService for background tasks
- DDD principles, clean architecture, avoid unnecessary dependencies

## Testing & Security
- xUnit/NUnit/MSTest, Moq/NSubstitute mocking, TestServer integration tests
- ASP.NET Core Identity, JWT/cookie auth, HTTPS/SSL, CORS policies, claims-based authorization

## Documentation
- Swagger/OpenAPI, XML comments for controllers/DTOs

*Reference official Microsoft/ASP.NET Core/Community Toolkit docs for best practices.*
