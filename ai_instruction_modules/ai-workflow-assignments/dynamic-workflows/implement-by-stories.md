# Dynamic Workflow: Implement by Stories

## Overview

This dynamic workflow performs implementation of an application development plan by systematically completing story issues. It builds upon the breakdown of the plan into epics and stories, ensuring that each story is addressed in sequence. This workflow is designed to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs
- `$issue_number` (optional)
  - Issue number of the plan issue to implement
- `$repository` (optional)
  - git repo with plan issue to implement
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

#### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]`

 ### implement-by-stories

`$plan_issue` = getplanissue($issue_number, $repository)
`$epics` = getepics($plan_issue)

For each `$epic` in `$epics`, you will:   
   $stories = getstories($epic)

   For each `$story` in `$stories`, you will:
      - assign the agent the `perform-task` assignment with input `$story`
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#implement-by-stories.perform-task`
