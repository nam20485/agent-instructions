# Assignment: Orchestrate Dynamic Workflow

## (orchestrate-dynamic-workflow)

## Overview
The dynamic workflow orchestration assignment is different than static workflow assignments, in that it must orchestrate workflows for a dynamically specified list of workflow assignments, as specified in a dynamic workflow file. The dynamic workflow file specifies assignments to be performed in the "Script" section of the file.

## Inputs
- $workflow_name: the dynamic workflow name to execute (string)

## Goal
Orchestrate systematically through the assignments as specified in the provided dynamic workflow file's Script section, performing the steps in each one to completion in turn. Assignments are specified by short ID.

### Assignment

Your assignment is to orchestrate the workflow assignment as specified by name and instructions in the provided dynamic workflow file. This involves systematically iterating through each specified assignment, orchestrating and overseeing the work until completion, according to the instructions specified in the "Script" section in the dynamic workflow file.

#### Dynamic Workflow File Conventions

- The workflow name provided indicates a dynamic workflow file located in the [./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows](./dynamic-workflows) directory.
- The format for naming the dynamic workflow files may be standardized; see repository conventions.

> Example: Specifying "new-project" as input, when invoking the orchestrate-dynamic-workflow assignment, will look for a dynamic workflow file at `./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/new-project.md`.

- The $context variable is an object containing variables.
- This object contains input variables that are to be passed to the underlying workflow assignment that will be executed (i.e. the $workflow_name workflow assignment)

- Ensure the file contains a "## Script" section with one or more third-level step headings (e.g., "### create-project-and-plan").
- Run the orchestrate-dynamic-workflow assignment with input `<name>`.

### Scripts section

The detailed steps are specified in the "Script" section of the dynamic workflow file. Essentially, you will iterate through each assignment specified in the file, orchestrating and overseeing the work until completion, according to the instructions provided in the "Script" section of the dynamic workflow file.

#### Scripts / Inputs Section

This section lists the input variables provided by the calling process or invocation. It will be passed in by the calling invoker and then should be provided as-is to the invoked workflow assignment.

## Acceptance Criteria
1. All specified assignments are completed and approved.
2. All specified assignments are completed in the order specified in the dynamic workflow file.
3. All specified assignments are completed according to the instructions in the dynamic workflow file.
4. All acceptance criteria for each specified assignment are met.
5. All directives in the Script section of the dynamic workflow file are executed.
6. Approval is obtained for the final product.
7. No unresolved items remain at completion; results are documented and cross-linked as appropriate.

## Guardrails (Authoritative, Non-Optional)
These apply to all dynamic workflows.

- Resolution trace (mandatory before execution)
  - Resolve and print the dereference chain with URLs (and SHAs when available):
    orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → [assignments] → ai-workflow-assignments/<assignment>.md
  - Refuse to proceed if any file in the chain is unreadable.

- Assignment-first execution (no step synthesis)
  - Dynamic workflow files may enumerate assignment names and inputs only.
  - Execute steps strictly from the resolved assignment file(s). Do not infer or invent steps from the dynamic workflow file.

- Acceptance-criteria gating (Definition of Done)
  - Extract the Acceptance Criteria from each assignment file.
  - Treat each criterion as a must-pass gate. Do not declare success unless every criterion passes or an explicit, documented deviation is approved.

- Template and preflight enforcement
  - If the assignment specifies template/source-of-truth requirements (e.g., create repo from a template, enforce license/visibility, required scripts), enforce them.
  - If the target already exists but violates preconditions, either:
    - Recreate per spec; or
    - Retrofit artifacts and record the deviation (with rationale) in the Run Report.

- Branch protection and idempotency
  - If the default branch is protected, use a feature branch + PR path; do not force-push to protected branches.
  - Make runs idempotent: detect pre-existing artifacts; reconcile without destructive changes.

- Run Report (mandatory)
  - Produce a final Run Report mapped 1:1 to each assignment’s Acceptance Criteria with PASS/FAIL and evidence links.

## Execution Algorithm (Deterministic & Idempotent)

1) Intake
- Capture inputs: $workflow_name and $context.
- Resolve and print the resolution trace:
  - dynamic-workflows/$workflow_name.md → list of `$assignments`
  - For each: ai-workflow-assignments/<assignment>.md
- Abort early if any file is missing or unreadable.

2) Plan
- For each assignment:
  - Parse Inputs, Detailed Steps, and Acceptance Criteria from the assignment file.
  - Expand steps into concrete actions and checks for the current environment (permissions, branch protection, etc.).
  - Decide direct-to-default-branch vs. feature-branch+PR route.

