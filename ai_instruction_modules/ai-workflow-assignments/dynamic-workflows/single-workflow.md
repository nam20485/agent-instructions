# Dynamic Workflow: Single Workflow Assignment Executor

## Overview

This dynamic workflow serves as a generic "cradle" for executing any single workflow assignment. It takes a workflow assignment name as input and assigns it to an agent, waiting for completion. This is useful for workflow assignments that don't require complex orchestration but benefit from the dynamic workflow structure (events, outputs, validation).

This workflow is designed to be used with the `orchestrate-dynamic-workflow` assignment.

## Use Cases

Use this workflow when you want to:
- Execute a workflow assignment with dynamic workflow features (events, outputs)
- Wrap a workflow assignment for consistent orchestration patterns
- Add pre/post execution hooks to any workflow assignment
- Track workflow assignment execution with structured outputs
- Validate workflow assignment completion systematically

**Examples:**
- `update-from-feedback` - Process feedback documents with validation
- `debrief-and-document` - Generate debrief reports with completion tracking
- `create-repository-summary` - Create AI documentation with verification
- `analyze-plan-issue` - Analyze plans with structured output
- Any workflow assignment that benefits from event-driven execution

## Script

### Inputs

- `$workflow_assignment` (required)
  - The short ID of the workflow assignment to execute
  - Must be a valid workflow assignment name (e.g., "update-from-feedback", "debrief-and-document")
  - The assignment file must exist in `ai_instruction_modules/ai-workflow-assignments/`
- `$assignment_inputs` (optional)
  - Object containing input parameters for the workflow assignment
  - Structure depends on the specific workflow assignment being executed
  - Pass as key-value pairs matching the assignment's expected inputs
- `$description` (optional)
  - Brief description of what this execution is for
  - Useful for logging and tracking purposes
  - Example: "Processing feedback from Epic #7 debrief"

### Helper Functions

#### validate_workflow_assignment($workflow_assignment)
Validates that a workflow assignment exists and is executable.
- **Input:** Workflow assignment short ID (string)
- **Returns:** Boolean indicating if the assignment is valid
- **Actions:**
  - Checks if assignment file exists at expected path
  - Verifies assignment file has required sections (Goal, Acceptance Criteria, Assignment)
  - Validates assignment short ID matches file naming convention
  - Returns `true` if valid, `false` if not found or invalid
- **Example:** `validate_workflow_assignment("update-from-feedback")` returns `true`

#### get_assignment_acceptance_criteria($workflow_assignment)
Retrieves the acceptance criteria from a workflow assignment definition.
- **Input:** Workflow assignment short ID (string)
- **Returns:** Array of acceptance criteria strings
- **Actions:**
  - Reads the workflow assignment file
  - Extracts the "Acceptance Criteria" section
  - Parses criteria into an array
  - Returns list of criteria for validation
- **Example:** `get_assignment_acceptance_criteria("update-from-feedback")` returns `["All feedback items categorized", "Action plan created", ...]`

#### verify_acceptance_criteria($workflow_assignment, $output)
Verifies that all acceptance criteria for the assignment are met.
- **Input:** Workflow assignment short ID and agent output/work artifacts
- **Returns:** Object with `all_met` (boolean) and `criteria_status` (array of {criterion, status, evidence})
- **Actions:**
  - Gets acceptance criteria for the assignment
  - Reviews agent output and work artifacts
  - Checks each criterion against output
  - Documents evidence for each criterion
  - Returns verification results
- **Example:** `verify_acceptance_criteria("update-from-feedback", $output)` returns verification object

### single-workflow

# Step 0: Validate inputs and assignment
if `$workflow_assignment` is not provided:
   - log: "ERROR: No workflow assignment specified. Must provide $workflow_assignment input."
   - record error as `#single-workflow.no-assignment`
   - exit workflow with failure status

- log: "Single Workflow Executor starting"
- log: "Workflow Assignment: {workflow_assignment}"
if `$description` is provided:
   - log: "Description: {description}"

# Validate that the workflow assignment exists
`$is_valid` = validate_workflow_assignment($workflow_assignment)

