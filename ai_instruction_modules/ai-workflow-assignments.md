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
- **Sections:** Title, Short ID, Goal, Acceptance Criteria, Assignment, Detailed Steps, Completion.
- **Authority:** Single source of truth for steps and Acceptance Criteria.
- **Mandatory:**
    - Resolution trace before execution.
    - Assignment-first execution (no synthesis).
    - Acceptance-criteria gating.
    - Preflight enforcement.
    - Branch-protection awareness.
    - Run Report mapped to Acceptance Criteria.
</definition_format>

<mandatory_behaviors>
## Non-Negotiable Behaviors
1.  **Resolution Trace:** Print dereference chain (files + URLs/SHAs).
2.  **Assignment-First:** Execute steps ONLY from resolved assignment file(s).
3.  **Acceptance Gate:** Mark complete ONLY when all criteria pass.
4.  **Preflight:** Enforce template/source-of-truth & environment prerequisites.
5.  **Protection-Aware:** Respect branch protection (Feature Branch + PR).
6.  **Report:** Produce Run Report mapped to Acceptance Criteria.
</mandatory_behaviors>

<references>
## References
- **Orchestrator:** [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
- **Dynamic Syntax:** [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
</references>

<available_assignments>
## Available Assignments

### Orchestration & Program Management
- [orchestrate-new-project.md](ai-workflow-assignments/orchestrate-new-project.md): End-to-end project orchestration.

### Planning
- [create-app-plan.md](ai-workflow-assignments/create-app-plan.md): Create application plan from template.
- [create-feature-plan.md](ai-workflow-assignments/create-feature-plan.md): Plan major feature.
- [create-epic.md](ai-workflow-assignments/create-epic.md): Create epic sub-issue.
- [create-epic-v2.md](ai-workflow-assignments/create-epic-v2.md): Enhanced epic creation.
- [create-story.md](ai-workflow-assignments/create-story.md): Create story sub-issue.
- [create-story-v2.md](ai-workflow-assignments/create-story-v2.md): Enhanced story creation.
- [outline-epic.md](ai-workflow-assignments/outline-epic.md): Structural outline for epic (TDD prep).

### Initialization & Setup
- [create-application.md](ai-workflow-assignments/create-application.md): Create new app from template.
- [create-application-foundation.md](ai-workflow-assignments/create-application-foundation.md): Setup foundational infrastructure.
- [create-application-structure.md](ai-workflow-assignments/create-application-structure.md): Create structural components.
- [create-app-from-plan-issue.md](ai-workflow-assignments/create-app-from-plan-issue.md): Create app from plan issue.
- [create-deployment-infrastructure.md](ai-workflow-assignments/create-deployment-infrastructure.md): Setup deployment/CI/CD.
- [create-new-project.md](ai-workflow-assignments/create-new-project.md): Create new project from scratch.
- [create-project-structure.md](ai-workflow-assignments/create-project-structure.md): Create project structure from plan.
- [create-testing-infrastructure.md](ai-workflow-assignments/create-testing-infrastructure.md): Setup testing infrastructure.
- [init-existing-repository.md](ai-workflow-assignments/init-existing-repository.md): Initialize existing repo.

### Implementation & Execution
- [continue-task-work.md](ai-workflow-assignments/continue-task-work.md): Resume in-progress tasks.
- [gather-context.md](ai-workflow-assignments/gather-context.md): Collect and analyze context.
- [perform-task.md](ai-workflow-assignments/perform-task.md): Execute specific task.
- [recover-from-error.md](ai-workflow-assignments/recover-from-error.md): Diagnose and recover from errors.
- [report-progress.md](ai-workflow-assignments/report-progress.md): Create progress reports.

### Review & QA
- [create-test-cases.md](ai-workflow-assignments/create-test-cases.md): Create test cases.
- [pr-approval-and-merge.md](ai-workflow-assignments/pr-approval-and-merge.md): Resolve comments, approve, merge PR.
- [pr-review-comments.md](ai-workflow-assignments/pr-review-comments.md): Review and address PR comments.
- [request-approval.md](ai-workflow-assignments/request-approval.md): Request stakeholder approval.
- [validate-assignment-completion.md](ai-workflow-assignments/validate-assignment-completion.md): Verify assignment completion.

### Documentation & Analysis
- [analyze-plan-issue.md](ai-workflow-assignments/analyze-plan-issue.md): Analyze plan issue.
- [analyze-progress-doc.md](ai-workflow-assignments/analyze-progress-doc.md): Analyze progress from repo.
- [debrief-and-document.md](ai-workflow-assignments/debrief-and-document.md): Run formal debrief.
- [continuous-improvement.md](ai-workflow-assignments/continuous-improvement.md): Execute improvement plan.
- [update-from-feedback.md](ai-workflow-assignments/update-from-feedback.md): Incorporate feedback.
- [update-plan-issue.md](ai-workflow-assignments/update-plan-issue.md): Update plan issue.
</available_assignments>

<dynamic_workflows>
## Dynamic Workflows

### Event System
- **Pre-Execution:** `pre-script-begin`, `pre-assignment-begin`
- **Post-Execution:** `post-assignment-complete`, `post-script-complete`
- **Failure-Handling:** `on-assignment-failure`, `on-script-failure`

### Available Scripts
- [analyze-plan.md](ai-workflow-assignments/dynamic-workflows/analyze-plan.md): Analyze plans.
- [breakdown-epic.md](ai-workflow-assignments/dynamic-workflows/breakdown-epic.md): Breakdown epic to stories.
- [breakdown-plan.md](ai-workflow-assignments/dynamic-workflows/breakdown-plan.md): Breakdown plan to components.
- [create-epics-for-phase.md](ai-workflow-assignments/dynamic-workflows/create-epics-for-phase.md): Create epics for phase.
- [create-stories-for-epic.md](ai-workflow-assignments/dynamic-workflows/create-stories-for-epic.md): Create stories for epic.
- [design-app-outline.md](ai-workflow-assignments/dynamic-workflows/design-app-outline.md): Create app outline.
- [implement-by-stories.md](ai-workflow-assignments/dynamic-workflows/implement-by-stories.md): Implement plan by stories.
- [implement-epic.md](ai-workflow-assignments/dynamic-workflows/implement-epic.md): Implement single epic.
- [implement-story.md](ai-workflow-assignments/dynamic-workflows/implement-story.md): Implement single story.
- [new-project.md](ai-workflow-assignments/dynamic-workflows/new-project.md): End-to-end new project.
- [optimize-plan.md](ai-workflow-assignments/dynamic-workflows/optimize-plan.md): Optimize plan.
- [project-setup.md](ai-workflow-assignments/dynamic-workflows/project-setup.md): Setup new project.
- [project-setup-upgraded.md](ai-workflow-assignments/dynamic-workflows/project-setup-upgraded.md): Enhanced project setup.
- [review-epic-prs.md](ai-workflow-assignments/dynamic-workflows/review-epic-prs.md): Review epic PRs.
- [sample-minimal.md](ai-workflow-assignments/dynamic-workflows/sample-minimal.md): Minimal sample.
- [setup-project-and-create-app.md](ai-workflow-assignments/dynamic-workflows/setup-project-and-create-app.md): Setup project & create app.
- [single-workflow.md](ai-workflow-assignments/dynamic-workflows/single-workflow.md): Generic single assignment wrapper.
</dynamic_workflows>

<wip_assignments>
## Work-In-Progress Assignments
- [breakdown-epic-and-plan.md](ai-workflow-assignments/.wip/breakdown-epic-and-plan.md)
- [breakdown-stories-and-plan.md](ai-workflow-assignments/.wip/breakdown-stories-and-plan.md)
- [create-app-plan-and-epics.md](ai-workflow-assignments/.wip/create-app-plan-and-epics.md)
- [plan-epic.md](ai-workflow-assignments/.wip/plan-epic.md)
- [plan-story.md](ai-workflow-assignments/.wip/plan-story.md)
</wip_assignments>

</instructions>
</xml>
