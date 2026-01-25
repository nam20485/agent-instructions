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
                    `debrief-and-document`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#init-existing-repository.$assignment_name`
  

### Events

#### `post-assignment-complete`

`$poc_assignments` = [  
                    `create-repository-summary`
                 ]

For each `$poc_assignment_name` in `$poc_assignments`, you will:
   - assign the agent the `$poc_assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-complete.$poc_assignment_name`


