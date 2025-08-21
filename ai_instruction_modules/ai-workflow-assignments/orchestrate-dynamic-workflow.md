# Assignment: Orchestrate Dynamic Workflow

## (orchestrate-dynamic-workflow)

### Overview

The dynamic workflow orchestration assignment is different than the other static workflow assignments, in that it must orchestrate the workflows for a dynamically specified list of workflow assignments, as specified in a dynamic workflow file. The dynamic workflow file specifies assignments to be performed in the "Script" section of the file.

### Goal

Your goal is to orchestrate systematically through the assignments as specified in the provided dynamic workflow file's "Script" section, performing the steps in each one to completion in turn. Assignments are specified by short ID.

### Acceptance Criteria

1. All specified assignments are completed and approved.
2. All specified assignments are completed in the order specified in the file.
3. All specified assignments are completed according to the instructions given in the dynamic workflow file.
4. All acceptance criteria for each specified assignment are met.
5. All directives in the "Script" section of the dynamic workflow file are executed.
6. Approval is obtained for the final product.
7. No unresolved items remain at completion; results are documented and cross-linked as appropriate.

### Assignment

Your assignment is to orchestrate the workflow assignment as specified by name and instructions in the provided dynamic workflow file. This involves systematically iterating through each specified assignment, orchestrating and overseeing the work until completion, according to the instructions specified in the "Script" section in the dynamic workflow file.

#### Dynamic Workflow File Conventions

- The list of sub-workflow assignments resides in a file whose name is provided as input to this assignment.
- The name provided indicates a dynamic workflow file located in the [./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows](./dynamic-workflows) directory.
- The format for naming the dynamic workflow files may be standardized; see repository conventions.

> Example: Specifying "new-project" as input, when invoking the orchestrate-dynamic-workflow assignment, will look for a dynamic workflow file at `./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/new-project.md`.

##### Syntax reference (canonical)

See the canonical syntax: [dynamic-workflow-synatx.md](./dynamic-workflows/dynamic-workflow-synatx.md)

Highlights:
- Backticks for assignment short IDs and step identifiers (e.g., `perform-task`); single quotes for free-form strings; no quotes for variables/keywords.
- Output recording convention for loops: record as `#<step>.<assignmentShortId>` so later references like `#create-project-and-plan.create-app-plan` resolve.

### Detailed Steps

The detailed steps are specified in the "Script" section of the dynamic workflow file. Essentially, you will iterate through each assignment specified in the file, orchestrating and overseeing the work until completion, according to the instructions provided in the "Script" section of the dynamic workflow file.

### How to Run (Quick Start)

1. Place your workflow file under `./ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/<name>.md`.
2. Ensure the file contains a "## Script" section with one or more third-level step headings (e.g., "### create-project-and-plan").
3. Run the orchestrate-dynamic-workflow assignment with input `<name>`.
4. Monitor progress, approve each step upon review, and proceed to the next until completion.

Related:
- Validate first: [validate-dynamic-workflow-script](./validate-dynamic-workflow-script.md)

### Dry Run (Plan → Emit)

To preview what would execute without performing any actions, use dry-run:

- Inputs: `--workflow <name>` or `--file <path>`, optional `--fixtures <file.json>`, `--log <path>`, `--strict`
- Behavior: Parses and plans the workflow (variables, loops, functions) and emits a JSONL log of the actions instead of executing
- Output: One action per line in JSONL with fields like `type`, `step`, `action`, `outputKey` (for assignments), `args`/`simulatedOutput` (for functions), and `timestamp`
- Console logging: add `--console` (or `--verbose`) to also print actions/warnings to the console while writing the JSONL file

Real execution
- Even without real executors wired, the runner emits start/end events for planned actions to the same JSONL file (and console if enabled). This ensures consistent logging in both modes. When executors are added later, they will plug into these events.

Example commands:
- pnpm run orchestrate:dry  (uses the `sample-minimal` workflow)
- node ./scripts/orchestrator.mjs --dry-run --workflow new-project --fixtures fixtures/new-project.json --strict

Fixtures format example:
```json
{
	"get-sub-issues-from-previous-step": {
		"#create-project-and-plan.create-app-plan": ["issue-101", "issue-102"],
		"*": []
	}
}
```

Notes:
- With `--strict`, missing fixtures for required function outputs will error instead of warn
- Output recording convention is applied for looped assignments as documented in the Legend

### Completion

After all steps have been completed, notify the user that the workflow is complete and obtain approval. Upon obtaining approval, the workflow is complete and the orchestrator's assignment is finished.
