# Event Handler: post-step-complete

## Event ID
`post-step-complete`

## Trigger
Fires immediately after a workflow step completes successfully, before proceeding to the next step.

## Purpose
Provides a checkpoint for progress tracking, intermediate validation, and output capture after each step execution.

## Default Behavior

When this event fires, the orchestrator should:

### 1. Progress Report
Generate a structured progress update:

**Format:**
```
=== STEP COMPLETE: <step-name> ===
Status: ✓ COMPLETE
Duration: <elapsed-time>
Outputs:
  - <key-output-1>: <value-or-location>
  - <key-output-2>: <value-or-location>
Progress: <completed-steps>/<total-steps> (<percentage>%)
Next: <next-step-name>
```

### 2. Output Capture
Record step outputs for use in subsequent steps:
- Store output values in workflow context
- Update variable bindings
- Record file paths, URLs, or identifiers created
- Tag outputs with step reference (e.g., `#create-structure.projectDir`)

### 3. Validation Check
Verify step acceptance criteria:
- Check that all expected outputs exist
- Validate output format/structure
- Confirm side effects occurred (files created, services deployed, etc.)
- Run quick smoke tests if applicable

### 4. Checkpoint State
Save workflow state for recovery:
- Record completed steps
- Capture current variable state
- Note any warnings or issues encountered
- Enable resume-from-checkpoint if workflow is interrupted

### 5. User Notification (Optional)
For long-running workflows, provide periodic updates:
```
✓ Step 3/8 complete: Application structure created
  Created 24 files in src/MyApp/
  Next: Configure CI/CD pipeline
```

## Parameters

The following context is available during this event:

| Parameter | Type | Description |
|-----------|------|-------------|
| `$step` | Object | Completed step details |
| `$stepName` | String | Name of the completed step |
| `$outputs` | Object | Outputs produced by the step |
| `$duration` | Number | Step execution time (ms) |
| `$completedSteps` | Number | Count of completed steps |
| `$totalSteps` | Number | Total steps in workflow |
| `$nextStep` | String | Name of next step (if any) |
| `$workflowState` | Object | Current workflow execution state |

## Example Usage

### In Dynamic Workflow Script

```markdown
## Events

### post-step-complete
After each step:
- Commit changes with message: "Complete: <step-name>"
- Run `dotnet build` to ensure compilation succeeds
- Update progress tracking issue with step status
```

### Orchestrator Implementation

When the orchestrator completes a step:

1. Execute default behavior (progress report, output capture, validation)
2. Execute custom event handler (if defined in workflow)
3. Update internal state tracking
4. Proceed to next step or fire post-script-complete

## Migration from PROGRESS_REPORTING_TEMPLATE

**Old Pattern** (Static template inclusion):
```markdown
## Assignment: perform-task

After completing each sub-task, follow:
- ai_instruction_modules/ai-workflow-assignments/PROGRESS_REPORTING_TEMPLATE.md
```

**New Pattern** (Event-driven):
```markdown
## Assignment: perform-task

## Events

### post-step-complete
- Log progress to console
- Update GitHub issue with status
- Commit incremental changes

## Steps
...
```

## Benefits

1. **Incremental Visibility**: Track progress at granular step level
2. **Early Detection**: Catch issues before workflow completes
3. **Resume Capability**: Enable restart from last successful checkpoint
4. **Audit Trail**: Complete record of execution flow
5. **Custom Actions**: Workflows define their own progress handling

## Progress Tracking Example

```
=== STEP COMPLETE: create-database-schema ===
Status: ✓ COMPLETE
Duration: 2.3s
Outputs:
  - migrationFile: src/Migrations/20250421_InitialSchema.cs
  - tablesCreated: 8
Progress: 4/7 (57%)
Next: seed-initial-data
```

## Related Events

- **pre-script-begin**: Fires before workflow execution starts
- **on-error**: Fires when step validation or execution fails
- **post-script-complete**: Fires after all steps complete successfully
