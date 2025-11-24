---\ncontext: opt-in\n---\n---\ncontext: opt-in\n---\n## Assignment: Breakdown Epic and Plan

Goal: Convert a higher-level multi-task sub-phase epic sub-issue into granular, executable sub-issues.

>NOTE: The high-level plans and phase epic issues are created by other workflow assignments, e.g. the `create-app-plan` assignment. The main plan is broken down into phases. Each phases is considered an epic. These sub-phase epic issues are then broken down into granular, executable sub-issues by this assignment. These granular sub-issues are called 'strories` and then worked on by other workflow assignments for implementation.

### Steps
1. Identify phases / major work streams from parent.
2. For each phase create a epic sub-issue: purpose, scope, checklist.
4. Add acceptance criteria (functional + quality + validation commands).
5. List dependencies (issues, env setup, creds, data seeds).
6. Enumerate risks & mitigations.
7. Define test strategy (unit, integration, tools) & new test projects if needed.
8. Provide rollback guidance.
9. Cross-link: Parent: #<id>; siblings.
10. Update parent with checklist referencing created sub-issues.


### Example Structure

*Main Plan Issue*
       |       
      /|\
     / | \
    /  |  \
Phase1 Phase2 Phase3   // become Epics
   |      |      |  
Epic1   Epic2  Epic3    // Epics created from phases (sub-issue children are the Stories below)
   |      |      |
  ...     |     ...
         /|\        
Story1 Story2  Story3  // Stories (sub-Issues of Epics)



### Inputs
- __repo: repository
- __issue: Epic parent issue id

### Output
- Created sub-issues + updated parent checklist

### Done Definition
- All phases represented
- Each sub-issue actionable, unambiguous, testable
- Parent reflects structure & links




