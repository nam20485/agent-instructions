#### Memory Tool "Current Task Reminder"

Using your memory tool, you can set (and get) a "current task reminder" to help you remember what task you were working on last. This is useful if you have to stop working before completing your planned tasks, or if you switch contexts frequently.

**NOTE:** The "current task reminder" is not intended to replace normal memory recall. It is only intended to help you remember what task you were working on last if you have to stop working before completing your planned tasks, or if you switch contexts frequently.

>- It is important to remember to frequently create/set the "current task reminder" as you work through your tasks.
>- After you complete a task, always clear the "current task reminder" by setting it to null.
>- When starting work on a new task, always set a "current task reminder" to help you remember what task you are working on.

##### Setting the "current task reminder" (writing)

As you complete an item and then begin a new task, you can set a "current task reminder" to help you remember what task you were working on last. This will help you remember where to start when you come back to the task later.

##### Structure of the "current task reminder"

You can use the following structure to create a "current task reminder" in your memory tool:

```json
{
  "repo": "<repository_name>",
  "branch": "<branch_name>",
  "task": "<task_name>",
  "issue": <issue_number>,
  "state": "<task_state>",
  "description": "<brief_description_of_task>",
  "context": "<relevant_context_or_notes>",
  "nextSteps": ["<next_step_1>", "<next_step_2>"],
  "blockers": ["<blocker_1>", "<blocker_2>"],
  "lastUpdated": "<timestamp>"
}
```

Where:

1. The name of the git repository you were working on
1. The name of the branch you were working on
1. The name of the task you were working on
1. The issue number of the task you were working on
1. The current state of the task (e.g., "in progress", "completed", "blocked", etc.)
1. A brief description of the task
1. Any relevant context or notes that will help you remember what you were doing
1. Next steps you were planning to take
1. Any blockers or issues you encountered
1. The last updated timestamp

###### Example of a "Current task reminder"

```json
{
  "repo": "advanced-memory2",        
  "branch": "issues/1-implement-advanced-memory2-app",
  "task": "Complete Phase 1: Project Setup and Infrastructure",
  "issue": 1,
  "state": "in progress",
  "description": "Missing Docker/Docker Compose configuration and cross-service project references in ASP.NET Core Aspire application",
  "context": "Phase 1 appeared complete but analysis revealed missing containerization infrastructure. Need to add Dockerfile for each service, docker-compose.yml for local dev, and configure proper project references between ApiService and backend services. Current build succeeds but service integration incomplete.",
  "nextSteps": ["Add Dockerfile to each service project", "Create docker-compose.yml for local development", "Configure project references between services", "Test containerized deployment"],
  "blockers": [],
  "lastUpdated": "2025-07-10T15:30:00Z"
}
```

1. If you have a "current task reminder" in your memory, then read it.
1. This will help you remember what task you were working on last.
1. If it exists, then you can use it to help you determine where to start.
1. If it does not exist, then you possibly have not started a task yet, or you have not set a reminder for the current task.
1. If you are unsure, take a moment to reflect on your recent work and try to recall the task you were focused on.
1. Continue the Review Current State section to gather more context.
1. Based on information from the "current task reminder" and the Review Current State section, you can then proceed to plan your next steps.