# Event Handler: post-assignment-complete

## Event ID
`post-assignment-complete`

## Trigger
Fires immediately after a collaborator agent completes an assignment and returns control to the orchestrator.

## Purpose
Provides a checkpoint for validating collaborator outputs, reviewing work quality, and integrating results back into the parent workflow.

## Default Behavior

When this event fires, the orchestrator should:

### 1. Completion Report
Generate assignment completion summary:

**Format:**
```
=== ASSIGNMENT COMPLETE: <assignment-id> ===
Collaborator: <agent-role>
Duration: <elapsed-time>
Status: ✓ COMPLETE
Acceptance Criteria:
  ✓ Criterion 1
  ✓ Criterion 2
  ✓ Criterion 3
Outputs:
  - <output-key>: <output-value>
  - <file-created>: <file-path>
```

#332## 2. Acceptance Criteria Validation
Verify the assignment's Definition of Done:
- Check each acceptance criterion against actual outputs
- Validate file existence, format, content
- Run automated tests if specified
- Confirm expected side effects occurred

**Gate:** If any criterion fails, trigger on-error event with validation failure.

### 3. Output Integration
Incorporate collaborator outputs into workflow context:
- Bind output values to workflow variables
- Record file paths, IDs, URLs created
- Update workflow state with results
- Make outputs available to subsequent steps

**Example:**
```
$planIssue = #plan-application.issueNumber
$projectStructure = #create-structure.projectDir
```

### 4. Quality Review (Optional)
For critical assignments, perform review:
- **Code review**: Check style, patterns, test coverage
- **Document review**: Verify completeness, accuracy
- **Configuration review**: Validate settings, security

Review options:
- **Auto-approve**: Low-risk assignments (documentation, scaffolding)
- **Manual review**: High-risk assignments (security, architecture)
- **Delegate review**: Use code-reviewer agent

### 5. Approval Decision
Make go/no-go decision:

**Approve:**
- All acceptance criteria met
- Quality standards satisfied
- No blocking issues found
→ Continue to next workflow step

**Request Changes:**
- One or more acceptance criteria not met, or quality standards not satisfied
- Reviewer identifies issues requiring revision
- Document specific feedback and required changes
- Notify collaborator agent of requested changes
- Return assignment for rework
- Upon resubmission, repeat validation and review steps
