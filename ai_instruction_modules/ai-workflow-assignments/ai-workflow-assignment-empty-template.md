---
description: Template for creating new workflow assignments
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>[Clear, concise statement of what this assignment accomplishes]</goal>
    <context>[Optional: When and why this assignment is used]</context>
  </overview>

  <prerequisites>
    <item>[Prerequisite 1]</item>
    <item>[Prerequisite 2]</item>
    <note>For gh project/repo permissions, see `scripts/test-github-permissions.ps1` and `scripts/gh-auth.ps1`.</note>
  </prerequisites>

  <acceptance_criteria>
    <criterion>[Criterion 1 - specific, measurable]</criterion>
    <criterion>[Criterion 2 - specific, measurable]</criterion>
    <criterion>[Criterion 3 - specific, measurable]</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>[Step 1 Title]</title>
      <description>[Description of step 1]</description>
      <actions>
        <action>[Action 1]</action>
        <action>[Action 2]</action>
      </actions>
    </step>

    <step number="2">
      <title>[Step 2 Title]</title>
      <description>[Description of step 2]</description>
      <actions>
        <action>[Action 1]</action>
        <action>[Action 2]</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify [Assignment Name] is Complete</step>
    <step>Present to Stakeholder</step>
    <step>Stakeholder Review Process</step>
    <step>Finalization (Commit, Mark Complete)</step>
  </validation>

  <notes>
    <note>[Important note 1]</note>
    <note>[Important note 2]</note>
  </notes>
</instructions>
