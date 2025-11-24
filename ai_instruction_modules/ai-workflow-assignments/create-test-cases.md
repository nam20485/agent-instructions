---
description: Create automated test cases to increase coverage
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create automated test cases (unit and integration) to significantly increase test coverage for assigned projects.</goal>
    <context>Iterative process until told to stop.</context>
  </overview>

  <acceptance_criteria>
    <criterion>Total test coverage increased by 50%.</criterion>
    <criterion>Test projects created for each code project.</criterion>
    <criterion>All projects build and run successfully.</criterion>
    <criterion>All test cases pass 100%.</criterion>
    <criterion>Automated test pipeline integrated.</criterion>
    <criterion>Test coverage reports generated.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis & Planning</title>
      <actions>
        <action>Analyze existing projects and coverage.</action>
        <action>Create issue documenting coverage plan.</action>
        <action>Obtain approval for plan.</action>
      </actions>
    </step>

    <step number="2">
      <title>Setup</title>
      <actions>
        <action>Create branch.</action>
        <action>Create test projects if missing.</action>
        <action>Install coverage tools.</action>
      </actions>
    </step>

    <step number="3">
      <title>Implementation</title>
      <actions>
        <action>Implement unit and integration tests.</action>
        <action>Target low coverage areas first.</action>
        <action>Ensure tests pass.</action>
      </actions>
    </step>

    <step number="4">
      <title>Pipeline Integration</title>
      <actions>
        <action>Add/update automated test pipeline.</action>
        <action>Ensure coverage reports are generated.</action>
      </actions>
    </step>

    <step number="5">
      <title>Completion</title>
      <actions>
        <action>Verify coverage increase.</action>
        <action>Merge PR upon approval.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify all tests pass.</step>
    <step>Verify coverage metrics.</step>
    <step>Obtain stakeholder approval.</step>
  </validation>
</instructions>
