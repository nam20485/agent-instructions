---
description: Create a new application from a plan issue (unguided version)
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a new application based on a filled-out application template and development plan issue.</goal>
    <input>
      <parameter name="repository">Initialized git repository</parameter>
      <parameter name="template">Filled-out application template</parameter>
      <parameter name="plan">Filled-out development plan issue</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>Application template analyzed and understood.</criterion>
    <criterion>Project structure created according to plan.</criterion>
    <criterion>All mandatory requirements addressed (testing, docs, containerization).</criterion>
    <criterion>Application builds and runs successfully.</criterion>
    <criterion>Code quality standards met.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis</title>
      <actions>
        <action>Analyze application template and plan issue.</action>
        <action>Understand requirements and constraints.</action>
      </actions>
    </step>

    <step number="2">
      <title>Implementation</title>
      <actions>
        <action>Implement application as per the development plan issue.</action>
        <action>Follow the plan exactly as specified.</action>
      </actions>
    </step>

    <step number="3">
      <title>Review</title>
      <actions>
        <action>Conduct final testing.</action>
        <action>Verify mandatory requirements (testing, docs, docker, CI/CD).</action>
        <action>Ensure code quality.</action>
      </actions>
    </step>

    <step number="4">
      <title>Handoff</title>
      <actions>
        <action>Complete documentation (README, API docs).</action>
        <action>Demonstrate to stakeholders.</action>
        <action>Finalize repository.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify all acceptance criteria are met.</step>
    <step>Obtain stakeholder sign-off.</step>
  </validation>
</instructions>