3) Execute (per assignment, in order)
- Perform the Detailed Steps exactly as written in the assignment file.
- Honor preflight requirements (templates, scripts, visibility, licenses) before continuing.
- If a required step cannot be executed (e.g., missing permission), stop and report—do not partially declare success.

4) Verify (Gated)
- Evaluate each Acceptance Criterion.
- Record PASS/FAIL with evidence (links to repos, files, PRs, issues, projects, etc.).
- If any FAIL, stop and report the unmet criteria and remediation options.

5) Report
- Produce a Run Report (schema below) including the resolution trace, actions performed, and the acceptance-gated results.

## Preflight Checklist (Before Any Actions)
- Files readable:
  - dynamic-workflows/$workflow_name.md
  - All referenced ai-workflow-assignments/<assignment>.md files
- Environment:
  - Required credentials/permissions available (e.g., GitHub repo create, labels, projects).
  - Branch protection understood; PR route planned if needed.
- Template/source-of-truth:
  - If specified by the assignment, verify template availability and policy; plan enforcement.

## Run Report (Required Schema)
- Header
  - Assignment: orchestrate-dynamic-workflow
  - Inputs: $workflow_name, $context (summarized)
- Resolution Trace
  - Ordered list of files used with URLs (and SHAs if available)
- Actions Executed
  - For each assignment, list the key actions performed (mirroring Detailed Steps)
- Acceptance Criteria Results
  - For each assignment, list each criterion with PASS/FAIL and evidence links
- Deviations
  - Any variance from assignment specs (e.g., retrofitting template artifacts), with rationale
- Outcome
  - Success only if all Acceptance Criteria are PASS (or explicitly approved deviations)

## Dynamic Workflow File Conventions (Reference)
- Dynamic workflow files reside under ai-workflow-assignments/dynamic-workflows.
- They provide the Script section which enumerates assignment names and inputs.
- They do not define executable steps; steps are defined in the referenced assignment files.
- Canonical syntax reference: dynamic-workflows/dynamic-workflow-syntax.md

## How to Run (Quick Start)
1. Place your workflow file under ai-workflow-assignments/dynamic-workflows/<name>.md.
2. Ensure the file contains a "## Script" section that enumerates assignment short IDs and inputs.
3. Invoke this orchestrator with inputs: $workflow_name=<name>, $context=<object>.
4. The orchestrator resolves the assignment files and executes their Detailed Steps to completion (gated by Acceptance Criteria).
5. Review the final Run Report; approve or request changes.

## Completion
After all steps have been completed and all Acceptance Criteria have passed (or explicitly approved deviations are recorded), notify the user that the workflow is complete and provide the Run Report.

## Prompt Guidance (Embed in any chat prompt)
Use this pre-execution preamble in any prompt that invokes this orchestrator to ensure consistent, acceptance-gated runs across tools and contexts.

Before execution (must do):
- Print the resolution trace (files + URLs/SHAs when available):
  - orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → assignments → ai-workflow-assignments/<assignment>.md
- Refuse to proceed if any file in the chain is unreadable.

Execution rules (non-negotiable):
- Execute steps strictly from the resolved assignment file(s); do not synthesize steps from dynamic workflow files.
- Extract Acceptance Criteria from each assignment and treat them as gates.
- Enforce template/source-of-truth and required scripts/visibility/license per assignment.
- Respect branch protection (use feature branch + PR) and keep operations idempotent.

Completion (Definition of Done):
- Produce a Run Report containing:
  - Resolution trace (files + URLs/SHAs)
  - Actions executed (mirroring Detailed Steps)
  - Acceptance Criteria: PASS/FAIL per item with evidence links
  - Deviations (if any) with rationale
  - Outcome: Success only if all criteria PASS (or explicitly approved deviations)

Embeddable snippet:

```
Before any execution:
- Print the resolution trace (files + URLs/SHAs) for: orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → assignments → ai-workflow-assignments/<assignment>.md
- Refuse to proceed if any file cannot be read.

Execution rules:
- Use only the resolved assignment file(s) for executable steps.
- Extract Acceptance Criteria and enforce them as gates (no partial done).
- Enforce template/scripts/visibility/license per assignment; respect branch protection (feature branch + PR) and idempotency.

Completion:
- Produce a Run Report with: resolution trace, actions executed, PASS/FAIL per criterion with evidence, deviations, and final outcome.
```

### References

See the canonical syntax: [dynamic-workflow-syntax.md](./dynamic-workflows/dynamic-workflow-syntax.md)

- Validate first: [validate-dynamic-workflow-script](./validate-dynamic-workflow-script.md)
