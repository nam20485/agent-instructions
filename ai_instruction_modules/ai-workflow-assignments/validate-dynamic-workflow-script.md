---
description: Validate dynamic workflow DSL syntax and logic
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Validate that a dynamic workflow script has correct DSL syntax, valid event handlers, and properly references assignment IDs.</goal>
    <context>Runs when creating or modifying workflow scripts. Ensures workflows will execute correctly.</context>
  </overview>

  <prerequisites>
    <item>Workflow script file to validate.</item>
    <item>Access to assignment definitions referenced in workflow.</item>
    <item>Knowledge of workflow DSL syntax and semantics.</item>
  </prerequisites>

  <acceptance_criteria>
    <criterion>Workflow script has valid DSL syntax (no parsing errors).</criterion>
    <criterion>All event handlers use valid event names.</criterion>
    <criterion>All referenced assignment IDs exist in assignment registry.</criterion>
    <criterion>Workflow has at least one entry point (start event or trigger).</criterion>
    <criterion>No circular dependencies between assignments.</criterion>
    <criterion>All variables and parameters properly defined before use.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Parse Workflow Script</title>
      <actions>
        <action>Read workflow script file content.</action>
        <action>Attempt to parse DSL syntax.</action>
        <action>Report any syntax errors with line numbers.</action>
        <action>Extract workflow structure (events, assignments, transitions).</action>
      </actions>
    </step>

    <step number="2">
      <title>Validate Event Handlers</title>
      <actions>
        <action>List all event handlers defined in workflow.</action>
        <action>Verify each event name is valid (on-start, on-assignment-complete, on-assignment-failure, on-workflow-complete, etc.).</action>
        <action>Check event handler bodies for valid actions.</action>
        <action>Report invalid event names or malformed handlers.</action>
      </actions>
    </step>

    <step number="3">
      <title>Verify Assignment References</title>
      <actions>
        <action>Extract all assignment IDs referenced in workflow.</action>
        <action>For each ID: check assignment definition exists in registry.</action>
        <action>Verify assignment files are accessible and valid.</action>
        <action>Report any missing or invalid assignment references.</action>
      </actions>
    </step>

    <step number="4">
      <title>Check Workflow Structure</title>
      <actions>
        <action>Verify workflow has at least one entry point.</action>
        <action>Build dependency graph of assignments.</action>
        <action>Check for circular dependencies (A requires B, B requires A).</action>
        <action>Verify all paths lead to workflow completion.</action>
        <action>Report structural issues.</action>
      </actions>
    </step>

    <step number="5">
      <title>Validate Variables and Parameters</title>
      <actions>
        <action>List all variables used in workflow.</action>
        <action>Verify each variable is defined before use.</action>
        <action>Check parameter passing between assignments.</action>
        <action>Report undefined variables or parameter mismatches.</action>
      </actions>
    </step>

    <step number="6">
      <title>Generate Validation Report</title>
      <actions>
        <action>Compile all validation results.</action>
        <action>Mark workflow as VALID or INVALID.</action>
        <action>List all errors with severity (error, warning, info).</action>
        <action>Provide recommendations for fixing issues.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Workflow script parsed without syntax errors.</step>
    <step>All event handlers validated.</step>
    <step>All assignment references verified.</step>
    <step>Workflow structure analyzed for issues.</step>
    <step>Validation report generated.</step>
  </validation>

  <notes>
    <note>Run before committing workflow changes to prevent broken workflows.</note>
    <note>Warnings should be reviewed but don't block validation.</note>
    <note>Errors must be fixed before workflow can be used.</note>
    <note>Consider running validation as pre-commit hook.</note>
  </notes>
</instructions>
