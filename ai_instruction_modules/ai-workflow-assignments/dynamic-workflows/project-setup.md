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

#### `post-assignment-completion`

`$assignments` = [  
                    `create-repository-summary`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`

### Meta

