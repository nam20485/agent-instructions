# Assignment: Orchestrate Dynamic Workflow

## (orchestrate-dynamic-workflow)

### Overview

The dynamic workflow orchestration assignment is different than the other static workflow assignments, in that it must orchstrate the workflows for a dynamically-specified list of subordinate workflow assignments, which are orchestrated and performed in the order specified in the file, systematically iterating serially through each one until completion.

### Goal

Your goal is to orchestrate systematically through the assignments specified in the provided dynamic workflow file, performing the steps in each one to completion in turn. Each assignment is specified by name, short ID, and inputs.

### Acceptance Criteria

1. All specified assignments are completed and approved.
2. All specified assignments are completed in the order specified in the file.
3. All acceptance criteria for each specified assignment are met.
4. Approval is obtained for the final product.

### Assignment

Your assignment is to orchestrate the workflow specified in the provided dynamic workflow file. This involves systematically iterating through each specified assignment, orchestrating and overseeing the work until completion.

#### Dynamic Workflow File Conventions
- The list of sub-workflow assignments resides in a file whose name is provided as input to this assignment.
- The name provided indicates a dynamic workflow file located in the [./ai_instruction_modules/ai-workflow-assignments/dynamic](./dynamic) directory.
- The format for naming the dynamic worklow files is `dynamic-workflow_<name>.md`. 

> **Example:** Invoking the `orchestrate-dynamic-workflow` assignment, by specifying *`new-project`* as the input, will invoke orchestration of a dynamic workflow specified in the file named `dynamic-workflow_new-project.md,` located in the `./ai_instruction_modules/ai-workflow-assignments/dynamic/` directory.

### Detailed Steps

For each assignment *assignment_n* specified by name in the dynamic workflow file's list, you will orchestrate the assignment by performing the following steps:

1. **Perform *assignment_n***
   -  You will assign the copilot the *assignment_n* assignment.
   -  You will wait until agent finishes the task.
   -  You will review the work and approve it.
   -  Upon approval, you will move on to the next assignment.

### Completion

After all steps have been completed, notify the user that the workflow is complete and obtain approval. Upon obtaining approval, the workflow is complete and the orchestrator's assignment is finished.
