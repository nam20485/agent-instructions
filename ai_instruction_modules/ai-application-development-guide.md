<application_development_guide>
# AI Application Development Guide

<purpose>
## Purpose
Use this guide when creating, modifying, or refactoring applications. This comprehensive reference consolidates application development practices, design principles, and technology-specific guidelines to help you build high-quality software.

## When to Use This Guide
- Creating new applications from scratch
- Adding features to existing applications
- Refactoring or modernizing codebases
- Making architectural decisions
- Reviewing code for best practices
- Planning application structure and design
- Selecting technologies and frameworks
</purpose>

<quick_reference>
## Quick Reference

### Technology Stack (Latest Versions)

**Core Stack:**
- **.NET**: 9.0.102 or later
- **Language**: C# 10+ with modern features
- **Web API**: ASP.NET Core (full controllers, not Minimal APIs)
- **Frontend**: Blazor WASM (MAUI Hybrid for mobile)
- **Database**: PostgreSQL, MS SQL, MongoDB, Redis
- **ORM**: EF Core (Fluent API, Code First)
- **Containers**: Docker + Docker Compose
- **Orchestration**: Aspire for .NET applications
- **Infrastructure**: Terraform for IaC

**UI Frameworks:**
- Desktop: Avalonia UI, Fluent UI
- Console/TUI: Spectre.Console, Consolonia
- CLI: CliFx, Commanddotnet

### Core Design Principles (Quick Reference)

**12-Factor App** - Cloud-native application methodology
- One codebase, explicit dependencies, config in environment
- Backing services as attached resources, strict separation of stages
- Stateless processes, port binding, concurrency via processes
- Disposability, dev/prod parity, logs as event streams, admin as one-off processes

**SOLID Principles**
- **S**ingle Responsibility - One class, one reason to change
- **O**pen/Closed - Open for extension, closed for modification
- **L**iskov Substitution - Subtypes must be substitutable for base types
- **I**nterface Segregation - Many specific interfaces > one general interface
- **D**ependency Inversion - Depend on abstractions, not concretions

**Domain-Driven Design**
- Ubiquitous language, bounded contexts, aggregates
- Entities, value objects, repositories, domain services
- Fluent API for configuration, Code First approach

**Code Quality Standards**
- Warnings as errors (MANDATORY - exceptions require approval)
- XML documentation on ALL types and members (public and non-public)
- Environment variables for configuration (never hardcode)
- Pin dependency versions precisely (NO version ranges)
- Unit + integration tests with substantial coverage
- Structured logging to stdout/stderr + files

**GitHub Authentication:**
* For GitHub authentication, reference the official documentation:
  * [ai-gh-authentication](./ai-gh-authentication.md)

### ASP.NET Core Quick Reference

**Code Organization:**
- Standard folder structure: Controllers, Services, Models, Data
- Separation of concerns, repository pattern
- AutoMapper for DTOs, built-in DI container

**Naming Conventions:**
- `PascalCase` - Classes, methods, properties, public fields
- `camelCase` - Local variables, private fields, parameters
- `UPPERCASE` - Constants
- `IInterface` - Interfaces with "I" prefix

**Modern C# Features:**
- Records for immutable data structures
- Pattern matching for type checks and conditions
- Null-coalescing operators (??, ??=, ?.)
- Init-only properties, primary constructors
- Global usings, file-scoped namespaces

**API Best Practices:**
- RESTful design with appropriate HTTP verbs
- Attribute-based routing, action filters
- Global exception middleware
- Data Annotations or Fluent Validation
- Swagger/OpenAPI documentation
- async/await for all I/O operations

**Security:**
- ASP.NET Core Identity for authentication
- JWT or cookie-based auth
- HTTPS/SSL enforcement
- CORS policies, claims-based authorization
- Input validation, SQL injection prevention

## Canonical Reference Files

For complete specifications and detailed guidance, refer to these canonical files:

### General Application Development
**[ai-application-guidelines.md](./ai-application-guidelines.md)**
- Complete technology stack with version requirements
- Framework selection guidance for different application types
- Database, ORM, and data access patterns
- UI framework recommendations (desktop, web, console)
- Global.json configuration examples
- Latest .NET features and announcements

### Design Principles & Patterns
**[ai-design-principles.md](./ai-design-principles.md)**
- Complete 12-Factor App methodology
- Detailed SOLID principles with examples
- Gang of Four (GoF) design patterns
- Domain-Driven Design (DDD) concepts
- Semantic versioning (SemVer) guidelines
- Application requirements checklist
- Code standards and quality requirements

### ASP.NET Core Specific
**[ai-instructions-aspnet-guidelines.md](./ai-instructions-aspnet-guidelines.md)**
- Comprehensive ASP.NET Core code style guide
- C# 10+ feature usage patterns
- Error handling and logging strategies
- Performance optimization techniques
- Repository pattern and EF Core best practices
- Testing strategies (unit, integration, mocking)
- Security implementation details
- Complete API design guidelines

