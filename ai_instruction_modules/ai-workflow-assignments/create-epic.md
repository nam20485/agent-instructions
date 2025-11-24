---
description: Create an epic sub-issue for a plan phase
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a single epic sub-issue for a specific phase from the main application plan.</goal>
    <input>
      <parameter name="phase">Phase object from parent plan</parameter>
    </input>
    <output>Created epic issue object</output>
  </overview>

  <acceptance_criteria>
    <criterion>Epic issue created using template.</criterion>
    <criterion>Epic title follows format.</criterion>
    <criterion>Complete breakdown of stories and tasks.</criterion>
    <criterion>Mandatory requirements completed.</criterion>
    <criterion>Epic linked as sub-issue to parent plan.</criterion>
    <criterion>Epic added to Project and Milestone.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Review Input</title>
      <actions>
        <action>Analyze phase requirements and goals.</action>
        <action>Review tech stack and architecture.</action>
      </actions>
    </step>

    <step number="2">
      <title>Analyze Requirements</title>
      <actions>
        <action>Extract features and dependencies.</action>
        <action>Clarify ambiguities.</action>
      </actions>
    </step>

    <step number="3">
      <title>Break Down Phase</title>
      <actions>
        <action>Divide phase into logical stories.</action>
        <action>Identify sub-tasks with deliverables.</action>
        <action>Include mandatory requirements.</action>
      </actions>
    </step>

    <step number="4">
      <title>Create Epic</title>
      <actions>
        <action>Use `.github/ISSUE_TEMPLATE/epic.md`.</action>
        <action>Fill all sections (Overview, Stories, Implementation Plan, etc.).</action>
      </actions>
    </step>

    <step number="5">
      <title>Link to Plan</title>
      <actions>
        <action>Follow <procedure ref="github-management.issue-linking"/> to link issue to Project and Milestone.</action>
        <action>Link as sub-issue to parent plan.</action>
        <action>Mark as blocking parent issue.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify template completion.</step>
    <step>Confirm detailed sub-tasks.</step>
    <step>Return epic object.</step>
  </validation>
</instructions>
