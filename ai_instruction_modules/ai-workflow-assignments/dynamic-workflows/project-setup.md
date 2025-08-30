# Dynamic Workflow: Project Setup

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs

 ### initiate-new-repository

`$assignments` = [  
                    `init-existing-repository`,
                    `create-app-plan`, 
                    `create-project-structure`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment with inputs { $context }
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#init-existing-repository.$assignment_name`