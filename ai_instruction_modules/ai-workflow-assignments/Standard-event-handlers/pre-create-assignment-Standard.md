# Event Handler: pre-create-assignment

## Event ID
`pre-create-assignment`

## Trigger
Fires immediately before delegating work to a collaborator agent through an assignment, after the assignment has been resolved but before the collaborator agent is invoked.

## Purpose
Provides a checkpoint for validating delegation readiness, preparing context, and establishing acceptance criteria before assigning work to a collaborator.

## Default Behavior

When this event fires, the orchestrator should:

### 1. Assignment Resolution Trace
Print delegation details:

**Format:**
```
=== DELEGATING ASSIGNMENT: <assignment-id> ===
Assignment: https://raw.githubusercontent.com/.../assignments/<assignment-id>.md
SHA: abc123def456
Collaborator: <agent-role>
Inputs:
  - $parameter1: value1
  - $parameter2: value2
Context:
  - Parent workflow: <workflow-name>
  - Current step: <step-name>
```

### 2. Context Preparation
Package all required context for the collaborator:
- Input parameters and their values
- Relevant output from previous steps
- Repository state and branch information
- Configuration files or environment settings
- Any constraints or requirements from parent workflow

### 3. Acceptance Criteria Extraction
Load and display the assignment's Definition of Done:
```
Acceptance Criteria for <assignment-id>:
  ☐ Criterion 1
  ☐ Criterion 2
  ☐ Criterion 3
```

### 4. Validation Gate
Verify delegation prerequisites:
- All required input parameters are provided
- Assignment file is accessible and valid
- No conflicting work in progress
- Repository state is clean (or expected state)

### 5. Delegation Log
Record delegation for audit trail:
```
[2025-04-21 10:23:45] Delegating: create-app-plan
  Parent: orchestrate-new-project
  Step: #plan-application
  Agent: Planner
  Tracking: delegation-001
```

## Parameters

The following context is available during this event:

| Parameter | Type | Description |
|-----------|------|-------------|
| `$assignmentId` | String | Unique ID of the assignment |
| `$assignmentUrl` | String | Canonical URL of assignment file |
| `$assignmentSha` | String | Version (commit SHA) |
| `$inputs` | Object | Input parameters for assignment |
| `$agentRole` | String | Collaborator role (e.g., "Developer") |
| `$parentWorkflow` | String | Name of calling workflow |
| `$currentStep` | String | Step initiating delegation |
| `$acceptanceCriteria` | Array | List of success criteria |

## Example Usage

### In Dynamic Workflow Script

```markdown
## Events

### pre-create-assignment
Before delegating to collaborators:
- Ensure working directory is clean
- Create delegation tracking issue on GitHub
- Set environment variable DELEGATED_BY=orchestrator
```

### Orchestrator Implementation

Before invoking a collaborator agent:

1. Execute default behavior (resolution trace, context prep, validation)
2. Execute custom event handler (if defined)
3. Verify all gates pass
4. Invoke collaborator with prepared context
5. Start tracking delegation

## Use Case: Concurrent Delegations

When delegating multiple assignments in parallel:

```markdown
### parallel-implementation
$tasks = [implement-auth, implement-api, implement-ui]

For each $task in $tasks:
  - Fire pre-create-assignment for $task
  - Delegate $task to Developer agent
  - Track with unique ID
```

This ensures each delegation gets:
- Proper resolution trace
- Context packaging
- Acceptance criteria loading
- Audit logging

## Benefits

1. **Delegation Visibility**: Clear record of what work was assigned
2. **Context Completeness**: Ensures collaborator has everything needed
3. **Acceptance Clarity**: Collaborator knows Definition of Done upfront
4. **Audit Trail**: Track delegation chains across workflows
5. **Failure Prevention**: Catch missing inputs before delegation

## Related Events

- **post-assignment-complete**: Fires when collaborator finishes
- **on-error**: Fires if delegation fails or collaborator reports error
- **post-step-complete**: Parent workflow step tracking
