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

## Before Starting

Before beginning this assignment, complete these preparation steps:

### 1. Read Assignment Completely

- Read through all detailed steps
- Understand the overall goal
- Review acceptance criteria
- Note any dependencies on other assignments
- Identify potential challenges

### 2. Gather Context

- Review previous assignment outputs
  - Check what files were created
  - Understand current project state
  - Verify previous work is complete
- Check for related issues or PRs
  - Search for similar work
  - Review any existing discussions
  - Check for known issues
- Review project documentation
  - Read README and setup guides
  - Check architecture documentation
  - Review coding standards
- Understand current state
  - What's already been done
  - What's left to do
  - Any blockers or dependencies

### 3. Verify Prerequisites

- Check that required tools are installed
  - Runtime environment (Node.js, Python, etc.)
  - Build tools
  - Package managers
  - Development tools
- Verify previous assignments completed
  - Check acceptance criteria were met
  - Verify outputs are available
  - Confirm no blockers exist
- Ensure dependencies are met
  - External services available
  - Required credentials accessible
  - Network connectivity working
- Confirm environment is ready
  - Correct versions installed
  - Environment variables set
  - Permissions configured

### 4. Create Task List

- Break down steps into specific tasks
  - List all major tasks
  - Identify subtasks
  - Estimate time for each
- Identify potential challenges
  - Technical challenges
  - Integration points
  - Unknown areas
- Note any questions or uncertainties
  - What needs clarification
  - What might need research
  - What could go wrong
- Plan the approach
  - Order of operations
  - Parallel vs sequential work
  - Checkpoints for validation

### 5. Estimate Time

- Review estimated time for assignment
  - Understand the baseline estimate
  - Consider assignment complexity
- Consider your specific context
  - Your familiarity with tech stack
  - Complexity of the project
  - Any unique challenges
- Add buffer for unexpected issues
  - 20-30% buffer recommended
  - More for unfamiliar territory
  - Less for well-known tasks
- Plan accordingly
  - Schedule uninterrupted time
  - Plan for breaks
  - Set realistic expectations

### 6. Prepare Environment

- Set up workspace
  - Close unnecessary applications
  - Open required tools
  - Prepare terminal/IDE
- Gather required resources
  - Documentation links
  - Reference materials
  - Example code
- Create backup if needed
  - Commit current state
  - Tag important points
  - Document starting point

**Only proceed once all preparation steps are complete.**

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

## Progress Reporting

This assignment has multiple steps and may take 60-90 minutes. Report progress at these checkpoints:

### Checkpoint 1: Entry Point and Core Structure (25% complete)

**Tasks**:
- [ ] Application entry point created
- [ ] Application initialization configured
- [ ] Logging/telemetry initialized
- [ ] Error handling configured
- [ ] Core directory structure created

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 1 Complete (25%)
- Completed: main.ts created, logging configured, directory structure established
- Issues: None
- Time remaining: ~60 minutes
- Next: Configure configuration management
```

---

### Checkpoint 2: Configuration Management (50% complete)

**Tasks**:
- [ ] Configuration loader created
- [ ] Configuration validation implemented
- [ ] Configuration schema/types defined
- [ ] Default configuration created
- [ ] Configuration loading tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 2 Complete (50%)
- Completed: Configuration system with validation and schema
- Issues: Had to adjust validation logic for optional fields
- Time remaining: ~40 minutes
- Next: Create common utilities
```

---

### Checkpoint 3: Common Utilities (75% complete)

