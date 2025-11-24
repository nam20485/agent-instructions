---
description: Set up containerization, CI/CD, and deployment infrastructure
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Set up containerization, CI/CD, and deployment infrastructure to automate building, testing, and deploying the application.</goal>
    <prerequisites>
      <item>Application Foundation completed.</item>
      <item>Application Structure completed.</item>
      <item>Testing Infrastructure completed.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Container builds successfully (if applicable).</criterion>
    <criterion>docker-compose works for local dev.</criterion>
    <criterion>CI/CD workflows created and passing.</criterion>
    <criterion>Deployment scripts functional.</criterion>
    <criterion>DEPLOYMENT.md created.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Containerization</title>
      <actions>
        <action>Create Dockerfile (multi-stage).</action>
        <action>Create .dockerignore.</action>
        <action>Create docker-compose.yml.</action>
        <action>Test containerization.</action>
      </actions>
    </step>

    <step number="2">
      <title>CI/CD Workflows</title>
      <actions>
        <action>Create CI config (GitHub Actions, GitLab CI, etc.).</action>
        <action>Configure automated testing and coverage.</action>
        <action>Configure code quality checks.</action>
        <action>Configure build verification.</action>
      </actions>
    </step>

    <step number="3">
      <title>Deployment</title>
      <actions>
        <action>Configure deployment steps and conditions.</action>
        <action>Set up secrets.</action>
        <action>Create deployment and rollback scripts.</action>
        <action>Create IaC templates (if applicable).</action>
      </actions>
    </step>

    <step number="4">
      <title>Setup Scripts</title>
      <actions>
        <action>Create dev environment setup scripts.</action>
        <action>Create installation verification scripts.</action>
      </actions>
    </step>

    <step number="5">
      <title>Documentation</title>
      <actions>
        <action>Create DEPLOYMENT.md.</action>
        <action>Document process, rollback, requirements.</action>
        <action>Add status badges to README.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify CI/CD pipeline runs.</step>
    <step>Verify build and tests pass.</step>
    <step>Verify deployment works.</step>
    <step>Present to stakeholder for approval.</step>
  </validation>
</instructions>
