# Event Handler: on-error

## Event ID
`on-error`

## Trigger
Fires when any step fails, validation check fails, or unexpected error occurs during workflow execution.

## Purpose
Provides structured error recovery, diagnostic information capture, and decision-making for retry/abort strategies.

## Default Behavior

When this event fires, the orchestrator should:

### 1. Error Report
Generate detailed error diagnostic:

**Format:**
```
=== ERROR: <step-name> ===
Type: <error-type>
Message: <error-message>
Location: <file:line> or <step-id>
Context:
  - currentStep: <step-name>
  - completedSteps: <step-list>
  - workflowState: <state-dump>
Stack Trace:
  <stack-trace-if-available>
```

### 2. Context Capture
Preserve execution state for analysis:
- Capture all variable values at failure point
- Record last successful step
- Save intermediate outputs
- Collect relevant log files or command output
- Take snapshots of modified files

### 3. Root Cause Analysis
Attempt automatic diagnosis:
- **Validation failure**: Compare expected vs actual outputs
- **Command failure**: Parse stderr for common error patterns
- **Build failure**: Extract compilation errors
- **Network failure**: Check connectivity and timeouts
- **Authentication failure**: Verify credentials and permissions

### 4. Recovery Options
Present recovery strategies based on error type:

**Retry** (transient failures):
- Network timeouts
- Rate limiting
- Resource temporarily unavailable

**Skip** (non-critical failures):
- Optional validation checks
- Documentation generation
- Non-blocking warnings

**Rollback** (corrupted state):
- Revert file changes
- Delete incomplete artifacts
- Restore from checkpoint

**Abort** (fatal errors):
- Missing required dependencies
- Invalid configuration
- Authorization failures
- Unrecoverable state corruption

### 5. User Prompt (Default)
Present error and options:
```
❌ Error in step: configure-database

Message: Connection string not found in environment
Options:
  1. Retry with updated environment
  2. Skip database configuration (manual setup required)
  3. Rollback changes and abort
  4. Edit configuration and continue

Your choice [1-4]:
```

## Parameters

The following context is available during this event:

| Parameter | Type | Description |
|-----------|------|-------------|
| `$error` | Object | Error object with message, type, stack |
| `$errorType` | String | Category: validation, command, build, network, auth |
| `$step` | String | Step name where error occurred |
| `$completedSteps` | Array | List of successfully completed steps |
| `$workflowState` | Object | Current workflow state snapshot |
| `$lastOutput` | Object | Output from last successful step |
| `$retryCount` | Number | Number of retry attempts for this step |

## Example Usage

### In Dynamic Workflow Script

```markdown
## Events

### on-error
When errors occur:
- Automatically retry network failures up to 3 times
- For build failures, show full compiler output
- Save error state to .workflow-error.json
- Rollback any partial database migrations
```

### Orchestrator Implementation

When an error occurs:

1. Execute default behavior (error report, context capture, diagnosis)
2. Execute custom error handler (if defined in workflow)
3. Present recovery options or apply automatic recovery
4. If retrying, return to failed step
5. If aborting, fire workflow-aborted event

## Migration from ERROR_RECOVERY_TEMPLATE

**Old Pattern** (Static template inclusion):
```markdown
## Assignment: create-application

If errors occur, follow:
- ai_instruction_modules/ai-workflow-assignments/ERROR_RECOVERY_TEMPLATE.md
```

**New Pattern** (Event-driven):
```markdown
## Assignment: create-application

## Events

### on-error
- For package installation failures: clear npm cache and retry
- For Docker build failures: check Docker daemon status
- Log all errors to .errors.log
- Abort on authentication failures

## Steps
...
```


## Error Recovery Decision Tree

```
Error Detected
    ├─ Transient? (network, rate-limit)
    │   └─ Retry with backoff (max 3 attempts)
    │
    ├─ Configuration? (missing env, invalid config)
    │   ├─ Prompt user for correction
    │   └─ Retry with updated configuration
    │
    ├─ Validation? (output mismatch, missing files)
    │   ├─ Show diff: expected vs actual
    │   └─ Prompt: fix and retry, skip, abort
    │
    ├─ Fatal? (auth failure, missing dependency)
    │   └─ Abort with diagnostic report
    │
    └─ Unknown?
        └─ Prompt user: retry, skip, abort
```

## Benefits

1. **Structured Recovery**: Consistent error handling across workflows
2. **Diagnostic Capture**: Complete context for debugging
3. **Smart Retry**: Automatic recovery for transient failures
4. **State Preservation**: Resume from failure point
5. **Workflow-Specific**: Custom error strategies per workflow

## Related Events

- **pre-script-begin**: Initial validation to prevent common errors
- **post-step-complete**: Checkpoint for recovery
- **workflow-aborted**: Fires when error recovery fails
