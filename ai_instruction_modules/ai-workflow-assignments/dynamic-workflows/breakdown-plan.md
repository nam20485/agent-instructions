# Dynamic Workflow: Breakdown Plan

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs
- `issue_number` (optional)
  - issue number to analyze
- `repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace

 ### breakdown-plan

`$plan_issue` = getplanissue($issue_number, $repository)
`$phases` = getphases($plan_issue)

`$epics` = []

const `$PARALLEL_EPIC_BREAKDOWN`: `true`

For each `$phase` in `phases`, you will:
   - assign the agent the `create-epic` assignment with input `$phase`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `$breakdown-plan.create-epic`

   if `$PARALLEL_EPIC_BREAKDOWN` is `true`:
      $stories = getstories($breakdown-plan.create-epic)

      For each `$story` in `$stories`, you will:
       - assign the agent the `create-story` assignment with input `$story
       - wait until the agent finishes the task
       - review the work and approve it
       - record output as `$breakdown-plan.breakdown-epic-and-plan.create-story`
   else:
      - add `$breakdown-plan.create-epic` to `$epics` array

if `$PARALLEL_EPIC_BREAKDOWN` is not `true`:
   $stories = getstories($breakdown-plan.create-epic)

   For each `$story` in `$stories`, you will:
      - assign the agent the `create-story` assignment with input `$story
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `$breakdown-plan.breakdown-epic-and-plan.create-story`