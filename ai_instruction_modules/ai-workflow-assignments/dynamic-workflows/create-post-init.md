# Dynamic Workflow: Create Post Init

## Overview

This dynamic workflow file specifies the workflow for creating the project after the repository has been initiated. It creates the app plkan and project structure. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

 ### initiate-new-repository

`$assignments` = [                      
                    `create-app-plan`, 
                    `create-project-structure`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment with inputs { $context }
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`