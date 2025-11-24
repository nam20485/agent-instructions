---
description: Set up testing infrastructure and initial test suite
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Set up testing infrastructure and create initial test suite to establish testing culture.</goal>
    <prerequisites>
      <item>Application Foundation completed.</item>
      <item>Application Structure completed.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Test framework configured and working.</criterion>
    <criterion>Test directory structure created.</criterion>
    <criterion>Test utilities created.</criterion>
    <criterion>At least 5 smoke tests passing.</criterion>
    <criterion>Test command works.</criterion>
    <criterion>Coverage reporting configured.</criterion>
    <criterion>docs/TESTING.md created.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Configure Framework</title>
      <actions>
        <action>Install test framework (Jest, pytest, xUnit, etc.).</action>
        <action>Create configuration file.</action>
        <action>Configure test environment and coverage.</action>
      </actions>
    </step>

    <step number="2">
      <title>Directory Structure</title>
      <actions>
        <action>Create unit, integration, and fixture directories.</action>
        <action>Create test utilities directory.</action>
      </actions>
    </step>

    <step number="3">
      <title>Create Utilities</title>
      <actions>
        <action>Create helper functions.</action>
        <action>Create mock/stub factories.</action>
        <action>Create test data builders.</action>
      </actions>
    </step>

    <step number="4">
      <title>Smoke Tests</title>
      <actions>
        <action>Write 5+ smoke tests (Core, Config, Utils, Entry Point, Integration).</action>
        <action>Ensure tests pass.</action>
      </actions>
    </step>

    <step number="5">
      <title>Configure Commands</title>
      <actions>
        <action>Add test, coverage, and watch commands to build system.</action>
      </actions>
    </step>

    <step number="6">
      <title>Documentation</title>
      <actions>
        <action>Create `docs/TESTING.md`.</action>
        <action>Document strategy, commands, patterns, and examples.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify all tests pass.</step>
    <step>Verify coverage reporting.</step>
    <step>Present to stakeholder for approval.</step>
  </validation>
</instructions>
