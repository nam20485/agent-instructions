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