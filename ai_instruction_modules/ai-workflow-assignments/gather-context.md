---
description: Prepare for workflow assignment execution
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Prepare for workflow assignment execution by gathering context, verifying prerequisites, creating task lists, and preparing the environment.</goal>
    <context>Pre-assignment-begin event handler.</context>
  </overview>

  <acceptance_criteria>
    <criterion>Assignment read and understood.</criterion>
    <criterion>Context gathered from previous work and docs.</criterion>
    <criterion>Prerequisites and tools verified.</criterion>
    <criterion>Task list created with time estimates.</criterion>
    <criterion>Environment prepared.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Read Assignment</title>
      <actions>
        <action>Read detailed steps and goals.</action>
        <action>Review acceptance criteria.</action>
        <action>Identify dependencies and challenges.</action>
      </actions>
    </step>

    <step number="2">
      <title>Gather Context</title>
      <actions>
        <action>Review previous outputs and related issues.</action>
        <action>Check project documentation.</action>
        <action>Understand current state.</action>
      </actions>
    </step>

    <step number="3">
      <title>Verify Prerequisites</title>
      <actions>
        <action>Check required tools and versions.</action>
        <action>Verify previous assignments completed.</action>
        <action>Ensure dependencies and credentials are met.</action>
      </actions>
    </step>

    <step number="4">
      <title>Plan Execution</title>
      <actions>
        <action>Create detailed task list.</action>
        <action>Estimate time with buffer.</action>
        <action>Identify potential risks.</action>
      </actions>
    </step>

    <step number="5">
      <title>Prepare Environment</title>
      <actions>
        <action>Set up workspace and tools.</action>
        <action>Gather resources.</action>
        <action>Perform authentication checks.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Confirm readiness to begin assignment.</step>
  </validation>
</instructions>
