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
* [orchestrate-new-project.md](ai-workflow-assignments/orchestrate-new-project.md) (orchestrate-new-project): This assignment involves orchestrating a new project end-to-end—initializing the repo, creating the application plan, building the project structure, breaking down epics into implementable issues, overseeing implementation and validation, and delivering the final product.

### Planning
* [breakdown-epic-and-plan.md](ai-workflow-assignments/breakdown-epic-and-plan.md) (breakdown-epic-and-plan): This assignment involves breaking down a high-level epic into granular, executable sub-issues. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan.
* [create-app-plan.md](ai-workflow-assignments/create-app-plan.md) (create-app-plan): This assignment involves creating a plan for a new application based on a filled-out application template. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan.

### Initialization & Setup
* [create-application.md](ai-workflow-assignments/create-application.md) (create-application): This assignment involves creating a new application given the description from a new app template that has been filled out, including setting up the project structure, configuring necessary components, and ensuring the application meets specified requirements.
* [create-project-structure.md](ai-workflow-assignments/create-project-structure.md) (create-project-structure): This assignment involves creating the actual project structure and scaffolding for a new application based on a comprehensive application plan. This involves setting up the repository, creating the solution structure, configuring initial project files, and establishing the development environment foundation.
* [initialize-new-repository.md](ai-workflow-assignments/initialize-new-repository.md) (initialize-repository): This assignment involves creating and configuring a new repository from a template, copying app plan docs, setting up labels and milestones, creating a GitHub Project board, and renaming workspace/devcontainer files.

### Implementation & Execution
* [continue-task-work.md](ai-workflow-assignments/continue-task-work.md) (continue-task-work): This assignment involves discovering, assessing, prioritizing, and resuming in-progress tasks to completion, ensuring proper integration, updates to issues/PRs, and stakeholder review.
* [perform-task.md](ai-workflow-assignments/perform-task.md) (perform-task): This assignment involves executing a specific task given to you by an orchestrator or stakeholder, using the task-based workflow process.  This includes understanding the task requirements, planning/gaining approval and gathering necessary resources, and delivering the expected outcome.

### Review & QA
* [create-test-cases.md](ai-workflow-assignments/create-test-cases.md) (create-test-cases): This assignment involves creating test cases for the application, ensuring that all critical functionality is covered and that the tests are properly integrated into the build process. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan. You will also create (or upgrade, if necessary) an automated test pipeline.
* [pr-approval-and-merge.md](ai-workflow-assignments/pr-approval-and-merge.md) (pr-approval-and-merge): This assignment involves resolving all pull request (PR) comments, getting the PR approved, and merging it upstream.
* [pr-review-comments.md](ai-workflow-assignments/pr-review-comments.md) (pr-review-comments): This assignment involves reviewing and addressing comments on a pull request (PR). You will systematically resolve each comment, commit changes, reply with a description of changes, and mark the comment resolved. You need to ensure the PR is ready for approval and merge.

### Documentation & Analysis
* [ai-creating-repository-summary.md](ai-workflow-assignments/ai-creating-repository-summary.md) (ai-creating-repository-summary): This assignment involves creating a custom summary of a repository. You will create a `.ai-repository-summary.md` file in the repository that contains information describing how a coding agent seeing it for the first time can work most efficiently.
* [analyze-progress-doc.md](ai-workflow-assignments/analyze-progress-doc.md) (analyze-progress-doc): This assignment involves rigorously interrogating a provided repo to analyze the progress made and identify any gaps or areas that need further work. You will then document your findings in a new issue.

### Specialized Tasks
* [convert-vs-color-theme-to-vscode.md](ai-workflow-assignments/convert-vs-color-theme-to-vscode.md) (convert-vs-color-theme-to-vscode): This assignment involves converting a Visual Studio color theme to a Visual Studio Code color theme. You will create a plan, document it in an issue, and once gaining approval, you will implement the plan.
  