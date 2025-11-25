---
description: Instructions for using the "Current Task Reminder" memory tool to maintain context.
scope: task-management
prerequisites: none
context: opt-in
---
# Current Task Reminder

<xml>
<instructions role="task-manager" scope="task-management">

<overview>
## Overview
Use the "Current Task Reminder" in memory to persist context across sessions or interruptions. This ensures continuity when stopping work or switching contexts.
</overview>

<rules>
## Rules
-   **Frequency:** Update frequently as you progress.
-   **Completion:** Set to `null` when a task is fully complete.
-   **Start:** Always check for an existing reminder when starting a session.
-   **New Task:** Create a new reminder when starting a new task.
</rules>

<schema>
## Data Structure
Store the reminder as a JSON object with the following fields:
-   `repo`: Repository name.
-   `branch`: Current branch.
-   `task`: Task name.
-   `issue`: Issue number.
-   `state`: `in progress`, `completed`, `blocked`.
-   `description`: Brief description.
-   `context`: Relevant notes/findings.
-   `nextSteps`: Array of immediate next actions.
-   `blockers`: Array of blocking issues.
-   `lastUpdated`: ISO timestamp.
</schema>

<process>
## Workflow
1.  **Read:** Check memory for "current task reminder".
2.  **Analyze:**
    -   If exists: Use it to resume context.
    -   If null: Check recent work/logs to determine state.
3.  **Plan:** Use the reminder + current state to determine next steps.
4.  **Update:** Write new state to memory before ending turn or switching tasks.
</process>

<examples>
## Examples
<see example="examples/task-reminder-examples.md" />
</examples>

</instructions>
</xml>
