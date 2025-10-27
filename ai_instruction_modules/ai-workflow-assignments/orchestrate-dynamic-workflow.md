# Assignment: Orchestrate Dynamic Workflow

## (orchestrate-dynamic-workflow)

## Overview
The dynamic workflow orchestration assignment is different than static workflow assignments, in that it must orchestrate workflows for a dynamically specified list of workflow assignments, as specified in a dynamic workflow file. The dynamic workflow file specifies assignments to be performed in the "Script" section of the file.

## MANDATORY: Instruction Reading Chain (NO EXCEPTIONS)

**Before orchestrating ANY dynamic workflow** (new, resuming, or mid-assignment), read these files in order:

1. `ai-core-instructions.md` - Core protocol and rules
2. `dynamic-workflow-syntax.md` - **Event system** (pre-assignment-begin, etc.)
3. `ai-workflow-assignments.md` - Assignment protocol
4. `orchestrate-dynamic-workflow.md` - This file (orchestration rules)
5. `dynamic-workflows/[workflow-name].md` - Your specific workflow
6. `[assignment-name].md` - Each assignment before delegating to it
7. **Execute pre-assignment-begin event** - Then delegate

**Why**: Ensures you understand events, protocol, and current state before executing.

**No exceptions** - even if told "work already started", read this chain to orient yourself.

## Inputs
- `$workflow_name`: the dynamic workflow name to execute (string)
- Additional inputs: Any other parameters specified in the dynamic workflow file's "Inputs" section
  - These are passed through to the workflow being orchestrated
  - Parameter names must match those defined in the workflow's "Inputs" section
  - Can be passed as individual parameters or as a structured object

### Input Passing Examples

**Example 1: Direct parameter passing**
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `update-from-feedback`
  - $assignment_inputs = { directory: `./debriefs` }
```

**Example 2: Using command arguments**
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `$ARGUMENTS[0]`
  - $assignment_inputs = `$ARGUMENTS[1]`
```

**Example 3: Workflow with multiple inputs**
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `implement-epic`
  - $epic = 42
  - $repository = `myorg/myrepo`
  - $parallel_execution = `false`
```

**Example 4: Using the orchestrate-single-workflow command**

This command file wraps the orchestration for convenience:
```bash
# File: /home/nam20485/.config/opencode/command/orchestrate-single-workflow.md

# Usage from command line:
/orchestrate-single-workflow update-from-feedback { directory: "./debriefs" }
```

Internally it expands to:
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `update-from-feedback`  # from $ARGUMENTS[0]
  - $assignment_inputs = { directory: "./debriefs" }  # from $ARGUMENTS[1]
```

**Example 5: Using the orchestrate-single-update-from-feedback command**

This is a specialized command that pre-fills the assignment name:
```bash
# File: /home/nam20485/.config/opencode/command/orchestrate-single-update-from-feedback.md

# Usage from command line:
/orchestrate-single-update-from-feedback ./debriefs
```

Internally it expands to:
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `update-from-feedback`  # hard-coded
  - $assignment_inputs = `./debriefs`  # from $ARGUMENTS[0] - directory path
```

Note: The `update-from-feedback` assignment expects:
- Input: `$directory` (string) - path to directory containing feedback documents
- Example paths: `./debriefs`, `./feedback`, `./docs/feedback/epic-7`

**Example 6: Passing structured inputs**

For assignments that need multiple parameters:
```markdown
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `create-app-plan`
  - $assignment_inputs = {
      project_name: `my-project`,
      description: `A web application for task management`,
      features: [`authentication`, `task-crud`, `notifications`]
    }
```

**Example 7: Passing through from command arguments**

For flexible command wrappers:
```markdown
# Generic wrapper that takes any assignment and inputs
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `$ARGUMENTS[0]`  # e.g., "debrief-and-document"
  - $assignment_inputs = `$ARGUMENTS[1]`    # e.g., { workflow: "implement-epic" }
