# Assignment-Based Workflow

* The assignment-based workflow builds on the task-based workflow process by including the new concept of assignments. 
* Workflow assignments are specifically-defined sets of goals, acceptance criteria, and steps.

## Workflow Assignments

* Each workflow assignment is unique and describes how to accomplish a specific task, start a new project/application, or stage of the project.
* Workflow assignments are assigned to you by the orchestrator or user.
* When assigned, you are to perform the assignment until finished and/or assigned something new.
* Each type of assignment is described in a workflow assignment definition file.

## Workflow Assignment Files
* Definition files are found under the `ai_instruction_modules/ai-workflow-assignments/` directory in a subdirectory named exactly as the workflow assignment definition's "short ID" (See sections below for definition of an assignment's "short ID").

```
<WORKSPACE-ROOT>/
    ai_instructions_modules/
        ai-workflow-assignments/
            *<assignment_short_id>*        // e.g. "pr-approval-and-merge"
```

## Workflow Assignment Definition Format

### Sections
The format is made up of the following sections:

* Title, Short ID, Goal, Acceptance Criteria, Assignment, Detailed Steps, Completion

## Authoritative Execution
- Assignment files are the single source of truth for steps and Acceptance Criteria.
- Orchestrators and agents must not declare success unless all Acceptance Criteria pass, or an explicit deviation is recorded and approved.

## Mandatory Practices
- Resolution trace before execution (print files + URLs/SHAs when available)
- Assignment-first execution; no step synthesis from higher-level index or dynamic files
- Acceptance-criteria gating as the Definition of Done
- Template and preflight enforcement where specified
- Branch-protection-aware, idempotent operations
- Required Run Report mapped 1:1 to Acceptance Criteria with evidence

## Non-Negotiable Behaviors for Workflow Assignments
- Resolution Trace: Before executing any workflow assignment, print the dereference chain (files + URLs/SHAs).
- Assignment-First: Execute steps only from the resolved assignment file(s); do not infer steps from indices or dynamic files.
- Acceptance Gate: Treat Acceptance Criteria as the Definition of Done; do not mark complete unless all pass or deviations are explicitly approved.
- Preflight: Enforce template/source-of-truth and environment prerequisites before executing steps.
- Protection-Aware: Respect branch protection; prefer feature branch + PR when protected.
- Report: Produce a Run Report mapped to Acceptance Criteria with evidence links.

## References
- Orchestrator: [/orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md/orchestrate-dynamic-workflow.md)
- Dynamic syntax: [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)

### Section Descriptions

* Assignment Title: A descriptive title for the assignment.
* Assignment Short ID: A unique identifier for the assignment, typically in parentheses.
* Goal: A clear statement of what the assignment aims to achieve.
* Acceptance Criteria: A list of conditions that must be met for the assignment to be considered complete.
* Assignment: A detailed description of the assignment, including any specific tasks or actions required.
* Detailed Steps: A step-by-step guide on how to complete the assignment, including any specific instructions or considerations.
* Completion: Instructions on how to finalize the assignment, including any follow-up actions or confirmations needed.

## Available Assignments

### Orchestration & Program Management
* [orchestrate-new-project.md](ai-workflow-assignments/orchestrate-new-project.md): This assignment involves orchestrating a new project end-to-end—initializing the repo, creating the application plan, building the project structure, breaking down epics into implementable issues, overseeing implementation and validation, and delivering the final product.

### Planning
* [create-app-plan.md](ai-workflow-assignments/create-app-plan.md): This assignment involves creating a plan for a new application based on a filled-out application template. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan.
* [create-epic.md](ai-workflow-assignments/.wip/create-epic.md) (create-epic): This assignment involves creating a single epic sub-issue from a phase in the main application plan. The epic represents a major implementation phase with clear deliverables and contains detailed story breakdowns.
* [create-story.md](ai-workflow-assignments/.wip/create-story.md) (create-story): This assignment involves creating a single story sub-issue from an epic issue. Stories are granular, executable tasks that can be implemented independently by developers.

### Initialization & Setup
* [create-application.md](ai-workflow-assignments/create-application.md): This assignment involves creating a new application given the description from a new app template that has been filled out, including setting up the project structure, configuring necessary components, and ensuring the application meets specified requirements.
* [create-app-from-plan-issue.md](ai-workflow-assignments/create-app-from-plan-issue.md): This assignment involves creating a new application from an initialized git repo and a filled-out development plan issue, implementing the project structure and components.
* [create-app-from-plan-issue (unguided).md](ai-workflow-assignments/create-app-from-plan-issue%20(unguided).md): This assignment is an unguided variant of creating an application from a plan issue, providing less prescriptive steps.
* [create-project-structure.md](ai-workflow-assignments/create-project-structure.md): This assignment involves creating the actual project structure and scaffolding for a new application based on a comprehensive application plan. This involves setting up the repository, creating the solution structure, configuring initial project files, and establishing the development environment foundation.
* [init-existing-repository.md](ai-workflow-assignments/init-existing-repository.md): This assignment involves initializing and configuring an existing repository, setting up project structure, labels, milestones, and renaming workspace/devcontainer files.