## Common Workflows

### Creating a New Application

1. **Define Requirements & Architecture**
   - Review application requirements and user stories
   - Select appropriate application type (Web API, Blazor, Console, etc.)
   - Define bounded contexts if using DDD
   - Plan data model and relationships
   - Identify external dependencies and integrations

2. **Set Up Project Structure**
   - Create global.json with .NET 9.0.102+
   - Initialize solution with proper folder structure
   - Set up Controllers, Services, Models, Data folders
   - Configure warnings as errors in .csproj
   - Add XML documentation requirement

3. **Implement Core Infrastructure**
   - Set up dependency injection container
   - Configure EF Core DbContext with Fluent API
   - Implement repository pattern for data access
   - Add AutoMapper for DTO mappings
   - Set up structured logging (Serilog or built-in)
   - Configure environment-based settings

4. **Develop Domain & Business Logic**
   - Create domain entities following DDD principles
   - Implement value objects for business concepts
   - Add domain services for complex operations
   - Use SOLID principles for class design
   - Apply appropriate design patterns (Factory, Strategy, etc.)
   - Write XML documentation for all types and members

5. **Build API Layer (if Web API)**
   - Create controllers with attribute routing
   - Implement DTOs for request/response models
   - Add Data Annotations or Fluent Validation
   - Configure Swagger/OpenAPI documentation
   - Add global exception middleware
   - Implement authentication and authorization

6. **Add Testing**
   - Write unit tests for business logic (xUnit/NUnit)
   - Create integration tests for API endpoints
   - Use mocking frameworks (Moq/NSubstitute)
   - Aim for substantial code coverage
   - Test edge cases and error conditions

7. **Containerization & Infrastructure**
   - Create Dockerfile with multi-stage build
   - Add docker-compose.yml for local development
   - Create Terraform definitions for cloud resources
   - Set up environment variable configuration
   - Add startup scripts for initialization

8. **Documentation & Finalization**
   - Write comprehensive README with setup instructions
   - Ensure all XML documentation is complete
   - Generate and review Swagger documentation
   - Create architecture diagrams if complex
   - Document environment variables and configuration

#### Implementing a New Feature

When adding new functionality to an existing application:

1. **Design the Feature**
   - Define clear requirements and acceptance criteria
   - Sketch data models and API contracts
   - Identify affected layers (domain, data, API, UI)
   - Plan for backward compatibility
   - Consider security and performance implications

2. **Create Feature Branch**
   - Branch from main/develop following naming convention
   - Update local environment with latest dependencies
   - Run existing tests to ensure clean baseline

3. **Implement Domain Changes**
   - Add/modify domain entities and value objects
   - Create domain services if needed
   - Update repository interfaces
   - Implement business logic with SOLID principles
   - Add comprehensive XML documentation

4. **Update Data Layer**
   - Create new EF Core migration
   - Update DbContext and configurations
   - Implement repository methods
   - Test migrations locally with test data

5. **Build API/UI Components**
   - Create/update controllers or Razor components
   - Implement DTOs and validation rules
   - Add error handling and logging
   - Update Swagger documentation
   - Implement client-side UI (if Blazor)

6. **Add Tests**
   - Write unit tests for new business logic
   - Create integration tests for API endpoints
   - Add UI tests for user-facing features
   - Test error conditions and edge cases
   - Ensure existing tests still pass

7. **Review & Refactor**
   - Apply SOLID principles and design patterns
   - Remove code duplication
   - Ensure consistent code style
   - Update documentation
   - Run static analysis tools

8. **Create Pull Request**
   - Write clear PR description with context
   - Link to related issues/tasks
   - Request code review from team
   - Address review comments
   - Merge when approved

#### Refactoring Existing Code

When improving code quality without changing external behavior:

1. **Identify Refactoring Target**
   - Look for code smells (long methods, duplicate code)
   - Identify SOLID violations
   - Find performance bottlenecks
   - Review static analysis warnings
   - Check code coverage gaps

2. **Ensure Test Coverage**
   - Write tests for existing functionality if missing
   - Verify tests pass before refactoring
   - Use tests as safety net during changes

3. **Apply Refactoring Patterns**
   - Extract Method - Break down long methods
   - Extract Class - Single Responsibility Principle
   - Extract Interface - Dependency Inversion Principle
   - Replace Conditional with Polymorphism
   - Introduce Parameter Object
   - Replace Magic Numbers with Named Constants

4. **Modernize C# Code**
   - Use records for immutable DTOs
   - Apply pattern matching where appropriate
   - Use null-coalescing operators (??, ??=)
   - Convert to file-scoped namespaces
   - Add primary constructors where beneficial

