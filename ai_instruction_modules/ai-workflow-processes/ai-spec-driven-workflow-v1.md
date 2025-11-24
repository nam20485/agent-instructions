---
description: Structured workflow bridging requirements and implementation via EARS notation and 6-phase loop.
scope: spec-driven-workflow
prerequisites: none
---
# Spec Driven Workflow v1

<xml>
<instructions role="assistant" scope="spec-driven-workflow">

<overview>
## Overview
Bridge the gap between requirements and implementation.
**Artifacts:**
- `requirements.md`: User stories and acceptance criteria (EARS).
- `design.md`: Technical architecture, diagrams, implementation considerations.
- `tasks.md`: Detailed, trackable implementation plan.
</overview>

<documentation_framework>
## Universal Documentation Framework
- **Rule:** Use detailed templates as the **primary source of truth**.
- **Summary:** Use only for concise artifacts (changelogs, PRs).

### Templates
<see template="../templates/spec-driven-templates.md" />
</documentation_framework>

<execution_workflow>
## Execution Workflow (6-Phase Loop)
**Never skip any step. Use consistent terminology. Reduce ambiguity.**

### Phase 1: ANALYZE
- **Objective:** Understand problem, analyze system, produce requirements.
- **Checklist:**
    - [ ] Read code/docs/logs.
    - [ ] Define requirements (EARS).
    - [ ] Identify dependencies/constraints.
    - [ ] Map data flows.
    - [ ] Catalog edge cases.
    - [ ] Assess confidence (0-100%).
- **Constraint:** Do not proceed until requirements are clear.

### Phase 2: DESIGN
- **Objective:** Create technical design and implementation plan.
- **Checklist:**
    - [ ] Define execution strategy (High/Medium/Low confidence).
    - [ ] Document `design.md` (Architecture, Data Flow, Interfaces, Models).
    - [ ] Document error handling.
    - [ ] Define unit testing strategy.
    - [ ] Create `tasks.md`.
- **Constraint:** Do not proceed until design/plan are complete.

### Phase 3: IMPLEMENT
- **Objective:** Write production-quality code.
- **Checklist:**
    - [ ] Code in small increments.
    - [ ] Implement from dependencies upward.
    - [ ] Follow conventions.
    - [ ] Add meaningful comments.
    - [ ] Update task status.
- **Constraint:** Do not merge until documented and tested.

### Phase 4: VALIDATE
- **Objective:** Verify implementation.
- **Checklist:**
    - [ ] Execute automated tests.
    - [ ] Manual verification.
    - [ ] Test edge cases.
    - [ ] Verify performance.
    - [ ] Log execution traces.
- **Constraint:** Do not proceed until validation complete.

### Phase 5: REFLECT
- **Objective:** Improve codebase and documentation.
- **Checklist:**
    - [ ] Refactor.
    - [ ] Update documentation.
    - [ ] Identify improvements.
    - [ ] Validate success criteria.
    - [ ] Meta-analysis.
    - [ ] Auto-create tech debt issues.
- **Constraint:** Do not close phase until actions logged.

### Phase 6: HANDOFF
- **Objective:** Package for review/deployment.
- **Checklist:**
    - [ ] Generate executive summary.
    - [ ] Prepare PR.
    - [ ] Finalize workspace (archive).
    - [ ] Continue to next task.
- **Constraint:** Task not complete until handoff finished.
</execution_workflow>

<troubleshooting>
## Troubleshooting & Retry Protocol
1.  **Re-analyze:** Revisit Phase 1.
2.  **Re-design:** Revisit Phase 2.
3.  **Re-plan:** Adjust `tasks.md`.
4.  **Retry:** Re-execute with corrections.
5.  **Escalate:** If issues persist.
</troubleshooting>

<tech_debt>
## Technical Debt Management
- **Identify:** Code quality, shortcuts, workspace drift, documentation gaps.
- **Template:** See Templates section.
- **Remediation:** Risk-based prioritization.
</tech_debt>

<qa>
## Quality Assurance
- **Monitoring:** Static/Dynamic analysis, Documentation checks.
- **Metrics:** Coverage, Complexity, Maintainability, Debt Ratio.
</qa>

<ears_reference>
## EARS Notation Reference
- **Ubiquitous:** `THE SYSTEM SHALL [expected behavior]`
- **Event-driven:** `WHEN [trigger] THE SYSTEM SHALL [behavior]`
- **State-driven:** `WHILE [state] THE SYSTEM SHALL [behavior]`
- **Unwanted:** `IF [unwanted] THEN THE SYSTEM SHALL [response]`
- **Optional:** `WHERE [feature] THE SYSTEM SHALL [behavior]`
</ears_reference>

</instructions>
</xml>
