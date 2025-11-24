---
description: Transform a high-level story bullet into a fully scoped story sub-issue
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Transform a high-level story bullet from a parent epic into its own story sub-issue, inheriting context while expanding into a fully scoped, executable work item.</goal>
    <input>
      <parameter name="epic">Epic issue object</parameter>
      <parameter name="story">Story bullet object</parameter>
    </input>
    <output>Created story issue object</output>
  </overview>

  <acceptance_criteria>
    <criterion>Story issue created using template.</criterion>
    <criterion>Story title follows format: `Story: <name> (<epic_id>: #<number>)`.</criterion>
    <criterion>Objective and scope clearly defined.</criterion>
    <criterion>Implementation plan preserves checkbox hierarchy.</criterion>
    <criterion>Acceptance criteria specific and measurable.</criterion>
    <criterion>Validation commands included.</criterion>
    <criterion>Dependencies, risks, and test strategy defined.</criterion>
    <criterion>Story linked as sub-issue to parent epic.</criterion>
    <criterion>Story added to Project and Milestone.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Review Inputs</title>
      <actions>
        <action>Extract epic metadata and context.</action>
        <action>Analyze story bullet requirements.</action>
      </actions>
    </step>

    <step number="2">
      <title>Analyze Requirements</title>
      <actions>
        <action>Determine technical approach and integrations.</action>
        <action>Identify dependencies and prerequisites.</action>
        <action>Capture validation expectations.</action>
      </actions>
    </step>

    <step number="3">
      <title>Transform to Plan</title>
      <actions>
        <action>Expand story bullet into actionable tasks.</action>
        <action>Ensure sequencing supports iterative delivery.</action>
        <action>Map tasks to acceptance criteria.</action>
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
        <action>Confirm plan detail and AC measurability.</action>
        <action>Validate dependencies and rollback guidance.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Confirm story is linked as sub-issue.</step>
    <step>Verify milestone and project assignment.</step>
    <step>Ensure no implementation code was written.</step>
    <step>Return story object.</step>
  </validation>
</instructions>
