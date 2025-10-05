# Dynamic Workflow: Dynamic Workflow Template

## Overview

A minimal example dynamic workflow for exercising the DSL and orchestration end-to-end.

## Script

### Inputs

- $workflow_name
    - short id of the dynamic workflow assignment to validate
    - string
    - optional (iff $workflow_file is provided)
    - e.g., `breakdown-plan`
  
 - $workflow_file
    - path to the dynamic workflow file to validate
    - string
    - optional (iff $workflow_name is provided)    
    - e.g., `dynamic-workflows/breakdown-plan.md`

### plan-and-setup

`$assignments` = [`create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$assignments`, you will:
- assign the agent the `$assignment_name` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#plan-and-setup.$assignment_name`

### implement

- assign the agent the `perform-task` assignment
- wait until the agent finishes the task
- review the work and approve it

### quality-and-merge

- assign the agent the `create-test-cases` assignment
- wait until the agent finishes the task
- review the work and approve it
- assign the agent the `pr-approval-and-merge` assignment
- wait until the agent finishes the task
- review the work and approve it
