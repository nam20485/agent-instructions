---
description: Incorporate feedback to improve work quality
role: assistant
scope: workflow-assignment
---

# Update from Feedback

Address feedback from previous assignment to improve quality.

## Input
- `directory`: Path to feedback documents

## Acceptance Criteria
- All reviewer comments addressed
- Feedback items categorized and prioritized
- Action plan created with actionable items
- GitHub issues created/updated
- Documentation updated
- Changes validated against criteria
- Summary report created

## Workflow

### 1. Review Feedback
- Access feedback documents in specified directory
- Extract items with severity, context, metrics
- Create structured list (ID, source, severity, effort)

### 2. Categorize
Categories: Implementation Gaps | Quality Issues | Architecture | Performance | Documentation | Process | Testing | Lessons Learned

### 3. Prioritize
- Assign priority (P0-P3)
- Estimate effort (S/M/L)
- Calculate score: (Severity × Impact) / Effort
- Sort by priority score

### 4. Document Action Plan
- Create comprehensive action plan document

### 5. Create GitHub Issues
- Determine type (Epic/Story/Task/Bug)
- Create with appropriate labels
- Link to action plan
- Track in table

### 6. Implement
**P0/P1 (Immediate):**
- Create branch → Implement → Validate → PR

**P2/P3 (Scheduled):**
- Create issues → Assign to milestone → Add to board

**Workflow Changes:**
- Create `docs/FEEDBACK_WORKFLOW_CHANGES.md`
- Create issue in agent-instructions repo

### 7. Validate
- Build, lint, test pass
- Documentation accurate
- Issues properly labeled and linked
- Compare before/after metrics

### 8. Document Summary
- Create Feedback Response Summary
- Update original feedback with status
- Communicate to stakeholders