if `$is_valid` is `false`:
   - log: "ERROR: Workflow assignment '{workflow_assignment}' is not valid or does not exist"
   - log: "Check that the assignment file exists at: ai_instruction_modules/ai-workflow-assignments/{workflow_assignment}.md"
   - record error as `#single-workflow.invalid-assignment`
   - exit workflow with failure status

- log: "Workflow assignment '{workflow_assignment}' validated successfully"
- record validation as `#single-workflow.assignment-validated`

# Step 1: Retrieve assignment acceptance criteria
`$acceptance_criteria` = get_assignment_acceptance_criteria($workflow_assignment)

- log: "Retrieved {acceptance_criteria.length} acceptance criteria for '{workflow_assignment}'"
- log: "Acceptance criteria will be used for validation after execution"
- record criteria as `#single-workflow.acceptance-criteria`

# Step 2: Execute the workflow assignment
- log: "Assigning '{workflow_assignment}' to agent for execution"

if `$assignment_inputs` is provided:
   - log: "Passing inputs to assignment: {assignment_inputs}"
   - assign an agent the `$workflow_assignment` assignment with inputs `$assignment_inputs`
else:
   - log: "No inputs provided, executing assignment with defaults"
   - assign an agent the `$workflow_assignment` assignment

- wait until the agent completes the assignment
- record agent output as `#single-workflow.assignment-output`
- log: "Agent completed '{workflow_assignment}' assignment"

# Step 3: Verify acceptance criteria
- log: "Verifying acceptance criteria for '{workflow_assignment}'"

`$verification` = verify_acceptance_criteria($workflow_assignment, `#single-workflow.assignment-output`)

if `$verification.all_met` is `false`:
   - log: "WARNING: Not all acceptance criteria were met"
   - log: "Criteria status:"
   for each `$criterion` in `$verification.criteria_status`:
      if `$criterion.status` is `false`:
         - log: "  ❌ {criterion.criterion}"
      else:
         - log: "  ✅ {criterion.criterion}"
   
   - record verification as `#single-workflow.verification-failed`
   - log: "Review output and criteria to determine if deviation is acceptable"
   # Note: Not failing workflow automatically - allow manual review
else:
   - log: "✅ All acceptance criteria met for '{workflow_assignment}'"
   - record verification as `#single-workflow.verification-passed`

# Step 4: Record completion
- log: "Single Workflow Executor completed successfully"
- log: "Workflow assignment '{workflow_assignment}' execution finished"
- record final output as `#single-workflow.complete`

### Events

#### `pre-assignment-begins`

This event runs before the main workflow assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begins.gather-context`

#### `pre-script-begin`

- log: "Pre-execution: Single Workflow Executor"
- log: "Workflow assignment to execute: {workflow_assignment}"
if `$description` is provided:
   - log: "Execution purpose: {description}"

# Verify agent has necessary permissions
- verify agent has access to workflow assignment files
- verify agent can create/update GitHub issues if required by assignment
- verify agent has access to required input resources (if `$assignment_inputs` provided)

- record pre-flight checks as `#events.pre-script-begin`

#### `post-assignment-completion`

# This event runs after the workflow assignment completes
- log: "Post-assignment: '{workflow_assignment}' completed"

# First report progress
- assign the agent the `report-progress` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.post-assignment-completion.report-progress`

# Then collect execution metadata
`$execution_time` = calculate time elapsed since assignment start
- log: "Execution time: {execution_time}"

# Check for common deliverables
- check if agent created GitHub issues (record issue numbers)
- check if agent created documentation files (record file paths)
- check if agent updated existing files (record changed files)

- record post-assignment metadata as `#events.post-assignment-completion`

#### `on-assignment-failure`

# This event runs if the workflow assignment fails
- log: "ERROR: Workflow assignment '{workflow_assignment}' failed"
- log: "Failure occurred during assignment execution"

# First recover from the error
- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

# Then capture failure context
- capture error message and stack trace if available
- identify which step of the assignment failed
- collect agent output/logs up to failure point

# Provide troubleshooting guidance
- log: "Troubleshooting steps:"
- log: "  1. Review assignment acceptance criteria"
- log: "  2. Check agent output for error messages"
- log: "  3. Verify all required inputs were provided"
- log: "  4. Check that assignment file is valid and up-to-date"

- record failure details as `#events.on-assignment-failure`

