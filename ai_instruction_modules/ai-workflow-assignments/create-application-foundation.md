---
description: Set up foundational project files and configuration
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Set up the foundational project files, dependency management, and build configuration for any application type.</goal>
    <prerequisites>
      <item>Complete application plan.</item>
      <item>Application template and supporting docs.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Project initialized with git.</criterion>
    <criterion>Dependency manifest created and functional.</criterion>
    <criterion>Build system configured and working.</criterion>
    <criterion>Code quality tools configured and passing.</criterion>
    <criterion>Directory structure created.</criterion>
    <criterion>Environment configuration documented.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Initialize Project</title>
      <actions>
        <action>Create root directory.</action>
        <action>Initialize git and create .gitignore.</action>
        <action>Create README.md.</action>
      </actions>
    </step>

    <step number="2">
      <title>Dependency Management</title>
      <actions>
        <action>Create manifest (package.json, requirements.txt, etc.).</action>
        <action>Define core and dev dependencies.</action>
        <action>Lock versions and install.</action>
      </actions>
    </step>

    <step number="3">
      <title>Build System</title>
      <actions>
        <action>Configure build tool (vite, setup.py, etc.).</action>
        <action>Configure compilation/transpilation.</action>
        <action>Configure output directories.</action>
        <action>Test build.</action>
      </actions>
    </step>

    <step number="4">
      <title>Code Quality</title>
      <actions>
        <action>Configure linter (eslint, pylint, etc.).</action>
        <action>Configure formatter (prettier, black, etc.).</action>
        <action>Set up pre-commit hooks and type checking.</action>
        <action>Test tools on empty project.</action>
      </actions>
    </step>

    <step number="5">
      <title>Directory Structure</title>
      <actions>
        <action>Create source directory (src/, lib/, etc.).</action>
        <action>Create assets, docs, config, test directories.</action>
      </actions>
    </step>

    <step number="6">
      <title>Environment Config</title>
      <actions>
        <action>Create .env.example.</action>
        <action>Document environment variables.</action>
        <action>Set up config loading mechanism.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify dependencies install.</step>
    <step>Verify build works.</step>
    <step>Verify linter/formatter pass.</step>
    <step>Present to stakeholder for approval.</step>
  </validation>
</instructions>