```

The orchestrator will extract all parameters (except `$workflow_name`) and pass them to the dynamic workflow as its inputs.

## Goal
Orchestrate systematically through the assignments as specified in the provided dynamic workflow file's Script section, performing the steps in each one to completion in turn. Assignments are specified by short ID.

### Assignment

Your assignment is to orchestrate the workflow assignment as specified by name and instructions in the provided dynamic workflow file. This involves systematically iterating through each specified assignment, orchestrating and overseeing the work until completion, according to the instructions specified in the "Script" section in the dynamic workflow file.

#### Dynamic Workflow File Conventions

- The workflow name provided indicates a dynamic workflow file located in the [./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows](./dynamic-workflows) directory.
- The format for naming the dynamic workflow files may be standardized; see repository conventions.

> Example: Specifying "new-project" as input, when invoking the orchestrate-dynamic-workflow assignment, will look for a dynamic workflow file at `./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/new-project.md`.

- Ensure the file contains a "## Script" section with one or more third-level step headings (e.g., "### create-project-and-plan").
- Run the orchestrate-dynamic-workflow assignment with input `<name>`.

### Scripts section

The detailed steps are specified in the "Script" section of the dynamic workflow file. Essentially, you will iterate through each assignment specified in the file, orchestrating and overseeing the work until completion, according to the instructions provided in the "Script" section of the dynamic workflow file.

#### Scripts / Inputs Section

This section lists the input variables provided by the calling process or invocation. It will be passed in by the calling invoker and then should be provided as-is to the invoked workflow assignment.

#### Scripts / Events Section

Dynamic workflows may include an "Events" subsection that defines actions to execute at specific lifecycle points. Events enable context-aware behavior triggered by workflow state changes.

**Standard Event Types**:
- `pre-script-begin`: Runs once before any script steps begin
- `post-script-complete`: Runs once after all script steps complete successfully
- `pre-assignment-begin`: Runs before each assignment in a loop starts
- `post-assignment-completion`: Runs after each assignment in a loop completes
- `on-assignment-failure`: Runs when an assignment fails
- `on-script-failure`: Runs when the entire script fails (for cleanup/rollback)

**Event Execution Requirements**:
1. **Timing**: Events MUST execute at their designated lifecycle point
   - `pre-*` events execute BEFORE the associated action
   - `post-*` events execute AFTER successful completion
   - `on-*-failure` events execute ONLY on failure
2. **Scope**: Events have access to all script variables and outputs
3. **Loop Events**: `pre-assignment-begin` and `post-assignment-completion` execute per iteration
4. **Failure Handling**: Event failure causes workflow failure; failure events should not throw errors
5. **Output Recording**: Record event outputs as `#events.<event-name>` or `#events.<event-name>.$assignment_name`

