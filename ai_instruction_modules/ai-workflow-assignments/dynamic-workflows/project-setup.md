# Dynamic Workflow: Project Setup

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs

- $context.repo_name: New repository name (string)
- $context.app_plan_docs: App creation plan documents (list of file paths)

 ### initiate-new-repository

`$assignments` = [  
                    `initiate-new-repository`,
                    `create-app-plan`, 
                    `create-project-structure`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment with inputs { $context }
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`