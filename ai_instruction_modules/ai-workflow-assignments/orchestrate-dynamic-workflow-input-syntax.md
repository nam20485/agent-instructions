---
description: Reference for passing inputs to dynamic workflows
scope: reference
role: System Orchestrator
---

<instructions role="assistant" scope="reference">
  <overview>
    <goal>Provide examples and syntax for passing inputs to dynamic workflows via the orchestrator.</goal>
  </overview>

  <examples>
    <example title="Direct parameter passing">
      <code language="markdown">
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `update-from-feedback`
  - $assignment_inputs = { directory: `./debriefs` }
      </code>
    </example>

    <example title="Using command arguments">
      <code language="markdown">
/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `$ARGUMENTS[0]`
  - $assignment_inputs = `$ARGUMENTS[1]`
      </code>
    </example>

    <example title="Workflow with multiple inputs">
      <code language="markdown">
/orchestrate-dynamic-workflow
  - $workflow_name = `implement-epic`
  - $epic = 42
  - $repository = `myorg/myrepo`
  - $parallel_execution = `false`
      </code>
    </example>
  </examples>

  <guidance>
    <item>Orchestrator extracts all parameters (except `$workflow_name`) as inputs.</item>
    <item>Inputs can be passed as individual parameters or structured objects.</item>
    <item>Command wrappers can simplify invocation.</item>
  </guidance>

  <prompt_guidance>
    <preamble>
Before execution:
- Print resolution trace.
- Refuse if files unreadable.

Execution rules:
- Use resolved assignment files only.
- Enforce Acceptance Criteria as gates.
- Respect branch protection.

Completion:
- Produce Run Report with trace, actions, AC results, and outcome.
    </preamble>
  </prompt_guidance>
</instructions>
