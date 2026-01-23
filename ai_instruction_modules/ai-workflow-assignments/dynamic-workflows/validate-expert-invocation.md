# Dynamic Workflow: Validate Expert Invocation

## Overview

Run a purpose-built validation assignment that emits **verifiable evidence** showing:
1) `agent-instructions-expert` was consulted for instruction/workflow lookups, and
2) branch selection is sourced from `.github/copilot-instructions.md`.

This workflow is intended to be orchestrated using the `orchestrate-dynamic-workflow` assignment.

## Script

### Inputs

- `$note` (optional)
  - Free-form note to include in logs (e.g., PR number)

### validate-expert-invocation

- log: "[validate-expert-invocation] Starting validation run"

if `$note` is provided:
  - log: "[validate-expert-invocation] Note: {note}"

- log: "[validate-expert-invocation] Assigning validation assignment: validate-agent-instructions-expert-usage"
- assign the agent the `validate-agent-instructions-expert-usage` assignment
- wait until the agent finishes the task
- record output as `#validate-expert-invocation.validate-agent-instructions-expert-usage`

- log: "[validate-expert-invocation] Validation assignment complete; inspect run report for PASS/FAIL against evidence criteria"

### Events

#### `pre-script-begin`
- log: "[validate-expert-invocation] Event: pre-script-begin"

#### `post-script-complete`
- log: "[validate-expert-invocation] Event: post-script-complete"

#### `on-script-failure`
- log: "[validate-expert-invocation] Event: on-script-failure"