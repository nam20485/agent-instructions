# Dynamic Workflow: Analyze Plan

## Overview

This dynamic workflow file specifies the workflow for analyzing the app creation plan issue. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs
- `issue_number` (optional)
  - issue number to analyze
- `repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace

 ### analyze-plan (required)

`$assignments` = [  
                   `analyze-plan-issue`,
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#init-existing-repository.$assignment_name`