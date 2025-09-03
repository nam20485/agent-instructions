Title: "Story : <story name>"
body: |
  Parent Epic: #<parent_epic>
  
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