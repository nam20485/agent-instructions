# Assignment: Create Application Structure

## (create-application-structure)

### Goal

Create the core application structure, entry points, and primary architectural components. This establishes the skeleton of the application following the chosen architecture pattern.

### Prerequisites

* Application Foundation completed (dependencies, build system, code quality tools)
* Application plan with defined architecture (MVC, Clean Architecture, Hexagonal, etc.)
* Understanding of the application's primary components and layers

### Acceptance Criteria

1. Application entry point created and runs without errors
2. Core directory structure established following chosen architecture
3. Configuration management working and validated
4. Common utilities created and functional
5. Application starts and shuts down gracefully
6. Health/status endpoints functional (if applicable)
7. All code passes linting and type checking

### Assignment

You will create the core application structure and architectural components based on the application plan. This involves setting up the entry point, organizing code by architectural layers, and creating the foundational components that all features will build upon.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

#### 1. Create Application Entry Point

1. Create main application file based on tech stack:
   - **Node.js/TypeScript**: `src/main.ts` or `src/index.ts`
   - **Python**: `src/main.py` or `src/__main__.py`
   - **Rust**: `src/main.rs`
   - **Java**: `src/main/java/.../Main.java`
   - **C#/.NET**: `Program.cs`
   - **Go**: `main.go`
   - **Ruby**: `lib/main.rb` or executable in `bin/`
   - **PHP**: `public/index.php` or `src/index.php`

2. Set up application initialization
   - Initialize logging/telemetry
   - Load configuration
   - Set up dependency injection container (if applicable)
   - Initialize database connections (if applicable)
   - Register services and components

3. Configure logging/telemetry initialization
   - Set up structured logging
   - Configure log levels
   - Set up log output (console, file, external service)
   - Initialize telemetry/metrics (if applicable)

4. Set up error handling at application level
   - Global exception handler
   - Unhandled error logging
   - Graceful error responses
   - Error reporting (if applicable)

5. Test entry point
   - Run application and verify it starts
   - Check logs are being written
   - Verify configuration is loaded
   - Test graceful shutdown

#### 2. Create Core Directory Structure

Organize code according to chosen architecture pattern:

**For MVC Architecture:**
```
src/
  controllers/    # Request handlers
  models/         # Data models
  views/          # Templates/UI (if applicable)
  services/       # Business logic
  repositories/   # Data access
  middleware/     # Request/response middleware
  utils/          # Utilities
```

**For Clean Architecture:**
```
src/
  domain/         # Entities and business rules
  application/    # Use cases and application logic
  infrastructure/ # External concerns (DB, API, etc.)
  presentation/   # Controllers, views, API endpoints
  shared/         # Shared utilities and types
```

**For Hexagonal Architecture:**
```
src/
  domain/         # Core business logic
  ports/          # Interfaces for adapters
  adapters/       # Implementations (DB, API, etc.)
    inbound/      # Incoming requests
    outbound/     # Outgoing calls
  application/    # Application services
```

**For Microservice/API:**
```
src/
  api/            # API endpoints/routes
  services/       # Business logic services
  models/         # Data models/DTOs
  repositories/   # Data access
  middleware/     # Request middleware
  utils/          # Utilities
```

**For CLI Application:**
```
src/
  commands/       # CLI commands
  services/       # Business logic
  utils/          # Utilities
  config/         # Configuration
```

**For Library/Package:**
```
src/
  core/           # Core functionality
  utils/          # Utility functions
  types/          # Type definitions
  index.ts        # Public API
```

1. Create directories for chosen architecture
2. Create index/barrel files for each directory (if applicable)
3. Add README.md in key directories explaining their purpose

#### 3. Create Configuration Management

1. Create configuration loader
   - Load from environment variables
   - Load from config files
   - Merge configurations with precedence
   - Validate configuration on load

2. Create configuration validation
   - Define configuration schema
   - Validate required fields are present
   - Validate field types and formats
   - Provide helpful error messages for invalid config

3. Set up configuration schema/types
   - Define TypeScript interfaces / Python dataclasses / etc.
   - Document each configuration option
   - Provide default values where appropriate

4. Create default configuration
   - Development defaults
   - Sensible fallback values
   - Document what needs to be overridden

5. Test configuration loading
   - Test with valid configuration
   - Test with missing required fields
   - Test with invalid values
   - Verify error messages are helpful

#### 4. Create Common Utilities

1. Create logging utility
   - Structured logging helper
   - Log level helpers (debug, info, warn, error)
   - Context-aware logging
   - Log formatting

2. Create error handling utilities
   - Custom error classes/types
   - Error formatting
   - Error serialization
   - Stack trace handling

3. Create validation utilities
   - Input validation helpers
   - Schema validation
   - Type guards (TypeScript)
   - Sanitization functions

4. Create common helper functions
   - String manipulation
   - Date/time utilities
   - Data transformation
   - Async utilities

5. Test utilities
   - Write unit tests for each utility
   - Verify edge cases are handled
   - Document usage with examples

#### 5. Create Application Scaffolding

1. Create main application class/module
   - Application lifecycle management
   - Service initialization
   - Dependency management
   - State management

2. Set up dependency injection (if applicable)
   - Configure DI container
   - Register services
   - Define service lifetimes
   - Set up interfaces and implementations

3. Create service initialization
   - Database connection initialization
   - External service clients
   - Cache initialization
   - Queue/message bus setup

4. Set up graceful shutdown handling
   - Listen for shutdown signals (SIGTERM, SIGINT)
   - Close database connections
   - Finish in-flight requests
   - Clean up resources
   - Log shutdown completion

5. Test application lifecycle
   - Test startup sequence
   - Test shutdown sequence
   - Verify resources are cleaned up
   - Check for resource leaks

#### 6. Create Basic Health/Status Endpoints

For web applications and services:

1. Create health check endpoint/function
   - Simple liveness check (returns 200 OK)
   - Check critical dependencies (database, cache, etc.)
   - Return health status (healthy/unhealthy)
   - Include timestamp

2. Create version/info endpoint
   - Application version
   - Build information
   - Environment name
   - Deployment timestamp

3. Create readiness check (if applicable)
   - Check if app is ready to serve traffic
   - Verify dependencies are available
   - Return ready/not ready status

4. Test health endpoints
   - Test when healthy
   - Test when dependencies are down
   - Verify response format
   - Check response times

For CLI applications:

1. Create version command
   - Display application version
   - Show build information

2. Create help command
   - List available commands
   - Show usage information

### Completion

1. **Verify Structure is Complete:**
   - Application starts without errors
   - Configuration loads correctly
   - Utilities are functional
   - Health checks work (if applicable)
   - Code passes all quality checks

2. **Present to Stakeholder:**
   - Demonstrate application startup
   - Show directory structure
   - Demonstrate configuration loading
   - Show health endpoints (if applicable)

3. **Stakeholder Review Process:**
   - Ask if they approve the application structure
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit all structure files
   - Mark the structure creation as complete once approved
   - Proceed to next assignment (Testing Infrastructure or Deployment Infrastructure)

### Notes

- Adapt directory structure to your specific architecture pattern
- For frontend apps, this includes component structure and state management
- For backend apps, this includes API/service structure and data access
- For CLI apps, this includes command structure and argument parsing
- Follow established patterns and conventions for your tech stack
- Keep the structure flexible for future growth
