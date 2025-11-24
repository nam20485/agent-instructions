---
description: Workflow for Test-Driven Development (TDD) and CI-based validation.
scope: iterative-guardrails
prerequisites: ai-task-based-workflow.md
---
# Iterative Guardrails Workflow

<xml>
<instructions role="assistant" scope="iterative-guardrails">

<overview>
## Overview
The iterative guardrails workflow is essentially Test-Driven Development (TDD) extended to include CI pipelines and other validation tools.
- **Core Principle:** Write Guards -> Fail -> Write Code -> Pass -> Refactor.
- **Goal:** 100% validation coverage and automated confidence.
</overview>

<guardrails>
## Defining Guardrails
Guardrails are any mechanism that validates code correctness.

### Types
- **Automated Tests:** Unit, Integration, E2E, Performance.
- **Linters/Scanners:** Static Analysis, Syntax, Security, Compliance, Secrets.
- **Build:** Compilation, Linking.
- **CI Pipelines:** Automated execution of all above.
</guardrails>

<ci_strategy>
## CI Strategy
- **Fast & Focused:** Pipelines must be fast (minutes) to serve as effective guardrails.
- **Split:** Separate CI (Guardrails) from CD (Delivery).
- **Frequency:** Commit and push frequently to trigger CI.
- **Expectation:** CI *will* fail initially (Red phase). This is normal.
</ci_strategy>

<workflow_steps>
## Workflow Steps

### 1. Beginning
- **Review:** Current status, "Current Task Reminder", existing coverage.
- **Setup:** Ensure CI pipelines exist (Build, Test, Lint, Scan).

### 2. Create Guards (Red)
- **Write:** Create automated tests for the new functionality.
- **Verify:** Run tests/CI. Confirm they run correctly but FAIL (Red).

### 3. Iterate (Green)
- **Implement:** Write code in small increments.
- **Validate:**
    - Build.
    - Run tests locally.
    - Push to run CI.
- **Repeat:** Until all guards pass.

### 4. Refactor & Cover
- **Refactor:** Improve code quality while keeping guards passing.
- **Coverage:** If coverage < 100%, add more guards.

### 5. Completion
- **Criteria:** Functionality complete, Build passes, All tests pass, CI passes, 100% coverage.
- **Report:** Document work, ask for approval.
</workflow_steps>

</instructions>
</xml>
