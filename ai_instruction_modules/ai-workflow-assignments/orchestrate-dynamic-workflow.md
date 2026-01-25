---
description: Orchestrate a dynamic workflow from a definition file
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Orchestrate a workflow by iterating through assignments specified in a dynamic workflow file.</goal>
    <input>
      <parameter name="workflow_name">Name of the dynamic workflow file</parameter>
      <parameter name="inputs">Additional inputs for the workflow</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>All specified assignments completed and approved.</criterion>
    <criterion>Assignments completed in specified order.</criterion>
    <criterion>Directives in Script section executed.</criterion>
    <criterion>Acceptance criteria for each assignment met.</criterion>
    <criterion>Event handlers executed at designated points.</criterion>
    <criterion>Run Report produced with resolution trace and results.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Intake & Plan</title>
      <actions>
        <action>Resolve workflow file and assignment chain.</action>
        <action>Produce a resolution trace listing the workflow file and each assignment file (raw URL or local path).</action>
        <action>Parse Script section and Events.</action>
        <action>Validate inputs and permissions.</action>
      </actions>
    </step>

    <step number="2">
      <title>Execute Workflow</title>
      <actions>
        <action>Execute `pre-script-begin` event (if present).</action>
        <action>Iterate through main workflow steps.</action>
        <action>For each assignment in the Script: execute `pre-assignment-begin`, assign and wait for completion, review and approve, record output, then execute `post-assignment-complete`.</action>
        <action>On assignment failure (non-zero exit, timeout, or failed acceptance criteria), execute `on-assignment-failure` and halt.</action>
        <action>Execute `post-script-complete` event.</action>
      </actions>
    </step>

    <step number="3">
      <title>Verify & Report</title>
      <actions>
        <action>Evaluate Acceptance Criteria for all assignments.</action>
        <action>Record PASS/FAIL with evidence.</action>
        <action>Produce Run Report with resolution trace, per-assignment status, event execution log, and evidence for each acceptance criterion.</action>
      </actions>
    </step>
  </workflow>

  <guardrails>
    <rule>Resolution trace mandatory before execution.</rule>
    <rule>Execute steps strictly from assignment files (no synthesis).</rule>
    <rule>Acceptance Criteria are non-negotiable gates.</rule>
    <rule>Event handlers resolve to assignment files in `ai-workflow-assignments/<short-id>.md`; missing handlers halt the workflow and report.</rule>
    <rule>Enforce template and preflight requirements.</rule>
    <rule>Respect branch protection (PRs for code).</rule>
  </guardrails>

  <validation>
    <step>Verify all assignments passed.</step>
    <step>Verify Run Report completeness.</step>
    <step>Notify user of completion.</step>
  </validation>
</instructions>