5. **Verify & Test**
   - Run all tests after each refactoring step
   - Ensure no behavioral changes
   - Check for performance regressions
   - Validate XML documentation is updated

6. **Document Changes**
   - Update XML documentation for modified members
   - Add code comments for complex logic
   - Update architecture documentation if structure changed

#### Code Review Process

When reviewing code (your own or others'):

1. **Functional Review**
   - Does it meet requirements and acceptance criteria?
   - Are edge cases and error conditions handled?
   - Is the logic correct and complete?

2. **Design Review**
   - SOLID principles applied correctly?
   - Appropriate design patterns used?
   - Proper separation of concerns?
   - Domain-driven design followed (if applicable)?

3. **Code Quality**
   - Consistent naming conventions (PascalCase, camelCase)?
   - XML documentation on ALL types and members?
   - No hardcoded configuration values?
   - Warnings as errors enabled and passing?
   - Dependency versions pinned precisely?

4. **Security Review**
   - Input validation implemented?
   - SQL injection prevention (parameterized queries)?
   - Authentication and authorization correct?
   - Secrets managed via environment variables?
   - HTTPS/SSL enforced?

5. **Performance Review**
   - async/await used for I/O operations?
   - Database queries optimized (no N+1 queries)?
   - Proper use of caching where applicable?
   - Resource disposal handled (using statements)?

6. **Testing Review**
   - Unit tests for business logic?
   - Integration tests for API endpoints?
   - Test coverage substantial?
   - Tests actually verify behavior (not just coverage)?

#### Testing Strategy

When implementing comprehensive testing:

1. **Unit Testing**
   - Test business logic in isolation
   - Use mocking frameworks (Moq/NSubstitute) for dependencies
   - Follow AAA pattern: Arrange, Act, Assert
   - Test edge cases and boundary conditions
   - Aim for high code coverage on business logic

2. **Integration Testing**
   - Test API endpoints end-to-end
   - Use WebApplicationFactory for ASP.NET Core
   - Test with real database (in-memory or test container)
   - Verify HTTP status codes and response models
   - Test authentication and authorization

3. **Test Organization**
   - Mirror production project structure in test projects
   - Group tests by feature or class under test
   - Use descriptive test method names
   - Create test fixtures for shared setup

4. **Test Data Management**
   - Use builders or factories for test data
   - Create realistic but controlled scenarios
   - Clean up test data after each test
   - Use in-memory databases or containers

## Troubleshooting

### Common Build Errors

**Problem:** "Treating warnings as errors" causes build failure
- **Cause**: Warnings as errors is enabled (MANDATORY requirement)
- **Solution**: Fix all warnings; do NOT disable warnings as errors
- **Prevention**: Fix warnings as you write code, use XML documentation

**Problem:** Dependency version conflicts
- **Cause**: Version ranges or transitive dependency mismatches
- **Solution**: Pin exact versions in .csproj, use `<PackageReference Include="..." Version="X.Y.Z" />`
- **Prevention**: Never use version ranges; review dependency tree regularly

**Problem:** EF Core migration errors
- **Cause**: DbContext misconfiguration, conflicting migrations
- **Solution**: Review Fluent API configuration, delete and recreate migration
- **Prevention**: Test migrations locally before committing

### Common Runtime Errors

**Problem:** NullReferenceException in production
- **Cause**: Missing null checks, optional dependencies
- **Solution**: Use null-coalescing operators (??=, ?.), nullable reference types
- **Prevention**: Enable nullable reference types, use required properties

**Problem:** Database connection failures
- **Cause**: Incorrect connection string, firewall rules, authentication
- **Solution**: Verify environment variables, check network connectivity, validate credentials
- **Prevention**: Use health checks, structured logging for connection issues

**Problem:** Swagger not showing all endpoints
- **Cause**: Missing XML documentation, incorrect routing
- **Solution**: Ensure XML docs generated and included in Swagger config
- **Prevention**: Enable XML documentation output, add Swagger attribute filters

### Performance Issues

**Problem:** Slow API responses
- **Cause**: Synchronous I/O, N+1 queries, missing indexes
- **Solution**: Use async/await, use `.Include()` or projections, add database indexes
- **Prevention**: Profile during development, use EF Core logging

**Problem:** High memory usage
- **Cause**: Large object retention, improper disposal
- **Solution**: Use `using` statements, dispose DbContext properly, implement IDisposable
- **Prevention**: Monitor memory in development, use memory profilers

## Examples

### Example 1: Simple REST API

**Scenario:** Create a minimal REST API for managing tasks

```csharp
// Domain Entity
public class Task
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public bool IsCompleted { get; set; }
}

// DTO
public record TaskDto(int Id, string Title, bool IsCompleted);

// Repository Interface
public interface ITaskRepository
{
    Task<IEnumerable<TaskDto>> GetAllAsync();
    Task<TaskDto?> GetByIdAsync(int id);
    Task<TaskDto> CreateAsync(TaskDto task);
}

// Controller
[ApiController]
[Route("api/[controller]")]
public class TasksController : ControllerBase
{
    private readonly ITaskRepository _repository;

    public TasksController(ITaskRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<TaskDto>>> GetAll()
    {
        var tasks = await _repository.GetAllAsync();
        return Ok(tasks);
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<TaskDto>> GetById(int id)
    {
        var task = await _repository.GetByIdAsync(id);
        if (task == null) return NotFound();
        return Ok(task);
    }

    [HttpPost]
    public async Task<ActionResult<TaskDto>> Create(TaskDto task)
    {
        var created = await _repository.CreateAsync(task);
        return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
    }
}
```

### Example 2: Blazor Component with Validation

**Scenario:** Create a form component with validation

```razor
@page "/create-task"
@inject ITaskService TaskService
@inject NavigationManager Navigation

<EditForm Model="@model" OnValidSubmit="HandleSubmit">
    <DataAnnotationsValidator />
    <ValidationSummary />

    <div class="mb-3">
        <label>Title:</label>
        <InputText @bind-Value="model.Title" class="form-control" />
        <ValidationMessage For="@(() => model.Title)" />
    </div>

    <button type="submit" class="btn btn-primary">Create</button>
</EditForm>

@code {
    private TaskInputModel model = new();

    private async Task HandleSubmit()
    {
        await TaskService.CreateAsync(model);
        Navigation.NavigateTo("/tasks");
    }

    public class TaskInputModel
    {
        [Required]
        [StringLength(100, MinimumLength = 3)]
        public string Title { get; set; } = string.Empty;
    }
}
```

### Example 3: Console Application with Dependency Injection

**Scenario:** Build a CLI tool with proper DI and logging

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        services.AddTransient<ITaskService, TaskService>();
        services.AddTransient<App>();
    })
    .ConfigureLogging(logging =>
    {
        logging.AddConsole();
        logging.AddFile("logs/app.log");
    })
    .Build();