#### `post-script-complete`

# This event runs after the entire workflow completes successfully
- log: "Single Workflow Executor completed successfully"

# Generate completion summary
`$summary` = {
   workflow_assignment: $workflow_assignment,
   description: $description,
   acceptance_criteria_met: $verification.all_met,
   execution_time: $execution_time,
   outputs: `#single-workflow.assignment-output`,
   verification: $verification
}

- log: "Completion Summary:"
- log: "  Workflow Assignment: {summary.workflow_assignment}"
- log: "  All Criteria Met: {summary.acceptance_criteria_met}"
- log: "  Execution Time: {summary.execution_time}"

# Optional: Create completion issue or update tracking
if workflow requires tracking:
   - create or update GitHub issue with completion summary
   - link to relevant artifacts created during execution

- record completion summary as `#events.post-script-complete`

#### `on-script-failure`

# This event runs if the entire workflow fails
- log: "CRITICAL: Single Workflow Executor failed"
- log: "Workflow assignment: {workflow_assignment}"

# Capture full failure context
- identify failure point (validation, execution, verification)
- capture all outputs and logs
- identify root cause if possible

# Generate failure report
`$failure_report` = {
   workflow_assignment: $workflow_assignment,
   description: $description,
   failure_point: [identify where failure occurred],
   error_message: [capture error],
   outputs_collected: [list artifacts],
   acceptance_criteria_status: $verification.criteria_status
}

- log: "Failure Report:"
- log: "  Assignment: {failure_report.workflow_assignment}"
- log: " Failure Point: {failure_report.failure_point}"
- log: " Error: {failure_report.error_message}"

# Provide recovery guidance
- log: "Recovery Options:"
- log: "  1. Fix input parameters and retry"
- log: "  2. Review assignment definition for issues"
- log: "  3. Check that prerequisites are met"
- log: " 4. Escalate to stakeholder if systemic issue"

- record failure report as `#events.on-script-failure`
- do NOT automatically retry (preserve state for investigation)

## Usage Examples

### Example 1: Execute update-from-feedback

```bash
# Execute update-from-feedback workflow with feedback directory input
orchestrate-dynamic-workflow single-workflow \
  --workflow-assignment "update-from-feedback" \
  --assignment-inputs '{"directory": "./debriefs"}' \
  --description "Process feedback from Epic #7 implementation"
```

This will:
1. Validate that `update-from-feedback` assignment exists
2. Retrieve its acceptance criteria
3. Assign the workflow to an agent with the debriefs directory input
4. Wait for completion
5. Verify all acceptance criteria were met
6. Generate completion report

### Example 2: Execute debrief-and-document

```bash
# Execute debrief-and-document workflow
orchestrate-dynamic-workflow single-workflow \
  --workflow-assignment "debrief-and-document" \
  --description "Create debrief report for project-setup workflow"
```

This will:
1. Validate the debrief-and-document assignment
2. Execute without specific inputs (uses defaults or prompts)
3. Verify acceptance criteria
4. Record completion

### Example 3: Execute create-repository-summary

```bash
# Execute create-repository-summary workflow
orchestrate-dynamic-workflow single-workflow \
  --workflow-assignment "create-repository-summary" \
  --assignment-inputs '{"repository_path": "/path/to/repo"}' \
  --description "Generate AI repository summary for new project"
```

### Example 4: Execute without description

```bash
# Simple execution with minimal parameters
orchestrate-dynamic-workflow single-workflow \
  --workflow-assignment "analyze-plan-issue" \
  --assignment-inputs '{"issue_number": 42}'
```

## Integration with Other Workflows

### As a Building Block

The `single-workflow` dynamic workflow can be used as a building block in larger orchestration workflows:

```markdown
# In a larger dynamic workflow

# Step 3: Process feedback
- log: "Processing feedback from previous phase"
- assign an agent the `orchestrate-dynamic-workflow` assignment with:
  - workflow: "single-workflow"
  - inputs: {
      workflow_assignment: "update-from-feedback",
      assignment_inputs: {directory: "./feedback"},
      description: "Process Phase 1 feedback"
    }
- wait until agent completes
- record output as `#phase1.feedback-processed`
```

### Chaining Multiple Single Workflows

Execute multiple workflow assignments in sequence:

```markdown
# Execute a series of documentation workflows

