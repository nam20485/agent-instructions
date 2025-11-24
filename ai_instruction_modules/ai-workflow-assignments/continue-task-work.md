---
description: Resume and complete previously started tasks
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Identify and complete tasks that have been previously started but remain incomplete.</goal>
    <input>
      <parameter name="repository">Git repository</parameter>
      <parameter name="issues">List of issues</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>Incomplete tasks identified and prioritized.</criterion>
    <criterion>Most appropriate task selected.</criterion>
    <criterion>Task resumed from correct point and completed.</criterion>
    <criterion>All related issues/branches updated.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Discovery & Assessment</title>
      <actions>
        <action>Check issues with `state:in-progress` or assigned to copilot.</action>
        <action>Review open PRs and local branches.</action>
        <action>Analyze current state of identified tasks.</action>
      </actions>
    </step>

    <step number="2">
      <title>Prioritization</title>
      <actions>
        <action>Select task based on priority, proximity to completion, and dependencies.</action>
      </actions>
    </step>

    <step number="3">
      <title>Setup</title>
      <actions>
        <action>Checkout correct branch.</action>
        <action>Pull remote changes and resolve conflicts.</action>
        <action>Review issue to determine resumption point.</action>
      </actions>
    </step>

    <step number="4">
      <title>Execution</title>
      <actions>
        <action>Complete remaining items in issue checklist.</action>
        <action>Follow coding standards.</action>
        <action>Test thoroughly.</action>
      </actions>
    </step>

    <step number="5">
      <title>Integration</title>
      <actions>
        <action>Ensure integration with existing codebase.</action>
        <action>Run comprehensive tests.</action>
        <action>Update documentation.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Update issue with final summary.</step>
    <step>Remove `state:in-progress` label.</step>
    <step>Create/Update PR and link to issue.</step>
    <step>Notify stakeholders.</step>
  </validation>
</instructions>
