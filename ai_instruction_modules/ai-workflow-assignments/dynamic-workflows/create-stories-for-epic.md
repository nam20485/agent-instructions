# Dynamic Workflow: Create Stories for Epic

<!-- v2: Added epic JSON interpolation and post-loop verification safeguards (2025-10-29) -->

## Overview

This dynamic workflow creates story issues for a specific epic within an application development plan. It extracts the specified story bullets from an epic issue, then creates individual story issues for each story using the create-story-v2 assignment. The workflow now supports both serial and optional parallel execution so that multiple stories can be created at the same time when it is safe to do so.

### Parallel Execution and Workspace Management
**Choosing an Execution Mode**
- Use serial execution (default) when story sequencing matters, when story definitions depend on one another, or when you need to review each story before creating the next
- Enable parallel execution by setting `$parallel_execution` to `true` when stories are independent and can be created simultaneously to speed up throughput
- Each `create-story-v2` task runs inside its own assignment, so GitHub issue creation remains isolated per story

**Coordination Details**
- The orchestrator checks for existing linked story issues before creating new ones, ensuring idempotent behavior even in parallel mode
- When running in parallel, the orchestrator waits for all story-creation assignments to finish before moving on to downstream work
- Story issues are created in GitHub's issue tracker, so concurrent execution does not modify repository files or create merge conflicts

## Prerequisites

**⚠️ MANDATORY: Pre-Execution Reading Chain (NO EXCEPTIONS)**

**STOP! Before executing this workflow, you MUST read these files in order and LOG each one:**

1. **[ai-core-instructions.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-core-instructions.md)** – Core protocol and rules for all agents
   - Log: "✓ Read ai-core-instructions.md"
2. **[dynamic-workflow-syntax.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)** – Canonical DSL structure and event system requirements
   - Log: "✓ Read dynamic-workflow-syntax.md"
3. **[orchestrate-dynamic-workflow.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/orchestrate-dynamic-workflow.md)** – Orchestration rules, acceptance gating, and run-report guardrails
   - Log: "✓ Read orchestrate-dynamic-workflow.md"
4. **[create-story-v2.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/create-story-v2.md)** – Assignment executed for each story issue that this workflow creates
   - Log: "✓ Read create-story-v2.md"
5. **[gather-context.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/gather-context.md)** – Required for the `pre-assignment-begin` event handler executed before every assignment
   - Log: "✓ Read gather-context.md"
6. **[recover-from-error.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/recover-from-error.md)** – Defines recovery procedures triggered by the `on-assignment-failure` event
   - Log: "✓ Read recover-from-error.md"
7. **[validate-assignment-completion.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/validate-assignment-completion.md)** – Validation workflow enforced after each assignment completes
   - Log: "✓ Read validate-assignment-completion.md"
8. **[report-progress.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/report-progress.md)** – Status reporting assignment invoked by the `post-step-completion` event
   - Log: "✓ Read report-progress.md"
9. **[debrief-and-document.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/debrief-and-document.md)** – Final documentation workflow executed by the `post-script-complete` event
   - Log: "✓ Read debrief-and-document.md"

**After reading all nine files, log: "✓ Completed mandatory reading chain for create-stories-for-epic workflow"**

**Do not proceed with workflow execution until the entire reading chain is logged.**

**Before continuing, read the ## Events section in this file carefully—event handlers are mandatory for correct execution.**

## Script

### Inputs
- `$epic_issue_number` (required)
 - issue number of the epic to analyze
  - if not provided, have agent find it
- `$repository` (optional)
  - git repo with epic issue to analyze
  - if not provided, use current workspace
- `$parallel_execution` (optional, default: `false`)
   - Set to `true` to allow parallel story creation when stories are independent

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
`$full_epic_json` = JSON.stringify($epic_issue)
log: "Interpolated epic JSON length: {length($full_epic_json)} characters"