For each `$workflow` in ["create-repository-summary", "debrief-and-document", "analyze-progress-doc"]:
   - assign an agent the `orchestrate-dynamic-workflow` assignment with:
     - workflow: "single-workflow"
     - inputs: {workflow_assignment: $workflow}
   - wait until completion
   - record output as `#docs.$workflow`
```

## Best Practices

### 1. Always Provide Description
Even though description is optional, always provide it for clarity:
```bash
--description "Process Epic #7 feedback after implementation"
```

### 2. Validate Assignment Inputs
Ensure your `assignment_inputs` match what the workflow assignment expects:
```json
{
  "directory": "./debriefs",  // update-from-feedback expects 'directory'
  "issue_number": 42          // analyze-plan-issue expects 'issue_number'
}
```

### 3. Review Acceptance Criteria
Before execution, review the assignment's acceptance criteria to know what to expect:
```bash
# Check what the assignment requires
cat ai_instruction_modules/ai-workflow-assignments/update-from-feedback.md
# Look for "Acceptance Criteria" section
```

### 4. Monitor Event Outputs
Events provide valuable execution context:
- `#events.pre-script-begin` - Pre-flight checks
- `#events.post-assignment-completion` - Execution metadata
- `#events.post-script-complete` - Completion summary

### 5. Handle Verification Failures
If acceptance criteria aren't met, review the verification output:
```markdown
`$verification.criteria_status` contains:
- criterion: "All feedback items categorized"
- status: false
- evidence: "Only 5 of 8 items categorized"
```

## Troubleshooting

### Problem: "Workflow assignment not found"

**Cause:** Invalid workflow assignment short ID or file doesn't exist

**Solution:**
- Verify the short ID matches the file name
- Check file exists at: `ai_instruction_modules/ai-workflow-assignments/<shortid>.md`
- Ensure you're using the short ID, not the full title

### Problem: "Acceptance criteria not met"

**Cause:** Agent didn't complete all required criteria

**Solution:**
- Review `#single-workflow.verification-failed` output
- Check which specific criteria failed
- Review agent output to understand why
- May need to rerun with additional guidance or inputs

### Problem: "Agent failed during execution"

**Cause:** Error in the workflow assignment execution

**Solution:**
- Check `#events.on-assignment-failure` for error details
- Review assignment file for issues
- Verify all required inputs were provided
- Check that prerequisites are met

### Problem: "Missing assignment inputs"

**Cause:** Workflow assignment requires inputs but none provided

**Solution:**
- Review assignment file to see what inputs are required
- Provide `--assignment-inputs` with required parameters
- Use correct key names matching assignment expectations

## Notes

- This workflow provides a **thin orchestration layer** around any workflow assignment
- The **validation step** ensures the assignment exists before execution
- The **verification step** checks acceptance criteria but doesn't automatically fail
- Events provide **execution hooks** for logging, tracking, and troubleshooting
- This pattern can be **reused** for any workflow assignment that doesn't need complex orchestration
- The workflow is **idempotent** - can be safely rerun with same inputs
- **Failure handling** preserves state for investigation rather than automatic retry

## Extensibility

### Adding Custom Events

You can extend this workflow with custom events:

```markdown
#### `pre-assignment-validation`
# Add custom validation before assignment execution
- verify specific preconditions
- check environment state
- validate input data
- record validation as `#events.pre-assignment-validation`
```

### Adding Output Transformations

Transform assignment outputs for specific needs:

```markdown
# After Step 2
`$transformed_output` = transform_output(`#single-workflow.assignment-output`, format="json")
- record transformed output as `#single-workflow.transformed-output`
```

### Adding Notifications

Notify stakeholders on completion:

```markdown
#### `post-script-complete` (extended)
# ... existing completion logic ...

# Send notification
- notify stakeholders via [method]
- include completion summary
- link to artifacts created
```

---

**Workflow Created By:** Orchestration Team  
**Version:** 1.0  
**Date:** 2025-10-19  
**Status:** Ready for Use

---

**Use this workflow when:** You need to execute a single workflow assignment with dynamic workflow features (events, validation, structured outputs) but don't need complex orchestration logic.
