# Assignment: Request Approval

## (request-approval)

### Goal

Pause execution, present relevant produced material, and receive input to obtain approval from stakeholders for the proposed changes and updates. 

### Inputs

$previous_outputs: object (required)
 - outputs from previous step/stage in the workflow

### Acceptance Criteria

1. Previous outputs are presented to the stakeholder for review.
2. Approval is explicitly requested from the stakeholder.
3. Execution is paused until approval is received.
4. If approval is granted, proceed with the next steps.
5. If approval is denied, address any concerns and resubmit for approval.
6. Document the approval process and outcomes.
7. Communicate the results to all relevant parties.
8. Update any project documentation to reflect approved changes.
9. Timeout/escalation protocol is followed if no response received within reasonable timeframe.
10. All stakeholder feedback is captured and incorporated or documented as deferred.
   
### Assignment

Present the outputs from the previous workflow step or stage to stakeholders, explicitly request their approval, and pause execution until a decision is made. If approved, document the approval and proceed. If denied, gather feedback on required changes, address concerns, and resubmit for approval. This assignment ensures stakeholder alignment and sign-off before proceeding with subsequent workflow stages.

**What Constitutes "Relevant Produced Material":**
- Completed work products (code, documents, designs, plans)
- Analysis results and findings
- Proposed changes or recommendations
- Test results or validation outcomes
- Any artifacts that require stakeholder decision-making

**Stakeholder Identification:**
- Primary stakeholder: The person who requested the work or owns the project
- Additional stakeholders: Team leads, technical reviewers, product managers, or other decision-makers specified in the workflow
- If unclear, ask the orchestrator or check project documentation

**Presentation Methods:**
- **For code changes:** Link to PR or commit with summary of changes
- **For documents:** Share file link or attach document with highlights of key sections
- **For analysis:** Provide executive summary with link to detailed report
- **For plans:** Present structured outline with key decisions highlighted
- **For designs:** Share mockups/diagrams with explanation of approach

### Detailed Steps

1. **Prepare presentation materials**
   - Review `$previous_outputs` to understand what was produced
   - Create a clear, concise summary of the work completed
   - Identify key decisions or changes that require stakeholder attention
   - Prepare evidence or supporting materials (links, files, screenshots)
   - Organize material in a format appropriate for the stakeholder's role and preferences
   
2. **Identify stakeholders**
   - Determine who needs to approve this work (check workflow context, project documentation)
   - If multiple stakeholders, prioritize by decision authority
   - Verify contact method and availability
   - Note any specific concerns or focus areas for each stakeholder

3. **Present material and request approval**
   - Present the summary and key outputs to stakeholder(s)
   - Clearly state what decision is needed: "Do you approve proceeding with [specific next step]?"
   - Provide access to detailed materials for review
   - Highlight any risks, dependencies, or constraints they should be aware of
   - Set expectations for response timeframe (e.g., "Please review within 24 hours")
   
   **Example Approval Request:**
   ```
   Hi [Stakeholder],
   
   I've completed [work description] as outlined in [reference]. 
   
   Key outputs:
   - [Output 1 with link]
   - [Output 2 with link]
   
   Please review and confirm approval to proceed with [next step].
   
   Full details: [link to detailed materials]
   
   Request response by: [date/time]
   ```

4. **Pause execution and await response**
   - Stop all work on subsequent workflow steps
   - Monitor for stakeholder response
   - Be available to answer clarifying questions
   - Track elapsed time against expected response timeframe
   
5. **Handle approval decision**
   
   **If approved:**
   - Document the approval (date, time, stakeholder name, any conditions)
   - Thank the stakeholder and confirm next steps
   - Update project tracking to reflect approval milestone
   - Proceed with workflow
   
   **If denied or changes requested:**
   - Document the specific concerns or requested changes
   - Ask clarifying questions to fully understand requirements
   - Create action items to address each concern
   - Determine if you can address concerns or if escalation/reassignment is needed
   - Make necessary revisions
   - Resubmit for approval with explanation of changes made
   
   **If no response within timeframe:**
   - Send one reminder message
   - Wait additional reasonable period (e.g., 12-24 hours)
   - If still no response, escalate:
     * Contact orchestrator or project lead
     * Document the approval blocker
     * Request alternative stakeholder or decision-making process
     * Do not proceed without explicit approval

6. **Document approval process**
   - Record approval decision in project documentation
   - Note any conditions, concerns, or feedback provided
   - Update workflow status to reflect approval milestone
   - If changes were required, document what was revised and why
   - Archive approval communications for future reference

7. **Communicate outcomes**
   - Inform orchestrator and relevant team members of approval status
   - If approved: Communicate readiness to proceed with next steps
   - If denied: Communicate what needs to be addressed and revised timeline
   - Update any project boards, trackers, or status reports 

### Completion

The assignment is complete when:

1. ✅ Stakeholder(s) have been identified and contacted
2. ✅ All relevant material has been presented clearly and completely
3. ✅ Explicit approval request has been made with clear decision point
4. ✅ Stakeholder response has been received (approval, denial, or changes requested)
5. ✅ Approval decision has been documented with date, stakeholder name, and any conditions
6. ✅ If denied: Concerns addressed and resubmission completed OR escalation initiated
7. ✅ Orchestrator and team members have been informed of approval status
8. ✅ Project documentation updated to reflect approval milestone
9. ✅ Either: Ready to proceed with next workflow steps (if approved) OR action plan created to address concerns (if denied)

**Outputs to Record:**
- `approval_status`: "approved" | "denied" | "approved_with_conditions"
- `stakeholder_name`: Name of approving stakeholder
- `approval_date`: Date/time of approval
- `conditions`: Any conditions or constraints on the approval (if applicable)
- `feedback`: Stakeholder feedback or concerns raised
- `revisions_made`: Summary of changes made if resubmission was required


