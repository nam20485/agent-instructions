# Dynamic Workflow: Design Application Outline

## Overview

This dynamic workflow designs the basic outline for an application based on a provided plan issue by implementing classes, documentation, interfaces, APIs, and tests. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs
- `$issue_number` (optional)
  - Issue number to design
- `$repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace

### Declarations

#### getplanissue($issue_number, $repository)
Retrieves the plan issue from the specified repository.
- **Input:** Issue number and repository path
- **Returns:** Issue object containing the application development plan
- **Example:** `getplanissue(42, "myorg/myrepo")` returns issue #42 from myorg/myrepo

#### getepics($plan_issue)
Extracts development epics from the plan issue.
- **Input:** Plan issue object
- **Returns:** Array of epic objects, each containing epic description and requirements and entire content of epic
- **Example:** `getepics($plan_issue)` returns `["Epic 1: User Management", "Epic 2: Product Catalog", ...]`

<!-- #### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]` -->

 ### design-app-outline

`$plan_issue` = getplanissue($issue_number, $repository)
`$epics` = getepics($plan_issue)

const `$PARALLEL_EPIC_BREAKDOWN`: `true`

For each `$epic` in `$epics`, you will:
   - assign the agent the `outline-epic` assignment with input `$epic`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#design-app-outline.outline-epic`

   <!-- 
   if `$PARALLEL_EPIC_BREAKDOWN` is `true`:
      $stories = getstories(#breakdown-plan.outline-epic)

      For each `$story` in `$stories`, you will:
       - assign the agent the `-story` assignment with input `$story`
       - wait until the agent finishes the task
       - review the work and approve it
       - record output as `#breakdown-plan.create-story`
   -->

<!--
if `$PARALLEL_EPIC_BREAKDOWN` is `false`:
   For each `$epic` in `#breakdown-plan.create-epic`, you will:
      $stories = getstories($epic)

      For each `$story` in `$stories`, you will:
         - assign the agent the `create-story` assignment with input `$story`
         - wait until the agent finishes the task
         - review the work and approve it
         - record output as `#breakdown-plan.create-story`
 -->