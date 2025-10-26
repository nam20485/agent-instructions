# Dynamic Workflow: Create Stories for Epic

## Overview

This dynamic workflow creates story issues for a specific epic within an application development plan. It extracts the specified story bullets from an epic issue, then creates individual story issues for each story using the create-story-v2 assignment. The workflow enforces serial execution for now, creating one story at a time to ensure correctness.

### Parallel Execution and Workspace Management
**How Serial Execution Works:**
- Even when `$parallel_execution` is `true`, the workflow enforces serial execution by hard-coding `$PARALLEL_STORY_CREATION` to `false`
- Each `create-story-v2` task runs sequentially, one after another
- This ensures proper validation of the workflow before enabling parallel execution
- The orchestrator coordinates assignments and collects outputs from each serial agent

**Coordination:**
- The orchestrator waits for each story creation to complete before proceeding to the next
- Issue creation is less conflict-prone than code implementation
- Story issues are created in GitHub's issue tracker, not in the repository code

## Script

### Inputs
- `$epic_issue_number` (required)
 - issue number of the epic to analyze
  - if not provided, have agent find it
- `$repository` (optional)
  - git repo with epic issue to analyze
  - if not provided, use current workspace
- `$parallel_execution` (optional, default: `false`)
  - Whether to attempt parallel execution (currently ignored - always runs serially)

### Declarations

#### getepic($issue_number, $repository)
Retrieves the epic issue from the specified repository.
- **Input:** Issue number and repository path
- **Returns:** Issue object containing the epic description and requirements
- **Example:** `getepic(42, "myorg/myrepo")` returns issue #42 from myorg/myrepo

#### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]`

### create-stories-for-epic

`$epic_issue` = getepic($epic_issue_number, $repository)
`$stories` = getstories($epic_issue)

const `$PARALLEL_STORY_CREATION`: `false`

# SERIAL MODE: Create stories one at a time (parallel execution is disabled for validation)
For each `$story` in `$stories`, you will:
   - assign the agent the `create-story-v2` assignment with inputs `$epic_issue` and `$story`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#create-stories-for-epic.create-story-v2`

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