**Example**:
```markdown
### Events

#### `post-assignment-completion`

`$assignments` = [`create-repository-summary`]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`
```

See [dynamic-workflow-syntax.md](dynamic-workflows/dynamic-workflow-syntax.md#events) for complete event documentation.

## Acceptance Criteria
1. All specified assignments are completed and approved.
2. All specified assignments are completed in the order specified in the dynamic workflow file.
3. All specified assignments are completed according to the instructions in the dynamic workflow file.
4. All acceptance criteria for each specified assignment are met.
5. All directives in the Script section of the dynamic workflow file are executed.
6. **All event scripts (if present) are executed at their designated lifecycle points.**
7. Approval is obtained for the final product.
8. No unresolved items remain at completion; results are documented and cross-linked as appropriate.

## Workflow Templates

All assignments orchestrated through this workflow utilize three standardized templates:

- **BEFORE_STARTING_TEMPLATE.md**: Pre-execution preparation checklist
- **PROGRESS_REPORTING_TEMPLATE.md**: Progress tracking for long-running assignments  
- **ERROR_RECOVERY_TEMPLATE.md**: Systematic error handling procedures

These templates are integrated into assignment files and provide:
- Consistent preparation, tracking, and recovery patterns
- Reduced false starts and thorough issue handling
- Clear progress visibility and status reporting
- Structured error recovery to prevent workflow abandonment

For customization guidance, see: [`docs/TEMPLATE_CUSTOMIZATION_GUIDE.md`](../../docs/TEMPLATE_CUSTOMIZATION_GUIDE.md)

## Guardrails (Authoritative, Non-Optional)
These apply to all dynamic workflows.

- Resolution trace (mandatory before execution)
  - Resolve and print the dereference chain with URLs (and SHAs when available):
    orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → [assignments] → ai-workflow-assignments/<assignment>.md
  - Refuse to proceed if any file in the chain is unreadable.

- Assignment-first execution (no step synthesis)
  - Dynamic workflow files may enumerate assignment names and inputs only.
  - Execute steps strictly from the resolved assignment file(s). Do not infer or invent steps from the dynamic workflow file. Do not choose items with names that are close but not exact matches.

- Acceptance-criteria gating (Definition of Done)
  - Extract the Acceptance Criteria from each assignment file.
  - Treat each criterion as a must-pass gate. Do not declare success unless every criterion passes.
- Template and preflight enforcement
  - If the assignment specifies template/source-of-truth requirements (e.g., create repo from a template, enforce license/visibility, required scripts), enforce them.
  - If the target already exists but violates preconditions, either:
    - Recreate per spec; or
  -  **IF** pre-existing artifcats strictly meet acceptance criteroa and/or instruction, leave them and record a non-creation event.

- Branch protection
  - For code changes: if the default branch is protected, use a feature branch + PR path; do not force-push to protected branches.
  - Non-code changes (e.g., settings, metadata) can be made directly to the default branch, even if protected.

- Run Report (mandatory)
  - Produce a final Run Report mapped 1:1 to each assignment’s Acceptance Criteria with PASS/FAIL and evidence links.

- Run Log
- Maintain a detailed log of actions taken, decisions made, and any issues encountered during execution.
- This log should be included in the final Run Report and debriefing documentfor transparency and auditing purposes.
- Include actions taken at dynamic workflow level (e.g., "Starting assignment X") as well as actions taken at the individual assignment level, and all agent delegation events.

## Execution Algorithm (Deterministic & Idempotent)

1) Intake
- Capture inputs: $workflow_name.
- Resolve and print the resolution trace:
  - dynamic-workflows/$workflow_name.md → list of `$assignments` and `Events` (if present)
  - For each: ai-workflow-assignments/<assignment>.md
- Abort early if any file is missing or unreadable.

1) Plan
- Parse the Script section and identify:
  - Main workflow steps (third-level headings)
  - Events subsection (if present) with lifecycle hooks
- For each assignment:
  - Parse Inputs, Detailed Steps, and Acceptance Criteria from the assignment file.
  - Expand steps into concrete actions and checks for the current environment (permissions, branch protection, etc.).
  - Decide direct-to-default-branch vs. feature-branch+PR route.
- For each event (if present):
  - Identify event type and execution trigger
  - Parse event script and referenced assignments

1) Execute (per main script step, in order)
- **If `pre-script-begin` event exists, execute it first**
- For each main workflow step:
  - **If `pre-assignment-begin` event exists and step contains loops, execute before each iteration**
  - Perform the Detailed Steps exactly as written in the assignment file
  - Honor preflight requirements (templates, scripts, visibility, licenses) before continuing
  - If a required step cannot be executed (e.g., missing permission), trigger `on-assignment-failure` event (if present), then stop and report
  - Do not continue performing any later step until you have successfully finished the current step, and all previous steps
  - **If `post-assignment-completion` event exists and step contains loops, execute after each iteration**
- **If all steps succeed and `post-script-complete` event exists, execute it**
- **If any step fails and `on-script-failure` event exists, execute it for cleanup/rollback**

1) Verify (Gated)
- Evaluate each Acceptance Criterion (including event execution criteria).
- Record PASS/FAIL with evidence (links to repos, files, PRs, issues, projects, event outputs, etc.).
- If any FAIL, stop and report the unmet criteria and remediation options.

1) Report
- Produce a Run Report (schema below) including the resolution trace, actions performed, event executions, and the acceptance-gated results.

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
  - Inputs: $workflow_name (summarized)
- Resolution Trace
  - Ordered list of files used with URLs (and SHAs if available)
  - Events section (if present in workflow)
- Actions Executed
  - For each assignment, list the key actions performed (mirroring Detailed Steps)
  - **For each event executed, list the trigger point and actions performed**
- Acceptance Criteria Results
  - For each assignment, list each criterion with PASS/FAIL and evidence links
  - **For event execution: PASS if all events executed at correct lifecycle points**
- Deviations
  - Any variance from assignment specs (e.g., explicitly pre-approved deviations), with rationale and authorizing party's name
- Outcome
  - Success only if all Acceptance Criteria are PASS (or explicitly approved deviations)

## Dynamic Workflow File Conventions (Reference)
- Dynamic workflow files reside under ai-workflow-assignments/dynamic-workflows.
- They provide the Script section which enumerates assignment names and inputs.
- They do not define executable steps; steps are defined in the referenced assignment files.
- Canonical syntax reference: [dynamic-workflow-syntax.md](dynamic-workflows/dynamic-workflow-syntax.md)

## How to Run (Quick Start)
1. Place your workflow file under ai-workflow-assignments/dynamic-workflows/<name>.md.
2. Ensure the file contains a "## Script" section that enumerates assignment short IDs and inputs.
3. Invoke this orchestrator with input: $workflow_name=<name>.
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
- Respect branch protection (use feature branch + PR) for code changes.
- Non-code changes (e.g., settings, metadata) can be made directly to the default branch, even if protected..

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
