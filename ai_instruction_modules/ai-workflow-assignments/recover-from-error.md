---
description: Handle errors during workflow assignment execution
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Handle errors during workflow assignment execution by systematic troubleshooting, escalation, and rollback procedures.</goal>
    <context>Implements `on-assignment-failure` event handler. Executes when errors occur during workflow execution.</context>
  </overview>

  <prerequisites>
    <item>An error has occurred during workflow assignment execution.</item>
    <item>Access to error logs and failure context.</item>
    <item>Required troubleshooting tools are available.</item>
    <item>Permissions to create issues and notify stakeholders.</item>
  </prerequisites>

  <acceptance_criteria>
    <criterion>Common errors identified with symptoms, causes, and solutions documented.</criterion>
    <criterion>Escalation procedure followed when errors persist.</criterion>
    <criterion>Rollback procedure executed when changes need reverting.</criterion>
    <criterion>Error documented with full context and attempted solutions.</criterion>
    <criterion>Stakeholders notified of persistent errors requiring intervention.</criterion>
    <criterion>Prevention tips documented to avoid similar errors.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Identify and Troubleshoot Error</title>
      <actions>
        <action>Identify error type from message and symptoms (Dependency, Build, Type Check, Lint, Test, Container, CI/CD).</action>
        <action>For Dependency fails: Check version conflicts, clear cache, verify network.</action>
        <action>For Build fails: Verify dependencies, check config, verify import paths, try clean build.</action>
        <action>For Type Check fails: Check config, verify type definitions, run dependency install.</action>
        <action>For Lint/Formatter fails: Run auto-fix, check config, verify plugins.</action>
        <action>For Test fails: Review output, run in isolation, verify environment.</action>
        <action>For Container fails: Check Dockerfile syntax, verify paths, try --no-cache.</action>
        <action>For CI/CD fails: Check config syntax, verify secrets, review logs.</action>
      </actions>
    </step>

    <step number="2">
      <title>Escalation Procedure</title>
      <description>Follow when errors persist after troubleshooting.</description>
      <actions>
        <action>Document error: full message, stack trace, steps to reproduce, environment details, attempted solutions.</action>
        <action>Create GitHub issue with error details, tag "bug" and "needs-investigation", link to failed assignment.</action>
        <action>Notify stakeholders with error details and context, request manual intervention.</action>
        <action>Do NOT mark assignment complete or proceed to next assignment.</action>
      </actions>
    </step>

    <step number="3">
      <title>Rollback Procedure</title>
      <description>Execute when changes need to be reverted.</description>
      <actions>
        <action>Assess impact: what changes were made before error, what needs rollback.</action>
        <action>Perform rollback: `git checkout -- .` or `git reset --soft`, delete generated files, clean artifacts.</action>
        <action>Verify rollback: confirm previous state, test functionality, check for orphaned files.</action>
        <action>Document rollback: record what was reverted and why, lessons learned, plan next steps.</action>
      </actions>
    </step>

    <step number="4">
      <title>Apply Prevention Tips</title>
      <actions>
        <action>Before future assignments: Read completely, verify prerequisites, check environment.</action>
        <action>During execution: Follow steps exactly, verify each step, test incrementally.</action>
        <action>After completion: Run verification commands, check acceptance criteria, document deviations.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Error properly diagnosed and categorized.</step>
    <step>Appropriate troubleshooting steps attempted.</step>
    <step>Escalation or rollback executed successfully.</step>
    <step>Error documented with full context.</step>
    <step>Stakeholders notified if needed.</step>
  </validation>

  <notes>
    <note>Typically executed automatically by workflow orchestrators when errors occur.</note>
    <note>Should execute quickly to minimize downtime.</note>
    <note>All errors should be documented for future reference.</note>
    <note>Communication with stakeholders is critical during recovery.</note>
  </notes>
</instructions>
