# Iterative Guardrails Workflow

## Iterate Writing Guards, Writing Code, amd Running Guardrails

This file describes your iterative guardrails-based workflow where you create your guards, write code, and then run the guards to validate the code, repeating until all of your guards pass. 

*NOTE:* When first written, your guards are expected to fail. As you implement the code they test, your guards will begin to pass more and more, until they all pass.

> This process is widely know as TDD: Test-Driven Development.
> Good, simple overview of TDD: [5-steps-of-test-driven-development](https://developer.ibm.com/articles/5-steps-of-test-driven-development/)

## Defining Guardrails

Guardrails are anything that can validate the code. They can be unit tests, integration tests, or any other type of test. They can also be linters, validators, or any other type of tool that scans the code. Building the code to validate there are no compiler or syntax or linking errors is also a type of guard. They can also be CI pipelines, or any other type of pipeline that validates the code.

### Guardrail Types
- Automated Tests
  - Unit Tests
  - Integration Tests
  - End-to-End Tests
  - Performance Tests
- Linters
  - Static Analysis
  - Syntax Checking
  - Security Scanning
  - Compliance Scanning
  - Code Quality Scanning
  - Secret Scanning
- CI Pipelines
- Building
  - Compiling
  - Linking
  - Syntax  

### CI Pipelines as Guardrails

Using CI pipelines as guardrails means that your pipelines need to be fast and focused. They should not take longer than a few minutes to run. If they do, then they are not suitable for use as guardrails. Best practice is to sp[liot the pipelines up into a CI pipeline and a Delivery pipeline, where the CI pipeline is used for guardrails and the Delivery pipeline is used for deployment.]

### Committing Frequently

When using CI pipelines as guardrails, you will need to commit frequently in order to trigger the CI pipeline and validate your code as you work.

- After committing, you will need to push the code to the remote repository to trigger the CI pipeline.
- You will need to check your CI pipline results frequently to ensure that your code is passing all of the guards.
- Checking frequently will help you catch errors quickly and allow you to fix them so that they pass.
- Using CI pipelines as guardrails in the iterative guardrails workflow implies that your CI pipeline will fail at th ebeginning, anf then frequently after that as you are iterating and implementing. This is expected and normal.

## Iterative Guardrails Workflow Steps

### Beginning

#### Beginning

- When starting, always stop to review the current status and what work, if any, has already been completed. 
- Before starting any work, determine where you need to start, based on what work has already been completed (if any). -
- The instructions in the Review Current State and the Issues sections and your Memory Tool's ["Current Task Reminder"](../ai-current-task-reminder) can help you with this.
- Check your "current task reminder" in your memory first to understand your previous context.
- Review the current status of the code, what reamins to be done, and how much of that hsas validation coverage.

>- If CI pipelines do not exist, create them.
>  - At the miniumium, you will need the followingsteps:
>  - Build
>  - Test
>  - Static Analysis/Linting
>  - Secret Scanning
>  - Security Scanning

- Most of the time for new tasks, or even maintenance tasks, there will be no validation coverage.
- Begin by creating the validation guards that will validate the functionality you are creating.
  - Create CI Pipelines
  - Create automated tests that will validate the functionality you are creating
- Once you have created the guards, run your tests and commit and push your code to trigger the CI pipeline and validate that your guards are working correctly, but failing (i.e. that your tests and CI function and complete successfully with no defects, but the tests or scans are failing)
- With your guards in place, you are ready to begin the iterattive process:
  - Write your code and implement your functionality in small increments
  - Validate your code by running your guards
    - Build
    - Run your tests locally
    - Check in code to run CI pipelines
- Iterate until all of functionality is complete with al tests and CI pipelines passing.

>**NOTE:** Once you are finished iterating, you will often find that your new code is not completely covered by your guards. If coverage of your new functionality is < 100%, then you will need to create additional guards to validate the new code and achieve 100% coverage.

## Completion

Once your functionality is complete, building successfully, and all tests and CI pipelines are passin, with 100% coverage, you are done. 

- Review your work and document it
- Report to user and ask for approval
- Once approval is gained, you are done.
