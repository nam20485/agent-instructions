# Dynamic Workflow: Project Setup (Upgraded)

## Overview

This is an upgraded version of the project-setup workflow that uses the new generic, framework-agnostic assignments and includes automatic validation.

**Key Improvements**:
- Uses 4 focused assignments instead of 1 monolithic assignment
- Includes automatic validation after each assignment
- Works across all tech stacks (Node.js, Python, Rust, Java, Go, C#, etc.)
- Better error isolation and recovery
- Faster execution (15-30 min per assignment vs 60+ min)

**Use this workflow for**: New project setup with modern best practices

**Original workflow**: `project-setup.md`

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
                    `debrief-and-document`
                 ]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initiate-new-repository.$assignment_name`

### Events

#### `post-assignment-completion`

This event runs after EACH assignment completes to validate the work and create repository summary.

`$poc_assignments` = [  
                    `validate-assignment-completion`,
                    `create-repository-summary`
                 ]

For each `$poc_assignment_name` in `$poc_assignments`, you will:
   - assign the agent the `$poc_assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - if `$poc_assignment_name` is `validate-assignment-completion`:
     - if validation failed, halt workflow and request manual intervention
     - if validation passed, proceed to next assignment in `$poc_assignments`
   - record output as `#events.post-assignment-completion.$poc_assignment_name`

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

3. **create-application-foundation** (NEW - replaces part of create-project-structure)
   - Sets up dependency management (package.json, requirements.txt, Cargo.toml, etc.)
   - Configures build system (vite, webpack, gradle, cargo, etc.)
   - Sets up code quality tools (ESLint, pylint, clippy, etc.)
   - Creates directory structure
   - Configures environment variables
   - **Time**: 15-20 minutes
   - **Generic**: Works with any tech stack

4. **create-application-structure** (NEW - replaces part of create-project-structure)
   - Creates application entry point
   - Sets up core architecture (MVC, Clean Architecture, etc.)
   - Creates configuration management
   - Creates common utilities
   - Sets up health/status endpoints
   - **Time**: 20-25 minutes
   - **Generic**: Works with any architecture pattern

5. **create-testing-infrastructure** (NEW - replaces part of create-project-structure)
   - Sets up test framework (Jest, pytest, JUnit, cargo test, etc.)
   - Creates test directory structure
   - Creates test utilities
   - Writes initial smoke tests (5+)
   - Creates testing documentation
   - **Time**: 20-30 minutes
   - **Generic**: Works with any testing framework

6. **create-deployment-infrastructure** (NEW - replaces part of create-project-structure)
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

1. **validate-assignment-completion** (NEW)
   - Validates that assignment outputs exist
   - Runs verification commands (build, test, lint, etc.)
   - Creates validation report
   - **Blocks progression if validation fails**
   - Provides specific remediation steps if needed
   - **Time**: 5-10 minutes per assignment

2. **create-repository-summary**
   - Creates repository summary document
   - Links from README
   - Documents project structure and setup

## Benefits of Upgraded Workflow

### Compared to Original Workflow

**Original**:
- 1 monolithic `create-project-structure` assignment (60+ minutes)
- No validation between steps
- Specific to certain tech stacks
- Difficult to debug and recover from errors

**Upgraded**:
- 4 focused assignments (15-30 minutes each)
- Automatic validation after each assignment
- Works with any tech stack
- Better error isolation and recovery
- Enables parallel execution (if desired)

### Key Improvements

1. **Generic and Reusable**
   - Works with Node.js, Python, Rust, Java, Go, C#, Ruby, PHP, etc.
   - Supports different architectures (MVC, Clean, Hexagonal, etc.)
   - Reusable across web apps, APIs, CLIs, libraries, mobile apps

2. **Faster and More Focused**
   - Each assignment is 15-30 minutes instead of 60+
   - Clear, focused goals for each assignment
   - Better progress tracking

3. **Automatic Validation**
   - Validates after each assignment
   - Prevents cascading failures
   - Provides immediate feedback
   - Creates audit trail

4. **Better Error Recovery**
   - Smaller assignments = easier to debug
   - Clear error recovery procedures in each assignment
   - Validation catches issues early
   - Easier to rollback or fix

## Migration from Original Workflow

If you have projects using the original `project-setup.md` workflow:

**Option 1: Use Upgraded for New Projects**
- Keep using original for existing projects
- Use upgraded for all new projects
- Gradually migrate existing projects

**Option 2: Full Migration**
- Update all references from `project-setup` to `project-setup-upgraded`
- Test thoroughly before deploying
- Update documentation

**Backward Compatibility**:
- Original `project-setup.md` still works
- Both workflows can coexist
- Choose based on project needs

## Usage

To use this upgraded workflow:

```bash
# Orchestrate the upgraded workflow
orchestrate-dynamic-workflow project-setup-upgraded
```

Or reference it in other workflows:

```markdown
`$workflow` = `project-setup-upgraded`

assign the agent the `orchestrate-dynamic-workflow` assignment with workflow `$workflow`
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
- **New Assignments**: 
  - `create-application-foundation.md`
  - `create-application-structure.md`
  - `create-testing-infrastructure.md`
  - `create-deployment-infrastructure.md`
  - `validate-assignment-completion.md`
- **Enhanced Assignment**: `debrief-and-document.md`
