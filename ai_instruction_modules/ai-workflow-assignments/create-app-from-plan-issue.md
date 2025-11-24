---
description: Create a new application from a plan issue with detailed guidance
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a new application based on a filled-out application template and development plan issue, with detailed implementation steps.</goal>
    <input>
      <parameter name="repository">Initialized git repository</parameter>
      <parameter name="template">Filled-out application template</parameter>
      <parameter name="plan">Filled-out development plan issue</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>Application template analyzed and understood.</criterion>
    <criterion>Project structure created according to plan.</criterion>
    <criterion>All mandatory requirements implemented (testing, docs, containerization).</criterion>
    <criterion>Application builds and runs successfully.</criterion>
    <criterion>Code quality standards met.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Setup</title>
      <actions>
        <action>Initialize Git repo.</action>
        <action>Review application template and plan issue.</action>
        <action>Create project structure.</action>
      </actions>
    </step>

    <step number="2">
      <title>Technology Stack Implementation</title>
      <actions>
        <action>Implement backend services.</action>
        <action>Set up frontend.</action>
        <action>Configure dependency injection and data access.</action>
        <action>Set up authentication/authorization.</action>
        <action>Configure logging.</action>
      </actions>
    </step>

    <step number="3">
      <title>Core Functionality</title>
      <actions>
        <action>Implement business logic and features.</action>
        <action>Create controllers, services, models.</action>
        <action>Implement data persistence.</action>
        <action>Add validation and error handling.</action>
      </actions>
    </step>

    <step number="4">
      <title>Testing</title>
      <actions>
        <action>Create unit and integration tests.</action>
        <action>Ensure substantial coverage (>80%).</action>
        <action>Set up automated test execution.</action>
      </actions>
    </step>

    <step number="5">
      <title>Documentation & API</title>
      <actions>
        <action>Implement Swagger/OpenAPI docs.</action>
        <action>Create README and usage guides.</action>
        <action>Document configuration and deployment.</action>
      </actions>
    </step>

    <step number="6">
      <title>Containerization & CI/CD</title>
      <actions>
        <action>Create Docker images and Compose setup.</action>
        <action>Create GitHub Actions workflows.</action>
        <action>Configure deployment scripts.</action>
      </actions>
    </step>

    <step number="7">
      <title>QA & Validation</title>
      <actions>
        <action>Perform comprehensive testing.</action>
        <action>Validate against requirements.</action>
        <action>Verify security and performance.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Conduct final application review.</step>
    <step>Complete documentation and handoff.</step>
    <step>Demonstrate to stakeholders and get sign-off.</step>
    <step>Finalize repository (commit, tag, cleanup).</step>
  </validation>
</instructions>
