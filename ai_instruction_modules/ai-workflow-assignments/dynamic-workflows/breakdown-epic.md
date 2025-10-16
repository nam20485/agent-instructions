# Dynamic Workflow: Breakdown Epic

## Overview

This dynamic workflow breaks down a single epic into story issues. It takes an epic issue as input, extracts the stories from that epic, and creates individual story issues for each. This workflow is designed to be used when you want to break down one epic at a time rather than processing all epics from a plan.

## Script

### Inputs
- `$epic` (optional)
  - Epic issue object or issue number to break down into stories
  - If not provided, the workflow will find the next epic that needs story breakdown
- `$repository` (optional)
  - git repo with the epic issue
  - if not provided, use current workspace

### Declarations

#### find_next_epic_needing_breakdown($repository)
Finds the next epic issue that needs to be broken down into stories.
- **Input:** Repository path
- **Returns:** Epic issue object for the next epic that needs story breakdown
- **Search criteria:**
  - Issues with label `type:epic`
  - Epic issues that are open
  - Epic issues that have no child story issues (or fewer stories than expected)
  - Ordered by milestone due date (earliest first), then by issue number
- **Example:** `find_next_epic_needing_breakdown("myorg/myrepo")` returns the next epic needing breakdown

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

 ### breakdown-epic

# Step 0: Determine which epic to break down
if `$epic` is not provided:
   `$epic_issue` = find_next_epic_needing_breakdown($repository)
   - log: "Auto-selected epic for breakdown: {epic_issue.number} - {epic_issue.title}"
else:
   `$epic_issue` = getepic($epic, $repository)

# Step 1: Extract stories from the epic
`$stories` = getstories($epic_issue)

# Step 2: Create story issues for each story in the epic
For each `$story` in `$stories`, you will:
   - assign the agent the `create-story` assignment with input `$story`
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#breakdown-epic.create-story`

# Step 3: Mark epic as ready for implementation
- add label `status:ready-for-implementation` to `$epic_issue`
- update epic issue with comment listing all created story issues
- record completion as `#breakdown-epic.complete`