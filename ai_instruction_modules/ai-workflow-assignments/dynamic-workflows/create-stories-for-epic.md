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
  - if not provided, have agent find it
- `$repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace
- `$epic_issue` (required)
 - GitHub issue # of the epic to process (e.g., "Epic 1", "Epic 2", etc.)
- `$parallel_execution` (optional, default: `false`)
  - Whether to attempt parallel execution (currently ignored - always runs serially)

### Declarations

#### getplanissue($issue_number, $repository)
Retrieves the plan issue from the specified repository.
- **Input:** Issue number and repository path
- **Returns:** Issue object containing the application development plan
- **Example:** `getplanissue(42, "myorg/myrepo")` returns issue #42 from myorg/myrepo

#### getepic($epic, $repository)
Retrieves the epic issue from the specified repository.
- **Input:** Epic issue number or object and repository path
- **Returns:** Epic issue object containing the epic description and requirements
- **Example:** `getepic(15, "myorg/myrepo")` returns epic issue #15 from myorg/myrepo

#### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]`


### create-stories-for-epic

`$plan_issue` = getplanissue($plan_issue_number, $repository)
`$target_epic` = getepic($epic_issue, $repository)
`$stories` = getstories($target_epic)

const `$PARALLEL_EPIC_BREAKDOWN`: `false`

# SERIAL MODE: Create stories one at a time (parallel execution is disabled for validation)
For each `$story` in `$stories`, you will:
   - assign the agent the `create-story` assignment with inputs `$target_epic` and `$story`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#create-stories-for-epic.create-story`

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