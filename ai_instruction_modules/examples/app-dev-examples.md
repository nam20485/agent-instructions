# Application Development Examples

## Example 1: Simple REST API

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

## Example 2: Blazor Component with Validation

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

## Example 3: Console Application with Dependency Injection

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

## Example 4: Background Service

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