### Implementation & Execution
* [continue-task-work.md](ai-workflow-assignments/continue-task-work.md) (continue-task-work): This assignment involves discovering, assessing, prioritizing, and resuming in-progress tasks to completion, ensuring proper integration, updates to issues/PRs, and stakeholder review.
* [perform-task.md](ai-workflow-assignments/perform-task.md): This assignment involves executing a specific task given to you by an orchestrator or stakeholder, using the task-based workflow process.  This includes understanding the task requirements, planning/gaining approval and gathering necessary resources, and delivering the expected outcome.

### Review & QA
* [create-test-cases.md](ai-workflow-assignments/create-test-cases.md): This assignment involves creating test cases for the application, ensuring that all critical functionality is covered and that the tests are properly integrated into the build process. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan. You will also create (or upgrade, if necessary) an automated test pipeline.
* [pr-approval-and-merge.md](ai-workflow-assignments/pr-approval-and-merge.md): This assignment involves resolving all pull request (PR) comments, getting the PR approved, and merging it upstream.
* [pr-review-comments.md](ai-workflow-assignments/pr-review-comments.md) (pr-review-comments): This assignment involves reviewing and addressing comments on a pull request (PR). You will systematically resolve each comment, commit changes, reply with a description of changes, and mark the comment resolved. You need to ensure the PR is ready for approval and merge.
* [request-approval.md](ai-workflow-assignments/request-approval.md) (request-approval): This assignment involves pausing execution to present relevant produced material to stakeholders, explicitly requesting their approval, and handling their decision to either proceed, revise, or escalate.

### Documentation & Analysis
* [analyze-plan-issue.md](ai-workflow-assignments/analyze-plan-issue.md): This assignment involves analyzing an application development plan issue to determine fitness for implementation, identify gaps, assess risks and mitigations, and provide recommendations for improvement.
* [analyze-progress-doc.md](ai-workflow-assignments/analyze-progress-doc.md): This assignment involves rigorously interrogating a provided repo to analyze the progress made and identify any gaps or areas that need further work. You will then document your findings in a new issue.
* [debrief-and-document.md](ai-workflow-assignments/debrief-and-document.md): This assignment involves running a formal debrief to capture lessons learned, highlight successes and gaps, and publish a stakeholder-approved report with recommended updates to workflows, prompts, and agent files.
* [update-plan-issue.md](ai-workflow-assignments/update-plan-issue.md) (update-plan-issue): This assignment involves creating a new, updated version of an application development plan issue by incorporating findings and recommendations from an analysis file, conducting delegate roundtable review, and obtaining stakeholder approval.

### Dynamic Workflows
* [orchestrate-dynamic-workflow.md](ai-workflow-assignments/orchestrate-dynamic-workflow.md): Orchestrate a dynamic workflow as defined in a dynamic workflow file under the "Script" section—iterate through each specified assignment (by short ID) in order, oversee execution to completion, and obtain approval.
* [validate-dynamic-workflow-script.md](ai-workflow-assignments/validate-dynamic-workflow-script.md): Validate a dynamic workflow script against the canonical DSL: check syntax, logical structure, existence of referenced assignment short IDs, and path correctness; provide pass/fail feedback with fixes if needed.

#### Available Dynamic Workflow Scripts
* [implement-by-stories.md](ai-workflow-assignments/dynamic-workflows/implement-by-stories.md): Implements an application development plan by systematically completing story issues across all epics. Processes each epic in sequence, with support for parallel or serial story execution within each epic.
* [implement-epic.md](ai-workflow-assignments/dynamic-workflows/implement-epic.md): Implements a single epic by systematically completing its story issues. Auto-selects the next incomplete epic if none is specified. Includes milestone completion and project progress tracking.
* [analyze-plan.md](ai-workflow-assignments/dynamic-workflows/analyze-plan.md): Dynamic workflow for analyzing application development plans.
* [breakdown-plan.md](ai-workflow-assignments/dynamic-workflows/breakdown-plan.md): Dynamic workflow for breaking down plans into implementable components.
* [design-app-outline.md](ai-workflow-assignments/dynamic-workflows/design-app-outline.md): Dynamic workflow for creating application design outlines.

## Work-In-Progress Assignments

The following assignments are currently under development in the `.wip` directory and are not yet ready for use:

### Planning (WIP)
* [breakdown-epic-and-plan.md](.wip/breakdown-epic-and-plan.md): Breaking down a high-level epic into granular, executable sub-issues.
* [breakdown-stories-and-plan.md](.wip/breakdown-stories-and-plan.md): Converting a higher-level multi-task sub-phase epic sub-issue into granular, executable sub-issues (stories).
* [create-app-plan-and-epics.md](.wip/create-app-plan-and-epics.md): Creating a comprehensive application plan and creating epic sub-issues for each phase in a single workflow.
* [outline-epic.md](.wip/outline-epic.md) (outline-epic): Creating a comprehensive structural outline for an epic with all classes, interfaces, methods (no implementation), comprehensive XML documentation, and test stubs to enable Test-Driven Development.
* [plan-epic.md](.wip/plan-epic.md): Planning an epic with detailed breakdown and requirements.
* [plan-story.md](.wip/plan-story.md): Planning a story with detailed implementation steps.

### Specialized Tasks (WIP)
* [convert-vs-color-theme-to-vscode.md](.wip/convert-vs-color-theme-to-vscode.md): Converting a Visual Studio color theme to a Visual Studio Code color theme.
  