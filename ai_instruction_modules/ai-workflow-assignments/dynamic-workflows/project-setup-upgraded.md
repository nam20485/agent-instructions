# Dynamic Workflow: Project Setup (Upgraded)

## Overview

This workflow sets up a new project with modern best practices using generic, framework-agnostic assignments with automatic validation.

**Use this workflow for**: New project setup across all tech stacks (Node.js, Python, Rust, Java, Go, C#, etc.)

## Script

### Inputs

### initiate-new-repository

`$assignments` = [  
                    `init-existing-repository`,
                    `create-app-plan`,
                    `create-application-foundation`,
                    `create-application-structure`,
                    `create-testing-infrastructure`,
                    `create-deployment-infrastructure`,
                    `pr-approval-and-merge`,
                    `debrief-and-document`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`

### Events

#### `pre-assignment-begin`

This event runs before EACH assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begin.gather-context`

#### `on-assignment-failure`

This event runs when ANY assignment fails to recover from errors systematically.

- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-complete`

This event runs after EACH assignment completes to report progress and validate the work.

`$progress_and_validation_assignments` = [
                     `create-repository-summary`,     
                     `validate-assignment-completion`,
                     `report-progress`
                 ]

For each `$pv_assignment_name` in `$progress_and_validation_assignments`, you will:
   - assign the agent the `$pv_assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
     - if `$pv_assignment_name` is `validate-assignment-completion`:
     - if validation failed, halt workflow and request manual intervention # Halt workflow to prevent further execution with invalid state
     - if validation passed, proceed to next assignment in `$progress_and_validation_assignments`
   - record output as `#events.post-assignment-complete.$pv_assignment_name`

## Assignment Details

### Main Workflow Assignments

1. **init-existing-repository**
   - Initializes git repository
   - Sets up basic repository structure
   - Configures git settings

2. **create-app-plan**
   - Creates comprehensive application plan
   - Documents architecture and technology choices
   - Defines project scope and requirements

3. **create-application-foundation**
   - Sets up dependency management (package.json, requirements.txt, Cargo.toml, etc.)
   - Configures build system (vite, webpack, gradle, cargo, etc.)
   - Sets up code quality tools (ESLint, pylint, clippy, etc.)
   - Creates directory structure
   - Configures environment variables
   - **Time**: 15-20 minutes
   - **Generic**: Works with any tech stack

4. **create-application-structure**
   - Creates application entry point
   - Sets up core architecture (MVC, Clean Architecture, etc.)
   - Creates configuration management
   - Creates common utilities
   - Sets up health/status endpoints
   - **Time**: 20-25 minutes
   - **Generic**: Works with any architecture pattern

5. **create-testing-infrastructure**
   - Sets up test framework (Jest, pytest, JUnit, cargo test, etc.)
   - Creates test directory structure
   - Creates test utilities
   - Writes initial smoke tests (5+)
   - Creates testing documentation
   - **Time**: 20-30 minutes
   - **Generic**: Works with any testing framework

6. **create-deployment-infrastructure**
   - Creates containerization (Docker, if applicable)
   - Sets up CI/CD workflows (GitHub Actions, GitLab CI, Jenkins, etc.)
   - Creates deployment scripts
   - Sets up Infrastructure as Code (if applicable)
   - Creates setup scripts
   - Creates deployment documentation
   - **Time**: 25-30 minutes
   - **Generic**: Works with any CI/CD platform

7. **debrief-and-document**
   - Creates comprehensive debriefing report using 12-section template
   - Documents lessons learned and improvements
   - Captures metrics and statistics
   - Provides future recommendations

### Event Assignments

1. **validate-assignment-completion**
   - Validates that assignment outputs exist
   - Runs verification commands (build, test, lint, etc.)
   - Creates validation report
   - **Blocks progression if validation fails**
   - Provides specific remediation steps if needed

2. **create-repository-summary**
   - Creates repository summary document
   - Links from README
   - Documents project structure and setup

## Usage

To use this workflow:

```bash
# Orchestrate the upgraded workflow
orchestrate-dynamic-workflow project-setup-upgraded
*or*
orchestrate-dynamic-workflow  - $workflow_name = project-setup-upgraded
```

## Notes

- This workflow uses all the new generic assignments from Part 1
- Includes automatic validation from Part 2
- All assignments include error recovery, progress reporting, and context gathering
- Recommended for all new projects
- Original workflow remains available for backward compatibility
- Total time: ~90-120 minutes (vs 60+ minutes for original, but with better quality and validation)

## Related Files

- **Original Workflow**: `project-setup.md`
- **Assignments**: 
  - `init-existing-repository.md`
  - `create-app-plan.md`
  - `create-application-foundation.md`
  - `create-application-structure.md`
  - `create-testing-infrastructure.md`
  - `create-deployment-infrastructure.md`
  
  - `validate-assignment-completion.md`
  - `create-repository-summary.md`
  - `debrief-and-document.md`
