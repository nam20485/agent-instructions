---
description: Execute a specific task using the task-based workflow process
role: assistant
scope: workflow-assignment
---

# Perform Task

Execute a task given by orchestrator/stakeholder.

## Input
- `task`: Task object with requirements, objectives, deliverables, context

## Output
- `completion_status`: Task completed per acceptance criteria
- `deliverables`: Validated and approved
- `documentation`: Work documented and integrated

## Acceptance Criteria
- Task requirements understood and clarified
- Implementation plan created and approved
- Resources and dependencies secured
- Task executed per approved plan
- Outcomes delivered and validated
- Work documented and committed
- Stakeholder confirmed completion

## Workflow

### 1. Task Understanding
- Review task description and requirements
- Identify deliverables, acceptance criteria, success metrics
- Understand context and constraints
- Ask clarifying questions if ambiguous

### 2. Planning
- Break into manageable subtasks
- Estimate time/effort
- Identify resources, tools, dependencies
- Assess risks and mitigations
- Create timeline with milestones

### 3. Approval
- Create GitHub issue with plan
- Use task-based workflow format with checkboxes
- Present to stakeholders for approval
- Iterate based on feedback

### 4. Implementation
- Mark issue "state:in-progress"
- Create branch: `issues/<number>-<short-description>`
- Execute subtasks per plan
- Update checkboxes as steps complete
- Commit frequently, push regularly

### 5. Quality Assurance
- Test each component
- Perform integration testing
- Validate acceptance criteria
- Run automated tests

### 6. Delivery
- Push all changes
- Create PR with reviewers
- Provide demo/walkthrough
- Address feedback

### 7. Completion
- Final review against criteria
- Merge approved PRs
- Close issue with summary
- Gather lessons learned

## Parallel Execution
- Focus on your assigned scope only
- Use descriptive branch names
- Commit/push frequently to minimize conflicts
- Coordinate with orchestrator for dependencies
