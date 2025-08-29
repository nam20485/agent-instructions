# Dynamic Workflow: New Project

## Overview

This dynamic workflow file specifies the workflow for creating a new project. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### create-project-and-plan

`$assignments` = [  
                    `initiate-new-repository`,
                    `create-app-plan`, 
                    `create-project-structure`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#create-project-and-plan.$assignment_name`
  
### iteratively-breakdown-epics-and-plan

`$sub_issues` = get-sub-issues-from-previous-step(`#create-project-and-plan.create-app-plan`)

For each `$sub_issue_name` in `$sub_issues`, you will:
   - assign the agent the `breakdown-epic-and-plan` assignment
   - wait until the agent finishes the task
   - review the work and approve it

### iteratively-implement-and-validate

- For each sub-issue created in the previous `breakdown-epic-and-plan` step:
  - assign the agent the `perform-task` assignment
  - wait until the agent finishes the task
  - review the work and approve it
  - upon approval, move on to the next sub-issue
- upon approval, move on to the next stage

### final-validation-and-delivery

   - assign the agent the `validate-and-deliver` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - upon approval, move on to the next stage