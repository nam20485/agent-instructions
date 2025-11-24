---
description: Create a new application from a filled-out template
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a new application based on a filled-out application template, including project structure, configuration, and requirements.</goal>
    <input>
      <parameter name="repository">Git repository</parameter>
      <parameter name="template">Filled-out application template</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>Application template analyzed.</criterion>
    <criterion>Project structure created according to plan.</criterion>
    <criterion>Plan documented in issue using Appendix A template.</criterion>
    <criterion>Epic sub-issues created for each phase.</criterion>
    <criterion>Mandatory requirements implemented (testing, docs, containerization).</criterion>
    <criterion>Application builds and runs successfully.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis</title>
      <actions>
        <action>Review application template and requirements.</action>
        <action>Understand tech stack and deployment targets.</action>
      </actions>
    </step>

    <step number="2">
      <title>Planning</title>
      <actions>
        <action>Create implementation plan.</action>
        <action>Design architecture and project structure.</action>
        <action>Get stakeholder approval.</action>
      </actions>
    </step>

    <step number="3">
      <title>Setup</title>
      <actions>
        <action>Create repository structure.</action>
        <action>Configure dev environment and tooling.</action>
        <action>Set up version control.</action>
      </actions>
    </step>

    <step number="4">
      <title>Implementation</title>
      <actions>
        <action>Implement backend and frontend.</action>
        <action>Configure DI, data access, auth, logging.</action>
        <action>Implement core functionality.</action>
      </actions>
    </step>

    <step number="5">
      <title>Testing</title>
      <actions>
        <action>Implement unit and integration tests.</action>
        <action>Ensure >80% coverage.</action>
      </actions>
    </step>

    <step number="6">
      <title>Documentation & Deployment</title>
      <actions>
        <action>Create API docs and README.</action>
        <action>Containerize application.</action>
        <action>Set up CI/CD pipelines.</action>
      </actions>
    </step>

    <step number="7">
      <title>QA</title>
      <actions>
        <action>Validate requirements and security.</action>
        <action>Test deployment.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Conduct final review and testing.</step>
    <step>Complete documentation and handoff.</step>
    <step>Obtain stakeholder sign-off.</step>
  </validation>
</instructions>
