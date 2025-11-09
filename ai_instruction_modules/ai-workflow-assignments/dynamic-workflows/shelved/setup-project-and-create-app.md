# Dynamic Workflow: Setup Project and Create Application

## Overview

This dynamic workflow file specifies the workflow for creating a new application from an existing setup project. It is intended to be used with the `orchestrate-dynamic-workflow` assignment. You will use the main plan issue that was created in the `create-app-plan` assignment as the parent issue for this workflow.

## Script

### Inputs

 ### setup-project-and-create-app

`$assignments` = [  
                    `init-existing-repository`,
                    `create-app-plan`, 
                    `create-project-structure`,
                    `create-app-from-plan-issue`, 
                    `debrief-and-document`,
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#init-existing-repository.$assignment_name`