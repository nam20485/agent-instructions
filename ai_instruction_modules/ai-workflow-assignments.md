---
description: Index and guide for assignment-based workflows.
scope: workflow-assignments
prerequisites: none
---
# Assignment-Based Workflow

<xml>
<instructions role="assistant" scope="workflow-assignments">

<overview>
## Workflow Assignments
- **Definition:** Specifically-defined sets of goals, acceptance criteria, and steps.
- **Purpose:** Describes how to accomplish a specific task, start a new project, or stage.
- **Execution:** Assigned by orchestrator/user; performed until finished.
- **Location:** `ai_instruction_modules/ai-workflow-assignments/<short-id>/`
</overview>

<definition_format>
## Workflow Assignment Definition Format
See **[ai-workflow-development-guide.md](../ai-workflow-development-guide.md)** for definition format and mandatory behaviors.
</definition_format>

<mandatory_behaviors>
## Non-Negotiable Behaviors
See **[ai-workflow-development-guide.md](../ai-workflow-development-guide.md)** for non-negotiable behaviors.
</mandatory_behaviors>

<references>
## References
- **Orchestrator:** [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
- **Dynamic Syntax:** [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
</references>

<available_assignments>
## Assignments by Category

**Orchestration:** `orchestrate-new-project`

**Planning:** `create-app-plan`, `create-feature-plan`, `create-epic`, `create-epic-v2`, `create-story`, `create-story-v2`, `outline-epic`

**Setup:** `create-application`, `create-application-foundation`, `create-application-structure`, `create-app-from-plan-issue`, `create-deployment-infrastructure`, `create-new-project`, `create-project-structure`, `create-testing-infrastructure`, `init-existing-repository`

**Execution:** `continue-task-work`, `gather-context`, `perform-task`, `recover-from-error`, `report-progress`

**Validation:** `validate-agent-instructions-expert-usage`

**Review:** `create-test-cases`, `pr-approval-and-merge`, `pr-review-comments`, `request-approval`, `validate-assignment-completion`

**Documentation:** `analyze-plan-issue`, `analyze-progress-doc`, `debrief-and-document`, `continuous-improvement`, `update-from-feedback`, `update-plan-issue`

*All files at:* `ai-workflow-assignments/<short-id>.md`
</available_assignments>

<dynamic_workflows>
## Dynamic Workflows

**Events:** `pre-script-begin`, `pre-assignment-begin`, `post-assignment-complete`, `post-script-complete`, `on-assignment-failure`, `on-script-failure`

**Scripts:** `analyze-plan`, `breakdown-epic`, `breakdown-plan`, `create-epics-for-phase`, `create-stories-for-epic`, `design-app-outline`, `implement-by-stories`, `implement-epic`, `implement-story`, `new-project`, `optimize-plan`, `project-setup`, `project-setup-upgraded`, `review-epic-prs`, `sample-minimal`, `setup-project-and-create-app`, `single-workflow`, `validate-branch-deferral-stdout`, `validate-expert-invocation`

*All at:* `ai-workflow-assignments/dynamic-workflows/<name>.md`

**WIP:** `breakdown-epic-and-plan`, `breakdown-stories-and-plan`, `create-app-plan-and-epics`, `plan-epic`, `plan-story` (in `.wip/`)
</dynamic_workflows>

</instructions>
</xml>
