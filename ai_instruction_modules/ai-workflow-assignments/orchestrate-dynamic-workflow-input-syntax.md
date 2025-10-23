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