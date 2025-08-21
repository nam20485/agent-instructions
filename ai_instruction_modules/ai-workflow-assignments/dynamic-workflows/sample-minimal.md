# Dynamic Workflow: Sample Minimal

## Overview

A minimal example dynamic workflow for exercising the DSL and orchestration end-to-end.

## Script

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
