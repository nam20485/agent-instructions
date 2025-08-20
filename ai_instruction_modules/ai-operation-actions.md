# Operation Actions

## Description

This module contains instructions for performing specific operations. These instructions are intended to be used in conjunction with the `ai-workflow-assignments` module to perform specific tasks.

## Characteristics
- They contain a list of operations that can be performed and the steps to perform them.
- They are not intended to be read standalone.
- They will be referenced by different workflow assignments, as needed.
- They will be referenced by file name in the workflow assignment's `Actions` section.

## Structure
- The sub-sections under `Actions` will be `Pre`, `During`, or `Post`.
  - This indicates whether the operation should be performed before, during, or after the workflow assignment's steps.
  - **NOTE:** The `During` section is not yet implemented.
- Another sub-section under the `Pre`, `Post`, or `During` sections will be sections for Outcomes. 
  - These will be named `Success`, `Failure`, or `Always`. 
  - `Success` and `Failure` are self-explanatory. 
  - `Always` indicates that the operation should always be performed, regardless of the outcome of workflow assignment.

## Operation Action Outcomes
- After the operation steps are performed the agent should evaluate the outcome and determine if the operation was successful or not. 
  - The agent will create a file called `.ai-operation-outcomes.md` in the root of the repository.
  - This file will contain a list of all operations performed and their outcomes.
  - For each operation action listed, based on the outcome, the agent will leave descriptive comments in the file, explaining what was done and the outcome.
  - For `Success` outcomes, the agent will leave information about the name of the item created, the name of the branch, or other relevant information, where it's located, and a link to the item.
    - For `Failure` outcomes, the agent will leave information about what went wrong and what remediation steps are needed.

## Location
Operation actions files are intended to live under `ai_instruction_modules/ai-workflow-assignments/operation-actions` (TBD). This folder may not exist yet; references are illustrative until populated.

## Examples

### Reference from Workflow Assignment

**WIP**

# SHOULD DESCRIPTIVE DECLARATIVE INFO RESIDE in the workflow assignment file or the operation action file?

*//From ai-workflow-assignments/create-app-plan.md*
```markdown
### Actions
### Pre
### Post
#### Success
1. [create-issues.md](ai-workflow-assignments/operation-actions/create-github-project.md)
2. [create-milestones.md](ai-workflow-assignments/operation-actions/create-milestones.md)
```

### Operation Action File
*//File: ai-workflow-assignments/operation-actions/create-github-project.md*
```markdown
```




