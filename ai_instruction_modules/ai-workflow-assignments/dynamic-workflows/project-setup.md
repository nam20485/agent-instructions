# Dynamic Workflow: Project Setup

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs

### initiate-new-repository

`$assignments` = [
                    `init-existing-repository`,
                    `create-app-plan`,
                    `create-project-structure`,
                    `create-repository-summary`,
                    `debrief-and-document`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`

### Events

#### pre-script-begin

- assign the agent the `create-workflow-plan` assignment
- wait until the agent finishes the task
- record output as `#events.pre-script-begin.create-workflow-plan`

#### `post-assignment-complete`

`$poc_assignments` = [
                     `validate-assignment-completion`,
                     `report-progress`
                 ]

For each `$poc_assignment_name` in `$poc_assignments`, you will:
   - assign the agent the `$poc_assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-complete.$poc_assignment_name`
