# Dynamic Workflow: Create Epics for Phase

## Overview

This dynamic workflow creates epic issues for a specific phase within an application development plan. It extracts the specified phase from a plan issue, then creates individual epic issues for each line item in that phase using the create-epic-v2 assignment. The workflow enforces serial execution for now, creating one epic at a time to ensure correctness.

### Parallel Execution and Workspace Management
**How Serial Execution Works:**
- Even when `$parallel_execution` is `true`, the workflow enforces serial execution by hard-coding `$PARALLEL_EPIC_BREAKDOWN` to `false`
- Each `create-epic-v2` task runs sequentially, one after another
- This ensures proper validation of the workflow before enabling parallel execution
- The orchestrator coordinates assignments and collects outputs from each serial agent

**Coordination:**
- The orchestrator waits for each epic creation to complete before proceeding to the next
- Issue creation is less conflict-prone than code implementation
- Epic issues are created in GitHub's issue tracker, not in the repository code

## Script

### Inputs
- `$plan_issue_number` (required)
  - issue number of the plan to analyze
- `$repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace
- `$phase_identifier` (required)
 - identifier of the phase to process (e.g., "Phase 1", "Phase 2", etc.)
- `$parallel_execution` (optional, default: `false`)
  - Whether to attempt parallel execution (currently ignored - always runs serially)

### Declarations

#### getplanissue($issue_number, $repository)
Retrieves the plan issue from the specified repository.
- **Input:** Issue number and repository path
- **Returns:** Issue object containing the application development plan
- **Example:** `getplanissue(42, "myorg/myrepo")` returns issue #42 from myorg/myrepo

#### getphases($plan_issue)
Extracts development phases from the plan issue.
- **Input:** Plan issue object
- **Returns:** Array of phase objects, each containing phase description and requirements and entire content of phase
- **Example:** `getphases($plan_issue)` returns `["Phase 1: Setup", "Phase 2: Core Features", ...]`

#### getphasebyidentifier($phases, $phase_identifier)
Extracts a specific phase from the array of phases.
- **Input:** Array of phase objects and the phase identifier to find
- **Returns:** Single phase object matching the identifier
- **Example:** `getphasebyidentifier($phases, "Phase 1")` returns the Phase 1 object

#### getlineitems($phase)
Extracts line items from a phase that will become individual epics.
- **Input:** Phase object
- **Returns:** Array of line item objects to be converted into epic issues
- **Example:** `getlineitems($phase)` returns `["1.1. Repository and solution bootstrap", "1.2. Core dependencies and configuration", ...]`

### create-epics-for-phase

`$plan_issue` = getplanissue($plan_issue_number, $repository)
`$phases` = getphases($plan_issue)
`$target_phase` = getphasebyidentifier($phases, $phase_identifier)
`$line_items` = getlineitems($target_phase)

const `$PARALLEL_EPIC_BREAKDOWN`: `false`

# SERIAL MODE: Create epics one at a time (parallel execution is disabled for validation)
For each `$line_item` in `$line_items`, you will:
   - assign the agent the `create-epic-v2` assignment with inputs `$target_phase` and `$line_item`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#create-epics-for-phase.create-epic`

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

- assign the agent the `validate-assignment-completion` assignment
- wait until the agent finishes the task
- review the work and approve it
   - if `$pv_assignment_name` is `validate-assignment-completion`:
   - if validation failed, halt workflow and request manual intervention # Halt workflow to prevent further execution with invalid state
   - if validation passed, proceed to next assignment in `$progress_and_validation_assignments`
- record output as `#events.post-assignment-completion.$pv_assignment_name`

#### `post-step-completion`

This event runs after EACH step completes to report progress and validate the work.

- assign the agent the `report-progress` assignment
- record output as `#events.post-step-completion.report-progress`