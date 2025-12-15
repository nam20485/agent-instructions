---
description: Pause execution and request stakeholder approval
role: assistant
scope: workflow-assignment
---

# Request Approval

Present outputs, request approval, pause until decision.

## Input
- `previous_outputs`: Outputs from previous workflow step

## Output
- `approval_status`: approved | denied | approved_with_conditions
- `stakeholder_name`: Approving stakeholder
- `approval_date`: Date/time
- `conditions`: Any conditions (if applicable)
- `feedback`: Concerns raised
- `revisions_made`: Changes if resubmission required

## Acceptance Criteria
- Outputs presented for review
- Approval explicitly requested
- Execution paused until response
- If approved: proceed
- If denied: address concerns, resubmit
- Process documented
- Timeout/escalation protocol followed

## Workflow

### 1. Prepare Materials
- Review `$previous_outputs`
- Create clear summary
- Identify key decisions requiring attention
- Prepare evidence (links, files, screenshots)

### 2. Identify Stakeholders
- Determine who needs to approve
- Prioritize by decision authority
- Verify contact method

### 3. Present & Request
- Present summary and key outputs
- State decision needed: "Do you approve [next step]?"
- Highlight risks, dependencies, constraints
- Set response timeframe

### 4. Pause & Await
- Stop work on subsequent steps
- Monitor for response
- Answer clarifying questions
- Track elapsed time

### 5. Handle Decision

**Approved:**
- Document (date, stakeholder, conditions)
- Confirm next steps
- Proceed with workflow

**Denied:**
- Document concerns
- Ask clarifying questions
- Create action items
- Make revisions
- Resubmit

**No Response:**
- Send reminder
- Wait 12-24 hours
- Escalate to orchestrator
- Do not proceed without approval

### 6. Document
- Record in project documentation
- Update workflow status
- Archive communications
