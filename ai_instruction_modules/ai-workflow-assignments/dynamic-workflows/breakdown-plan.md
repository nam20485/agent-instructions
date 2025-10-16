# Dynamic Workflow: Breakdown Plan

## Overview

This dynamic workflow breaks down an application development plan into epics and stories. It extracts phases from a plan issue, creates epic issues for each phase, then creates story issues for each epic. The workflow supports parallel execution where multiple epics can be created simultaneously by different agents, and also supports parallel story creation after each epic is complete.

## Script

### Inputs
- `$issue_number` (optional)
  - issue number to analyze
- `$repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace
- `$parallel_execution` (optional, default: `false`)
  - Whether to create epics in parallel when possible
  - Set to `true` to assign multiple `create-epic` assignments to different agents simultaneously

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

#### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]`

 ### breakdown-plan

`$plan_issue` = getplanissue($issue_number, $repository)
`$phases` = getphases($plan_issue)

const `$PARALLEL_EPIC_BREAKDOWN`: `true`

# Decision: Parallel or Serial epic creation
if `$parallel_execution` is `true`:
   # PARALLEL MODE: Assign all epic creation to agents simultaneously
   For each `$phase` in `$phases`, in parallel:
      - assign an available agent the `create-epic` assignment with input `$phase`
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#breakdown-plan.create-epic`

   # Wait for all parallel epic creations to complete
   - wait until all agents finish their assigned epic creations
   - collect all outputs as `#breakdown-plan.all-epics-complete`

else:
   # SERIAL MODE: Create epics one at a time
   For each `$phase` in `$phases`, you will:
      - assign the agent the `create-epic` assignment with input `$phase`
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#breakdown-plan.create-epic`

# Story creation (can happen in parallel with epic completion)
if `$PARALLEL_EPIC_BREAKDOWN` is `true`:
   # Create stories immediately after each epic is complete
   For each `$epic` in `#breakdown-plan.create-epic`:
      $stories = getstories($epic)

      For each `$story` in `$stories`, you will:
       - assign the agent the `create-story` assignment with input `$story`
       - wait until the agent finishes the task
       - review the work and approve it
       - record output as `#breakdown-plan.create-story`

else:
   # Wait for all epics to be created before creating any stories
   For each `$epic` in `#breakdown-plan.create-epic`, you will:
      $stories = getstories($epic)

      For each `$story` in `$stories`, you will:
         - assign the agent the `create-story` assignment with input `$story`
         - wait until the agent finishes the task
         - review the work and approve it
         - record output as `#breakdown-plan.create-story`