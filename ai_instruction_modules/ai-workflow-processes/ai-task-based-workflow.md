---
description: Standard workflow for documenting and executing work via GitHub Issues.
scope: task-workflow
prerequisites: none
---
# Task-based Workflow

<xml>
<instructions role="assistant" scope="task-workflow">

<overview>
## Overview
The task-based workflow ensures all work is planned, documented, and tracked via GitHub Issues.
- **Core Principle:** Plan -> Issue -> Work -> Update -> PR.
- **Goal:** Transparency, context preservation, and systematic execution.
</overview>

<workflow_steps>
## Workflow Steps

### 1. Beginning
- **Review:** Check current status and "Current Task Reminder" in memory.
- **Context:** Understand previous work and context.

### 2. Review Current State
- **Inspect:** Codebase, existing branches, issues.
- **Check:** Previous progress, remote changes, upstream changes.
- **Identify:** Similar functionality to build on.

### 3. Plan
- **Create Issue:** Outline steps in a new GitHub Issue.
- **Structure:**
    - Description (Why/What/How/Risks/Mitigations).
    - Acceptance Criteria.
    - Checklist of small, detailed steps.

### 4. Approval
- **Review:** Ask user to review the issue plan.
- **Iterate:** Refine based on feedback.
- **Start:** Mark as `state:in-progress` upon approval.

### 5. Initial Implementation
- **Execute:** Work through checklist items.
- **Update:** Mark checkboxes as you complete them (Critical for context).
- **Commit:** Frequent small commits.

### 6. Completion
- **Verify:** Ensure all acceptance criteria are met.
- **PR:** Create Pull Request.
    - Link issue (`Closes #<id>`).
    - Assign reviewers (`nam20485`, `/gemini review`).
</workflow_steps>

<assignments>
## Assignments
- **Relation:** Task-based workflow is the foundation for completing Assignments.
- **Breakdown:** Use this workflow to break down large Assignments into manageable Task Issues.
</assignments>

<details>
## Details
- **Template:** `.github/ISSUE_TEMPLATE/copilot-task.md`
- **Tools:** Use `gh cli` for issue management.
- **Labels:**
    - `assigned:copilot`: For tasks assigned to you.
    - `state:in-progress`: For active tasks.
    - `key:value`: e.g., `type:bug`, `priority:high`.
</details>

<branch_management>
## Branch Management
- **Naming:** `issues/<number>-<short-description>` (e.g., `issues/42-fix-auth`).
- **Base:** Create from `copilot` branch (or `main`/`develop` if specified).
- **Link:** Link issue to branch immediately.
- **Cleanup:** Delete branch after merge.
- **Safety:** Commit frequently. Never leave dangling changes.
</branch_management>

<examples>
## Examples
<see example="../examples/task-workflow-examples.md" />
</examples>

</instructions>
</xml>
