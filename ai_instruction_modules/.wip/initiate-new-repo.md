---\ncontext: opt-in\n---\n---\ncontext: opt-in\n---\n# Dynamic Workflow: Initiate New Repo

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Script

### initiate-new-repository

`$assignments` = [  
                    `initiate-new-repository`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`

