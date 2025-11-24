---
description: Provide progress reporting, output capture, and validation checkpoints
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    Provide progress reporting, output capture, and validation checkpoints after each workflow step completes successfully, enabling visibility into workflow execution and facilitating recovery from interruptions.
  </overview>

  <validation>
    <criteria>Generate structured progress report with step name, duration, and completion status</criteria>
    <criteria>Capture and record all step outputs for use in subsequent steps</criteria>
    <criteria>Validate that all expected outputs exist and meet format requirements</criteria>
    <criteria>Save workflow state to enable resume-from-checkpoint capability</criteria>
    <criteria>Provide optional user notifications for long-running workflows</criteria>
  </validation>

  <workflow>
    <step name="Generate Progress Report">
      <action>Create structured progress update with step name, duration, completion status, outputs, overall progress, and next step</action>
      <action>Format the progress report according to the template</action>
    </step>

    <step name="Capture Step Outputs">
      <action>Record all step outputs for use in subsequent steps (store in workflow context, update variable bindings)</action>
      <action>Ensure all outputs are properly documented and accessible (verify data types, confirm file paths)</action>
    </step>

    <step name="Validate Step Acceptance Criteria">
      <action>Verify step acceptance criteria to ensure proper completion (check outputs, validate format, confirm side effects)</action>
      <action>Document validation results (record passed/failed criteria)</action>
      <action>If any criteria fail, trigger appropriate error handling</action>
    </step>

    <step name="Create Checkpoint State">
      <action>Save workflow state for recovery capabilities (record completed steps, capture variable state)</action>
      <action>Ensure checkpoint data is properly stored and accessible for recovery</action>
    </step>

    <step name="Provide User Notification (Optional)">
      <action>For long-running workflows, provide periodic updates to users</action>
      <action>Format notification with step completion information, key metrics, and next step</action>
    </step>

    <step name="Completion">
      <action>Verify Report Progress Assignment is Complete</action>
      <action>Present to Stakeholder</action>
      <action>Stakeholder Review Process</action>
      <action>Finalization</action>
    </step>
  </workflow>

  <templates>
    <template name="Progress Report">
      <content>
=== STEP COMPLETE: &lt;step-name&gt; ===
Status: ✓ COMPLETE
Duration: &lt;elapsed-time&gt;
Outputs:
  - &lt;key-output-1&gt;: &lt;value-or-location&gt;
  - &lt;key-output-2&gt;: &lt;value-or-location&gt;
Progress: &lt;completed-steps&gt;/&lt;total-steps&gt; (&lt;percentage&gt;%)
Next: &lt;next-step-name&gt;
      </content>
    </template>
    <template name="User Notification">
      <content>
✓ Step 3/8 complete: Application structure created
  Created 24 files in src/MyApp/
  Next: Configure CI/CD pipeline
      </content>
    </template>
  </templates>
</instructions>
