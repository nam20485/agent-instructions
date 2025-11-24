---
description: Transform a plan line item into an epic sub-issue
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Transform a single task-list line item from a parent application plan into its own epic sub-issue.</goal>
    <input>
      <parameter name="phase">Phase object from parent plan</parameter>
      <parameter name="line_item">Line item object from parent plan</parameter>
    </input>
    <output>Created epic issue object</output>
  </overview>

  <acceptance_criteria>
    <criterion>Epic issue created using template.</criterion>
    <criterion>Epic title follows format.</criterion>
    <criterion>Checkbox-driven task list preserved.</criterion>
    <criterion>High-level story bullets included.</criterion>
    <criterion>Mandatory requirements completed.</criterion>
    <criterion>Epic linked as sub-issue to parent plan.</criterion>
    <criterion>Epic added to Project and Milestone.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Review Input</title>
      <actions>
        <action>Analyze phase and line item requirements.</action>
        <action>Understand tech stack and architecture.</action>
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
      <title>Transform Task List</title>
      <actions>
        <action>Extract checkbox tasks from line item.</action>
        <action>Convert to Implementation Plan in epic.</action>
      </actions>
    </step>

    <step number="4">
      <title>Outline Stories</title>
      <actions>
        <action>Draft high-level story bullets.</action>
        <action>Ensure logical sequence.</action>
      </actions>
    </step>

    <step number="5">
      <title>Create Epic</title>
      <actions>
        <action>Use `.github/ISSUE_TEMPLATE/epic.md`.</action>
        <action>Fill all sections (Overview, Tech Stack, Stories, etc.).</action>
      </actions>
    </step>

    <step number="6">
      <title>Link to Plan</title>
      <actions>
        <action>Create issue and link to Project.</action>
        <action>Link as sub-issue to parent plan.</action>
        <action>Link to milestone.</action>
        <action>Mark as blocking parent issue.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify template completion.</step>
    <step>Confirm task list preservation.</step>
    <step>Return epic object.</step>
  </validation>
</instructions>
