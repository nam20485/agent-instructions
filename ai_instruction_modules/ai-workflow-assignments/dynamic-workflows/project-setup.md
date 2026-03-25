# Dynamic Workflow: Project Setup

## Overview

This dynamic workflow file specifies the workflow for initiating a new repo. It is intended to be used with the `orchestrate-dynamic-workflow` assignment.

## Directives

- **Action SHA Pinning**: Any GitHub Actions workflows created or modified during the course of this dynamic workflow's assignments MUST pin all actions to the specific commit SHA of their latest release (e.g., `uses: actions/checkout@<full-commit-sha>`). Do not use major/minor version tags (like `@v3` or `@main`).

## Script

### Inputs

### initiate-new-repository

`$assignments` = [
                    `init-existing-repository`,
                    `create-app-plan`,
                    `create-project-structure`,
                    `create-agents-md-file`,
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

#### `post-script-complete`

After all assignments and post-assignment events have completed successfully,
apply the `orchestration:plan-approved` label to the application plan issue
(created during the `create-app-plan` assignment) to signal that the plan is
ready for epic creation. This label triggers the next phase of the orchestration
pipeline (the `orchestration:plan-approved` clause in the orchestrator prompt).

- Locate the application plan issue created during `create-app-plan`
  (recorded as `#initiate-new-repository.create-app-plan`)
- Apply label `orchestration:plan-approved` to that plan issue
- record output as `#events.post-script-complete.plan-approved`

## Acceptance Criteria

- All assignments in the `$assignments` list are successfully completed.
- The `create-workflow-plan` pre-script event is executed and output recorded.
- The `$poc_assignments` are executed after each main assignment and outputs recorded.
- The `post-script-complete` event applies `orchestration:plan-approved` to the plan issue.
- **Any GitHub Actions workflows created or modified during the execution of this workflow must have all actions pinned to the specific commit SHA of their latest release.**
