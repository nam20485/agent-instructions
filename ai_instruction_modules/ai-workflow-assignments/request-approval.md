---
description: Pause execution and request stakeholder approval
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    Present the outputs from the previous workflow step or stage to stakeholders, explicitly request their approval, and pause execution until a decision is made. If approved, document the approval and proceed. If denied, gather feedback on required changes, address concerns, and resubmit for approval.
  </overview>

  <input_schema>
    <parameter name="previous_outputs" type="object" required="true">
      <description>Outputs from previous step/stage in the workflow</description>
    </parameter>
  </input_schema>

  <output_schema>
    <result name="approval_status" type="string" required="true">
      <description>Status of the approval request</description>
      <values>
        <value>approved</value>
        <value>denied</value>
        <value>approved_with_conditions</value>
      </values>
    </result>
    <result name="stakeholder_name" type="string" required="true">
      <description>Name of approving stakeholder</description>
    </result>
    <result name="approval_date" type="string" required="true">
      <description>Date/time of approval</description>
    </result>
    <result name="conditions" type="string">
      <description>Any conditions or constraints on the approval (if applicable)</description>
    </result>
    <result name="feedback" type="string">
      <description>Stakeholder feedback or concerns raised</description>
    </result>
    <result name="revisions_made" type="string">
      <description>Summary of changes made if resubmission was required</description>
    </result>
  </output_schema>

  <validation>
    <criteria>Previous outputs are presented to the stakeholder for review.</criteria>
    <criteria>Approval is explicitly requested from the stakeholder.</criteria>
    <criteria>Execution is paused until approval is received.</criteria>
    <criteria>If approval is granted, proceed with the next steps.</criteria>
    <criteria>If approval is denied, address any concerns and resubmit for approval.</criteria>
    <criteria>Document the approval process and outcomes.</criteria>
    <criteria>Communicate the results to all relevant parties.</criteria>
    <criteria>Update any project documentation to reflect approved changes.</criteria>
    <criteria>Timeout/escalation protocol is followed if no response received within reasonable timeframe.</criteria>
    <criteria>All stakeholder feedback is captured and incorporated or documented as deferred.</criteria>
  </validation>

  <workflow>
    <step name="Prepare presentation materials">
      <action>Review `$previous_outputs` to understand what was produced</action>
      <action>Create a clear, concise summary of the work completed</action>
      <action>Identify key decisions or changes that require stakeholder attention</action>
      <action>Prepare evidence or supporting materials (links, files, screenshots)</action>
      <action>Organize material in a format appropriate for the stakeholder's role and preferences</action>
    </step>

    <step name="Identify stakeholders">
      <action>Determine who needs to approve this work (check workflow context, project documentation)</action>
      <action>If multiple stakeholders, prioritize by decision authority</action>
      <action>Verify contact method and availability</action>
      <action>Note any specific concerns or focus areas for each stakeholder</action>
    </step>

    <step name="Present material and request approval">
      <action>Present the summary and key outputs to stakeholder(s)</action>
      <action>Clearly state what decision is needed: "Do you approve proceeding with [specific next step]?"</action>
      <action>Provide access to detailed materials for review</action>
      <action>Highlight any risks, dependencies, or constraints they should be aware of</action>
      <action>Set expectations for response timeframe</action>
    </step>

    <step name="Pause execution and await response">
      <action>Stop all work on subsequent workflow steps</action>
      <action>Monitor for stakeholder response</action>
      <action>Be available to answer clarifying questions</action>
      <action>Track elapsed time against expected response timeframe</action>
    </step>

    <step name="Handle approval decision">
      <case value="approved">
        <action>Document the approval (date, time, stakeholder name, any conditions)</action>
        <action>Thank the stakeholder and confirm next steps</action>
        <action>Update project tracking to reflect approval milestone</action>
        <action>Proceed with workflow</action>
      </case>
      <case value="denied_or_changes_requested">
        <action>Document the specific concerns or requested changes</action>
        <action>Ask clarifying questions to fully understand requirements</action>
        <action>Create action items to address each concern</action>
        <action>Determine if you can address concerns or if escalation/reassignment is needed</action>
        <action>Make necessary revisions</action>
        <action>Resubmit for approval with explanation of changes made</action>
      </case>
      <case value="no_response">
        <action>Send one reminder message</action>
        <action>Wait additional reasonable period (e.g., 12-24 hours)</action>
        <action>If still no response, escalate to orchestrator or project lead</action>
        <action>Do not proceed without explicit approval</action>
      </case>
    </step>

    <step name="Document approval process">
      <action>Record approval decision in project documentation</action>
      <action>Note any conditions, concerns, or feedback provided</action>
      <action>Update workflow status to reflect approval milestone</action>
      <action>If changes were required, document what was revised and why</action>
      <action>Archive approval communications for future reference</action>
    </step>

    <step name="Communicate outcomes">
      <action>Inform orchestrator and relevant team members of approval status</action>
      <action>If approved: Communicate readiness to proceed with next steps</action>
      <action>If denied: Communicate what needs to be addressed and revised timeline</action>
      <action>Update any project boards, trackers, or status reports</action>
    </step>
  </workflow>

  <templates>
    <template name="Approval Request">
      <content>
Hi [Stakeholder],

I've completed [work description] as outlined in [reference]. 

Key outputs:
- [Output 1 with link]
- [Output 2 with link]

Please review and confirm approval to proceed with [next step].

Full details: [link to detailed materials]

Request response by: [date/time]
      </content>
    </template>
  </templates>
</instructions>
