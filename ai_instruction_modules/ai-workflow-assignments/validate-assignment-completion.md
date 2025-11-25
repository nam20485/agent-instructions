---
description: Validate that a completed assignment meets all acceptance criteria
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Validate that a completed workflow assignment meets all acceptance criteria before marking complete.</goal>
    <context>Runs after assignment execution completes. Ensures quality and completeness before proceeding to next assignment.</context>
  </overview>

  <prerequisites>
    <item>Assignment execution has completed (all steps attempted).</item>
    <item>Access to assignment definition with acceptance criteria.</item>
    <item>Access to all files created or modified by assignment.</item>
    <item>Required validation tools are available.</item>
  </prerequisites>

  <acceptance_criteria>
    <criterion>All acceptance criteria from original assignment verified.</criterion>
    <criterion>All files created/modified verified to exist and contain expected content.</criterion>
    <criterion>All verification commands executed successfully.</criterion>
    <criterion>Validation report generated with pass/fail status for each criterion.</criterion>
    <criterion>Any failures documented with specific details.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Gather Assignment Context</title>
      <actions>
        <action>Retrieve the original assignment definition.</action>
        <action>Extract all acceptance criteria from the assignment.</action>
        <action>Identify expected deliverables (files, artifacts, state changes).</action>
        <action>Identify verification commands specified in assignment.</action>
      </actions>
    </step>

    <step number="2">
      <title>Verify File Deliverables</title>
      <actions>
        <action>For each expected file: verify it exists at specified path.</action>
        <action>Check file is not empty (unless expected to be empty).</action>
        <action>Verify file contains expected content patterns or structure.</action>
        <action>Check file permissions and encoding are correct.</action>
        <action>Document any missing or malformed files.</action>
      </actions>
    </step>

    <step number="3">
      <title>Execute Verification Commands</title>
      <actions>
        <action>Run each verification command from assignment.</action>
        <action>Capture command output and exit codes.</action>
        <action>Compare results against expected outcomes.</action>
        <action>Document any command failures or unexpected output.</action>
      </actions>
    </step>

    <step number="4">
      <title>Validate Acceptance Criteria</title>
      <actions>
        <action>For each acceptance criterion: determine how to verify it.</action>
        <action>Execute verification (file check, command, manual inspection).</action>
        <action>Mark criterion as PASS or FAIL.</action>
        <action>For failures: document what was expected vs. what was found.</action>
      </actions>
    </step>

    <step number="5">
      <title>Generate Validation Report</title>
      <actions>
        <action>Compile all verification results into structured report.</action>
        <action>Calculate overall pass/fail status.</action>
        <action>List all passing criteria with evidence.</action>
        <action>List all failing criteria with details and suggested remediation.</action>
        <action>Include recommendations for next steps.</action>
      </actions>
    </step>

    <step number="6">
      <title>Handle Validation Outcome</title>
      <actions>
        <action>If ALL criteria pass: Mark assignment as complete, proceed to next assignment.</action>
        <action>If ANY criteria fail: Do NOT mark complete, trigger error recovery, document failures for review.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>All acceptance criteria from original assignment addressed.</step>
    <step>File deliverables verified with existence and content checks.</step>
    <step>Verification commands executed and results captured.</step>
    <step>Validation report generated with clear pass/fail status.</step>
    <step>Appropriate next action taken based on outcome.</step>
  </validation>

  <notes>
    <note>Run automatically after each assignment completes.</note>
    <note>Be thorough - catching issues early prevents cascading failures.</note>
    <note>Document everything for audit trail and debugging.</note>
    <note>When in doubt, mark as FAIL and escalate rather than passing questionable work.</note>
  </notes>
</instructions>
