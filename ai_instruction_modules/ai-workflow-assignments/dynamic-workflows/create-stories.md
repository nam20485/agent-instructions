## Assignment: Breakdown Epic and Plan

Goal: Convert a higher-level multi-task sub-phase epic sub-issue into granular, executable sub-issues.

>NOTE: The high-level plans and phase epic issues are created by other workflow assignments, e.g. the `create-app-plan` assignment. The main plan is broken down into phases. Each phases is considered an epic. These sub-phase epic issues are then broken down into granular, executable sub-issues by this assignment. 

### Steps
1. Identify phases / major work streams from parent.
2. For each phase create a sub-issue: purpose, scope, checklist.
3. Decompose tasks to < ~0.5 day effort each.
4. Add acceptance criteria (functional + quality + validation commands).
5. List dependencies (issues, env setup, creds, data seeds).
6. Enumerate risks & mitigations.
7. Define test strategy (unit, integration, tools) & new test projects if needed.
8. Provide rollback guidance.
9. Cross-link: Parent: #<id>; siblings.
10. Update parent with checklist referencing created sub-issues.

### Sub-Issue Body Template (YAML)
```yaml
title: "Phase X: <objective>"
body: |
  Parent: #<parent>
  
  ## Objective
  <Outcome sentence>
  
  ## Scope
  In: <list>
  Out: <list>
  
  ## Plan
  1. [ ] Task 1
  2. [ ] Task 2
  3. [ ] Task 3
  
  ## Acceptance Criteria
  - AC1
  - AC2

  ## Validation Commands
  - Run: dotnet run
  - Build: dotnet build
  - Tests: dotnet test <Project.Tests>
  
  ## Dependencies
  - Issue #
  - Env var XYZ
  
  ## Risks & Mitigations
  - Risk: <risk> → Mitigation: <mitigation>
  
  ## Test Strategy
  - Unit: new cases in <Project.Tests>
  - Integration: endpoints A,B via TestServer
  
  
  ## Rollback
  - Revert PR or commits <hash..hash>
```

### Inputs
- _issue: parent issue id

### Output
- Created sub-issues + updated parent checklist

### Done Definition
- All phases represented
- Each sub-issue actionable, unambiguous, testable
- Parent reflects structure & links


---

## Appendix B: Application Plan Phases's Epic Sub-Issue Template (Copy-Paste)

Use the template below when you create a sub-issue for each phase in the application plan in step 4. It aligns with the Phases and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Create a sub-issue off of the main plan issue for each phase, using the template below, and then fill in the placeholders.

Template has been moved to [epic.md](/.github/ISSUE_TEMPLATE/epic.md)