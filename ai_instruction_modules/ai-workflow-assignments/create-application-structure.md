---
description: Create core application structure and architectural components
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create the core application structure, entry points, and primary architectural components.</goal>
    <prerequisites>
      <item>Application Foundation completed.</item>
      <item>Application plan with defined architecture.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Application entry point created and runs.</criterion>
    <criterion>Core directory structure established.</criterion>
    <criterion>Configuration management working.</criterion>
    <criterion>Common utilities created.</criterion>
    <criterion>Application starts/stops gracefully.</criterion>
    <criterion>Health endpoints functional.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Entry Point</title>
      <actions>
        <action>Create main application file.</action>
        <action>Set up initialization (logging, config, DI).</action>
        <action>Configure error handling.</action>
        <action>Test entry point.</action>
      </actions>
    </step>

    <step number="2">
      <title>Core Structure</title>
      <actions>
        <action>Organize code by architecture (MVC, Clean, etc.).</action>
        <action>Create directories and index files.</action>
      </actions>
    </step>

    <step number="3">
      <title>Configuration</title>
      <actions>
        <action>Create config loader and validation.</action>
        <action>Define schema/types.</action>
        <action>Create default configuration.</action>
        <action>Test loading.</action>
      </actions>
    </step>

    <step number="4">
      <title>Utilities</title>
      <actions>
        <action>Create logging, error, validation utilities.</action>
        <action>Create common helpers.</action>
        <action>Test utilities.</action>
      </actions>
    </step>

    <step number="5">
      <title>Scaffolding</title>
      <actions>
        <action>Create main application class/module.</action>
        <action>Set up DI and service initialization.</action>
        <action>Handle graceful shutdown.</action>
        <action>Test lifecycle.</action>
      </actions>
    </step>

    <step number="6">
      <title>Health Endpoints</title>
      <actions>
        <action>Create health/status endpoints.</action>
        <action>Create version/info endpoint.</action>
        <action>Test endpoints.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify application starts and config loads.</step>
    <step>Verify utilities and health checks.</step>
    <step>Present to stakeholder for approval.</step>
  </validation>
</instructions>
