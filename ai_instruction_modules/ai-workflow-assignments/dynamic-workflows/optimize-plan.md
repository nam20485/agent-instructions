# Dynamic Workflow: Optimize Plan

## Overview

This dynamic workflow file specifies the workflow for analyzing and then optimizing the app creation plan issue. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs
- `issue_number` (optional)
  - issue number to analyze
- `repository` (optional)
  - git repo with plan issue to analyze
  - if not provided, use current workspace

 ### optimize-plan (required)

`$assignments` = [  
                   `analyze-plan-issue`,
                   `request-approval`,
                   `update-plan-issue`,                   
                   `debrief-and-document`,
                   `create-repository-summary`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#optimize-plan.$assignment_name`