if `$parallel_execution` is `true`:
   # PARALLEL MODE: Create stories concurrently when safe
   For each `$story` in `$stories`, in parallel:
      `$story_prompt` = "Execute create-story-v2 with full epic JSON: {$full_epic_json} and story: {$story}"
      if ! (`$story` has already been created as a story issue linked to `$epic_issue`):
         - assign an available agent the `create-story-v2` assignment with input `$story_prompt`
         - wait until the agent finishes the task
         - review the work and approve it
         - record output as `#create-stories-for-epic.create-story-v2`
      else:
         - log: "Skipping story creation because {$story->title} is already linked"

   - wait until all parallel story-creation assignments complete
   - assign an available agent the `perform-task` assignment with input "github-expert: Query GitHub for linked stories to #{$epic_issue_number}. Return total count and list of missing stories."
   - wait until the agent finishes the task
   - record output as `#create-stories-for-epic.github-verification`
   - if `#create-stories-for-epic.github-verification.result` does not equal length($stories):
      - log: "Linked story count mismatch detected; initiating recovery workflow"
      `$epic_issue` = getepic($epic_issue_number, $repository)
      - assign the agent the `recover-from-error` assignment with input "Story creation mismatch detected for epic #{$epic_issue_number}. Expected {length($stories)} stories; review verification output {#create-stories-for-epic.github-verification}. Re-fetch epic JSON and apply tiered retry protocol."
      - stop workflow and request manual intervention
   - record aggregated outputs as `#create-stories-for-epic.parallel-complete`

else:
   # SERIAL MODE: Create stories one at a time
   For each `$story` in `$stories`, you will:
      `$story_prompt` = "Execute create-story-v2 with full epic JSON: {$full_epic_json} and story: {$story}"
      if ! (`$story` has already been created as a story issue linked to `$epic_issue`):
         - assign the agent the `create-story-v2` assignment with input `$story_prompt`
         - wait until the agent finishes the task
      else:
         - log: "Skipping story creation because {$story->title} is already linked"

      - review the work and approve it
      - record output as `#create-stories-for-epic.create-story-v2`

   - assign the agent the `perform-task` assignment with input "github-expert: Query GitHub for linked stories to #{$epic_issue_number}. Return total count and list of missing stories."
   - wait until the agent finishes the task
   - record output as `#create-stories-for-epic.github-verification`
   - if `#create-stories-for-epic.github-verification.result` does not equal length($stories):
      - log: "Linked story count mismatch detected in serial mode; initiating recovery workflow"
      `$epic_issue` = getepic($epic_issue_number, $repository)
      - assign the agent the `recover-from-error` assignment with input "Story creation mismatch detected for epic #{$epic_issue_number}. Expected {length($stories)} stories; review verification output {#create-stories-for-epic.github-verification}. Re-fetch epic JSON and apply tiered retry protocol."
      - stop workflow and request manual intervention

### Events

#### `pre-assignment-begin`

This event runs before EACH assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begin.gather-context`

#### `on-assignment-failure`

This event runs when ANY assignment fails to recover from errors systematically.

- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-complete`

This event runs after EACH assignment completes to report progress and validate the work.

- assign the agent the `validate-assignment-completion` assignment
- wait until the agent finishes the task
- review the work and approve it
   - if `$pv_assignment_name` is `validate-assignment-completion`:
   - if validation failed, halt workflow and request manual intervention # Halt workflow to prevent further execution with invalid state
   - if validation passed, proceed to next assignment in `$progress_and_validation_assignments`
- record output as `#events.post-assignment-complete.$pv_assignment_name`

#### `post-step-completion`

This event runs after EACH step completes to report progress and validate the work.

- assign the agent the `report-progress` assignment
- record output as `#events.post-step-completion.report-progress`

#### `post-script-complete`

- assign an agent the `debrief-and-document.md` workflow assignment with input:
  - project_context: current workflow state and outputs
- wait until the debriefing workflow completes