## Assignment: Breakdown Epic

Goal: Convert a high-level multi-phase epic issue into granular, executable (sub)-issues.

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
  - Tests: dotnet test <Project.Tests>0
  
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
- __repo: repository
- __issue: parent issue id

### Output
- Created sub-issues + updated parent checklist

### Done Definition
- All phases represented
- Each sub-issue actionable, unambiguous, testable
- Parent reflects structure & links