var app = host.Services.GetRequiredService<App>();
await app.RunAsync();

public class App
{
    private readonly ITaskService _taskService;
    private readonly ILogger<App> _logger;

    public App(ITaskService taskService, ILogger<App> logger)
    {
        _taskService = taskService;
        _logger = logger;
    }

    public async Task RunAsync()
    {
        _logger.LogInformation("Application started");
        var tasks = await _taskService.GetAllAsync();
        foreach (var task in tasks)
        {
            Console.WriteLine($"{task.Id}: {task.Title}");
        }
    }
}
```

### Example 4: Background Service

**Scenario:** Create a background worker for periodic tasks

```csharp
public class TaskCleanupService : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<TaskCleanupService> _logger;
    private readonly TimeSpan _interval = TimeSpan.FromHours(1);

    public TaskCleanupService(
        IServiceProvider serviceProvider,
        ILogger<TaskCleanupService> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            _logger.LogInformation("Running cleanup at {Time}", DateTimeOffset.Now);

            using var scope = _serviceProvider.CreateScope();
            var repository = scope.ServiceProvider.GetRequiredService<ITaskRepository>();
            
            await repository.DeleteCompletedOlderThanAsync(TimeSpan.FromDays(30));

            await Task.Delay(_interval, stoppingToken);
        }
    }
}
```

## Summary

This guide consolidates application development practices across multiple domains:

**Core Principles:**
- Follow 12-Factor App methodology for cloud-native applications
- Apply SOLID principles and DDD for maintainable architecture
- Use modern C# features for cleaner, safer code
- Enforce code quality through warnings as errors and XML documentation

**Technology Stack:**
- .NET 9.0.102+ with latest language features
- ASP.NET Core for web APIs, Blazor for SPAs
- EF Core with Fluent API for data access
- Docker and Aspire for containerization and orchestration

**Development Workflow:**
- Start with clear requirements and architectural planning
- Implement infrastructure before business logic
- Test thoroughly at unit and integration levels
- Refactor continuously to maintain code quality
- Review code against SOLID principles and security best practices

**For Complete Details:**
- **Technology Stack**: See [ai-application-guidelines.md](./ai-application-guidelines.md)
- **Design Principles**: See [ai-design-principles.md](./ai-design-principles.md)
- **ASP.NET Specifics**: See [ai-instructions-aspnet-guidelines.md](./ai-instructions-aspnet-guidelines.md)

Remember: These guides provide navigation and quick reference. Always consult the canonical files for complete specifications and authoritative guidance.
</quick_reference>
</application_development_guide>
