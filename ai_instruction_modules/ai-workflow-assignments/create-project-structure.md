---
description: Create project structure and scaffolding
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create the actual project structure and scaffolding for a new application based on a comprehensive application plan.</goal>
    <prerequisites>
      <item>Complete application plan.</item>
      <item>Application template and supporting docs.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Solution structure created.</criterion>
    <criterion>Project files and directories established.</criterion>
    <criterion>Initial config files created.</criterion>
    <criterion>CI/CD pipeline structure established.</criterion>
    <criterion>Documentation structure created.</criterion>
    <criterion>Dev environment configured.</criterion>
    <criterion>Repository summary created.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Solution Structure</title>
      <actions>
        <action>Create solution file.</action>
        <action>Set up global.json.</action>
        <action>Create project directories and files.</action>
        <action>Configure references and settings.</action>
      </actions>
    </step>

    <step number="2">
      <title>Infrastructure</title>
      <actions>
        <action>Create Dockerfiles and docker-compose.yml.</action>
        <action>Set up config files (appsettings.json, .env).</action>
      </actions>
    </step>

    <step number="3">
      <title>Dev Environment</title>
      <actions>
        <action>Create setup scripts.</action>
        <action>Configure DB and tools.</action>
        <action>Create test project structure.</action>
      </actions>
    </step>

    <step number="4">
      <title>Documentation</title>
      <actions>
        <action>Create README.md and docs directory.</action>
        <action>Set up API docs and ADRs.</action>
      </actions>
    </step>

    <step number="5">
      <title>CI/CD</title>
      <actions>
        <action>Create .github/workflows.</action>
        <action>Set up build and quality workflows.</action>
      </actions>
    </step>

    <step number="6">
      <title>Validation & Summary</title>
      <actions>
        <action>Verify solution builds.</action>
        <action>Validate Docker and dev env.</action>
        <action>Create repository summary (`.ai-repository-summary.md`).</action>
      </actions>
    </step>

    <step number="7">
      <title>Finalize</title>
      <actions>
        <action>Make initial commit.</action>
        <action>Create project status docs.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Present structure to stakeholder.</step>
    <step>Verify build and configuration.</step>
    <step>Obtain approval.</step>
  </validation>
</instructions>
