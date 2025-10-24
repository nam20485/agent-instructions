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

# Step 1: Execute the workflow assignment
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

### Events

#### `pre-assignment-begins`

This event runs before EACH assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begins.gather-context`

#### `on-assignment-failure`

This event runs when ANY assignment fails to recover from errors systematically.

- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-completion`

This event runs after EACH assignment completes to report progress and validate the work.

`$progress_and_validation_assignments` = [
                     `create-repository-summary`,     
                     `validate-assignment-completion`,
                     `report-progress`
                 ]

For each `$pv_assignment_name` in `$progress_and_validation_assignments`, you will:
   - assign the agent the `$pv_assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
     - if `$pv_assignment_name` is `validate-assignment-completion`:
     - if validation failed, halt workflow and request manual intervention # Halt workflow to prevent further execution with invalid state
     - if validation passed, proceed to next assignment in `$progress_and_validation_assignments`
   - record output as `#events.post-assignment-completion.$pv_assignment_name`

---

**Workflow Created By:** Orchestration Team  
**Version:** 1.0  
**Date:** 2025-10-19  
**Status:** Ready for Use

---

**Use this workflow when:** You need to execute a single workflow assignment with dynamic workflow features (events, validation, structured outputs) but don't need complex orchestration logic.
