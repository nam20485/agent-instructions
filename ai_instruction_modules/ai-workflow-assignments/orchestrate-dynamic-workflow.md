# Assignment: Orchestrate Dynamic Workflow

## (orchestrate-dynamic-workflow)

### Overview

The dynamic workflow orchestration assignment is different than the other static workflow assignments, in that it must orchstrate the workflows for a dynamically-specified list of workflow assignments, as specified in a dynamic workflow file. The dynamic workflow file specifies assignments to be performed in the #Script section of the file.

### Goal

Your goal is to orchestrate systematically through the assignments as specified in the provided dynamic workflow file's #Script section, performing the steps in each one to completion in turn. Assignments are specified by short id.

### Acceptance Criteria

1. All specified assignments are completed and approved.
2. All specified assignments are completed in the order specified in the file.
3. All specified assignments are completed according to the instructions givenin the dynamic workflow file.
4. All acceptance criteria for each specified assignment are met.
5. All directives in the #Script section of the dynamic workflow file are executed.
6. Approval is obtained for the final product.

### Assignment

Your assignment is to orchestrate the workflow assignment as specified by name and instructions in the provided dynamic workflow file. This involves systematically iterating through each specified assignment, orchestrating and overseeing the work until completion, according to the instructions specified in the #Script section in the dynamic workflow file.

#### Dynamic Workflow File Conventions
- The list of sub-workflow assignments resides in a file whose name is provided as input to this assignment.
- The name provided indicates a dynamic workflow file located in the [./ai_instruction_modules/ai-workflow-assignments/dynamic](./dynamic) directory.
- The format for naming the dynamic worklow files is `dynamic-workflow_<name>.md`. 

> **Example:** Specifying *`new-project`* as input, when invoking the `orchestrate-dynamic-workflow` assignment, will invoke orchestration of a dynamic workflow specified in the file named `dynamic-workflow_new-project.md,` located in the `./ai_instruction_modules/ai-workflow-assignments/dynamic/` directory.

##### Legend for Dynamic Workflow File Syntax

* `$variable` = *<value>*: Define the variable `$variable` to have the value *<value>*
* `$variable`: use of a previously-defined variable `$variable`
* `#<step>`: reference to the output of the `<step>`
* `#<step>.<substep>`: reference to the output of the `<substep>` in the `<step>`
* `get-function-name(<parameters>)`: call to a function with the specified parameters (name of function indicates its behavior)

### Detailed Steps

The detailed steps are specified in the #Script section of the dynamic workflow file. Essentially you will iterate through each assignment specified in the file, orchestrating and overseeing the work until completion, according to the instructions provided in the #Script section of the dynamic workflow file.

### Completion

After all steps have been completed, notify the user that the workflow is complete and obtain approval. Upon obtaining approval, the workflow is complete and the orchestrator's assignment is finished.
