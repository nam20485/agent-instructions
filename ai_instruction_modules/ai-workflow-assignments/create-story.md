---
description: Create a single story sub-issue from an epic
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a single story sub-issue from an epic issue, representing a granular, executable task.</goal>
    <input>
      <parameter name="story">Story object with name, description, requirements</parameter>
    </input>
    <output>Created story issue object</output>
  </overview>

  <acceptance_criteria>
    <criterion>Story issue created using template.</criterion>
    <criterion>Story title follows format: `Story: <name>`.</criterion>
    <criterion>Objective and scope clearly defined.</criterion>
    <criterion>Detailed plan with checkboxed tasks provided.</criterion>
    <criterion>Acceptance criteria specific and measurable.</criterion>
    <criterion>Validation commands included.</criterion>
    <criterion>Story linked as sub-issue to parent epic.</criterion>
    <criterion>Story added to Project and Milestone.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Review Input</title>
      <actions>
        <action>Extract story details and parent epic context.</action>
        <action>Understand objectives and constraints.</action>
      </actions>
    </step>

    <step number="2">
      <title>Analyze Requirements</title>
      <actions>
        <action>Identify technical approach and dependencies.</action>
        <action>Determine validation criteria.</action>
      </actions>
    </step>

    <step number="3">
      <title>Break Down Tasks</title>
      <actions>
        <action>Divide story into actionable tasks (3-8 items).</action>
        <action>Ensure logical sequence and testability.</action>
      </actions>
    </step>

    <step number="4">
      <title>Create Story Issue</title>
      <actions>
        <action>Use `.github/ISSUE_TEMPLATE/story.md`.</action>
        <action>Fill all sections (Objective, Scope, Plan, AC, Validation, etc.).</action>
      </actions>
    </step>

    <step number="5">
      <title>Link and Track</title>
      <actions>
        <action>Create issue and link to Project.</action>
        <action>Link as sub-issue to parent epic.</action>
        <action>Link to milestone.</action>
        <action>Mark as blocking parent epic.</action>
        <action>Apply labels.</action>
      </actions>
    </step>

    <step number="6">
      <title>Quality Validation</title>
      <actions>
        <action>Verify template completion.</action>
        <action>Confirm task specificity and AC measurability.</action>
        <action>Validate dependencies and rollback guidance.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Confirm story is linked as sub-issue.</step>
    <step>Verify milestone assignment.</step>
    <step>Ensure no implementation code was written.</step>
    <step>Return story object.</step>
  </validation>
</instructions>
