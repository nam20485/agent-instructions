# Event Handler: pre-script-begin

## Event ID
`pre-script-begin`

## Trigger
Fires immediately before a dynamic workflow script begins execution, after the script has been fetched and parsed but before any steps are executed.

## Purpose
Provides a checkpoint for the orchestrator to verify readiness, validate context, and establish execution prerequisites before committing to workflow execution.

## Default Behavior

When this event fires, the orchestrator should:

### 1. Resolution Trace
Print a complete resolution trace showing:
- **Script source**: URL or path of the workflow file
- **Canonical SHA/version**: Commit hash or version identifier
- **Assignment dependencies**: List of all assignment IDs referenced in the script
- **Assignment resolutions**: URL and SHA for each assignment file
- **Variable context**: Initial values of all script variables

**Example Output:**
```
=== WORKFLOW RESOLUTION TRACE ===
Script: https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/new-project.md
SHA: abc123def456
Dependencies:
  - create-app-plan (def789abc012)
  - create-project-structure (456789def012)
  - create-application (789abc012def)
Context:
  $projectName = "MyProject"
  $targetFramework = "net9.0"
```

### 2. Context Validation
Verify that all required inputs are available:
- Check that all required script parameters have been provided
- Validate that constants are defined and immutable
- Confirm that referenced assignments exist and are accessible
- Verify repository state (branch, working directory status)

### 3. Branch Protection Check
Determine execution strategy based on target branch:
- **Protected branch (main)**: Confirm feature branch + PR workflow will be used
- **Development branch**: Direct commits may be allowed
- **Feature branch**: Direct commits allowed

### 4. Acceptance Criteria Loading
Extract and display Definition of Done from the workflow script:
- Parse acceptance criteria section
- Display as checklist
- Prepare validation tracking structure

### 5. User Confirmation (Optional)
For high-impact workflows, present summary and await confirmation:
```
About to execute: new-project workflow
Affects: Repository structure, CI/CD configuration
Acceptance Criteria: 5 items
Branch Strategy: Feature branch → PR to main
Proceed? [y/n]
```

## Parameters

The following context is available during this event:

| Parameter | Type | Description |
|-----------|------|-------------|
| `$script` | Object | Parsed workflow script object |
| `$scriptUrl` | String | Canonical URL of the workflow file |
| `$scriptSha` | String | Version identifier (commit SHA) |
| `$inputs` | Object | All input parameters provided |
| `$assignments` | Array | List of assignment IDs referenced |
| `$repository` | Object | Current repository state |
| `$branch` | String | Target branch name |
| `$isProtected` | Boolean | Whether target branch has protection rules |

## Example Usage

### In Dynamic Workflow Script

```markdown
## Events

### pre-script-begin
Before starting this workflow:
- Verify that .NET SDK 9.0+ is installed
- Confirm Docker is running (for container builds)
- Check that GitHub CLI is authenticated
- Validate project name follows naming conventions
```

### Orchestrator Implementation

When the orchestrator encounters a workflow script with event handlers defined, it should:

1. Parse the event handler content
2. Execute the default behavior first (resolution trace, validation, etc.)
3. Execute any custom event handler content specified in the script
4. Gate execution on all checks passing

## Migration from BEFORE_STARTING_TEMPLATE

**Old Pattern** (Static template inclusion):
```markdown
## Assignment: orchestrate-new-project

Read and follow the instructions in:
- ai_instruction_modules/ai-workflow-assignments/BEFORE_STARTING_TEMPLATE.md

Then proceed with workflow execution...
```

**New Pattern** (Event-driven):
```markdown
## Assignment: orchestrate-new-project

## Events

### pre-script-begin
- Verify Node.js v20+ is installed
- Confirm npm packages are available
- Check repository is clean

## Steps
...
```

## Benefits

1. **Dynamic Composition**: Each workflow declares its own pre-execution requirements
2. **Single Source of Truth**: Event behavior lives with the workflow, not in separate templates
3. **Version Control**: Event handlers evolve with the workflow they support
4. **Reduced Indirection**: No need to fetch multiple template files
5. **Flexibility**: Workflows can override or extend default behavior

## Related Events

- **post-script-complete**: Fires after all workflow steps complete successfully
- **on-error**: Fires when any step or validation fails
- **pre-create-assignment**: Fires before delegating to a collaborator agent