**Tasks**:
- [ ] Logging utility created
- [ ] Error handling utilities created
- [ ] Validation utilities created
- [ ] Common helper functions created
- [ ] Utilities tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 3 Complete (75%)
- Completed: All utility modules with unit tests
- Issues: None
- Time remaining: ~20 minutes
- Next: Create application scaffolding and health endpoints
```

---

### Final Checkpoint: Complete (100%)

**Tasks**:
- [ ] Application class/module created
- [ ] Dependency injection configured (if applicable)
- [ ] Graceful shutdown handling implemented
- [ ] Health/status endpoints created (if applicable)
- [ ] All validation passed
- [ ] Acceptance criteria verified

**Report**: Provide final summary including:
- All completed work
- Total time taken
- Any issues resolved
- Final status

**Example Report**:
```
✅ Assignment Complete (100%)
- Completed: Full application structure with entry point, configuration, utilities, and health endpoints
- Total time: 75 minutes
- Issues resolved: Configuration validation edge cases
- Status: Ready for review
```

---

### How to Report Progress

After completing each checkpoint, provide a brief update including:

1. **What was completed**:
   - List specific tasks finished
   - Highlight major milestones
   - Note any deliverables created

2. **Any issues encountered**:
   - Describe problems faced
   - Explain how they were resolved
   - Note any ongoing concerns

3. **Estimated time remaining**:
   - Calculate based on progress
   - Adjust for complexity
   - Account for any delays

4. **Next steps**:
   - What comes next
   - Any dependencies
   - Expected timeline

### Progress Tracking Tips

- **Be honest about progress**: Don't overestimate completion
- **Report blockers immediately**: Don't wait until the end
- **Update estimates**: Adjust time estimates as you learn more
- **Document issues**: Keep notes on problems and solutions
- **Celebrate milestones**: Acknowledge progress at each checkpoint

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: Application Entry Point Fails to Start
- **Symptoms**: Application crashes on startup, initialization errors
- **Possible Causes**:
  - Missing dependencies
  - Configuration errors
  - Import/module path issues
  - Circular dependencies
- **Solutions**:
  1. Check all dependencies are installed
  2. Verify configuration is valid
  3. Check import paths are correct
  4. Look for circular dependency issues
  5. Review startup logs for specific errors

#### Error: Configuration Loading Fails
- **Symptoms**: Configuration not loaded, validation errors, missing values
- **Possible Causes**:
  - Missing environment variables
  - Invalid configuration format
  - Schema validation errors
  - File not found errors
- **Solutions**:
  1. Verify all required environment variables are set
  2. Check configuration file syntax
  3. Review validation schema for errors
  4. Ensure configuration files exist in expected locations
  5. Test with minimal configuration first

#### Error: Dependency Injection Container Fails
- **Symptoms**: DI container initialization errors, service resolution failures
- **Possible Causes**:
  - Circular dependencies
  - Missing service registrations
  - Incorrect service lifetimes
  - Interface/implementation mismatches
- **Solutions**:
  1. Check for circular dependencies in service graph
  2. Verify all services are registered
  3. Review service lifetime configurations
  4. Ensure interfaces match implementations
  5. Test service resolution individually

#### Error: Logging/Telemetry Initialization Fails
- **Symptoms**: Logs not appearing, telemetry errors, initialization failures
- **Possible Causes**:
  - Invalid logging configuration
  - Missing logging dependencies
  - Permission issues with log files
  - Network issues for remote logging
- **Solutions**:
  1. Verify logging configuration is valid
  2. Check all logging dependencies are installed
  3. Ensure write permissions for log files
  4. Test with console logging first
  5. Review logging framework documentation

#### Error: Health Endpoint Not Working
- **Symptoms**: Health endpoint returns errors, dependency checks fail
- **Possible Causes**:
  - Dependencies not initialized
  - Incorrect endpoint configuration
  - Network/port binding issues
  - Health check logic errors
- **Solutions**:
  1. Verify all dependencies are initialized before health check
  2. Check endpoint route configuration
  3. Ensure port is not already in use
  4. Test health check logic independently
  5. Review health check timeout settings

### Escalation Procedure

If errors persist after troubleshooting:

1. **Document the Error**:
   - Full error message and stack trace
   - Steps that led to the error
   - Environment details (OS, runtime version, etc.)
   - What solutions were attempted
   - Any relevant configuration files

2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug" and "needs-investigation"
   - Link to this assignment
   - Include reproduction steps

3. **Notify User**:
   - Report the error to the user
   - Provide error details and context
   - Request manual intervention
   - Suggest potential next steps

4. **Do Not Proceed**:
   - Do not mark assignment as complete
   - Do not proceed to next assignment
   - Wait for error resolution
   - Document the blocker

### Rollback Procedure

If changes need to be reverted:

1. **Assess Impact**:
   - Determine what changes were made
   - Identify what needs to be rolled back
   - Check for dependencies on the changes

2. **Perform Rollback**:
   - Use git to revert changes: `git checkout -- .` or `git reset --hard`
   - Delete generated files/directories
   - Restore from backup if available
   - Clean build artifacts

3. **Verify Rollback**:
   - Confirm system is in previous state
   - Test that previous functionality still works
   - Verify no orphaned files remain

4. **Document Rollback**:
   - Document what was rolled back and why
   - Record lessons learned
   - Update issue/ticket with rollback details
   - Plan next steps

### Prevention Tips

To avoid common errors:

1. **Before Starting**:
   - Read assignment completely
   - Verify prerequisites are met
   - Check environment is properly configured
   - Ensure you have necessary permissions

2. **During Execution**:
   - Follow steps exactly as specified
   - Verify each step before proceeding
   - Test incrementally (don't wait until the end)
   - Keep notes of what you've done

3. **After Completion**:
   - Run all verification commands
   - Check acceptance criteria are met
   - Document any deviations from plan
   - Create validation report

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
