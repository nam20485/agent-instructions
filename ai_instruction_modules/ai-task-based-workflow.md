# Task-Based Workflow

## Process Overview
1. **Review**: Check current state, existing issues, memory tool "current task reminder"
2. **Plan**: Create detailed implementation plan → new GH issue with steps/checkboxes
3. **Approval**: Present issue to stakeholder → iterate until approved
4. **Implement**: Mark progress with checkboxes, commit with issue reference, create PR
5. **Update**: Always update progress after completing checklist items

## Memory Tool - Current Task Reminder
```json
{
  "repo": "<repository_name>", "branch": "<branch_name>", 
  "task": "<task_name>", "issue": <issue_number>,
  "state": "<task_state>", "description": "<brief_description>",
  "context": "<relevant_context>", "nextSteps": ["<step_1>"],
  "blockers": ["<blocker_1>"], "lastUpdated": "<timestamp>"
}
```
## Issue Creation Format
**Description**: What you intend to change, how, outcome, and why
**Risks & Mitigations**: Potential issues and how to address them  
**Acceptance Criteria**: Clear completion conditions
**Steps**: Detailed checklist (many small steps > few large ones)

## Task Sizing & Multiple Tasks
- Document entire plan before starting
- Break large work into multiple issues  
- Complete one task issue before starting next
- Always check assigned GH issues when beginning session

## Approval & Implementation  
1. Present issue to user → iterate until approved → mark "state:in-progress"
2. **Mark progress with checkboxes as you complete items**
3. Commit with issue reference, create PR with reviewer assignments
4. Always keep current progress updated

## GitHub Integration
- **Labels**: `assigned:copilot`, `state:in-progress` 
- **Branches**: `issues/<number>-<description>` from `copilot` branch
- **PR Requirements**: Assign nam20485 as reviewer, add `/Closes #<issue_number>` and `/gemini review`
- **Commits**: Include issue reference, use format: `type: description \n\n- changes\n\n/Closes #<number>`
