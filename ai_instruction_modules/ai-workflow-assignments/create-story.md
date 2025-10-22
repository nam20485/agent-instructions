# Assignment: Create Story

## (create-story)

### Goal

Create a single story sub-issue from an epic issue. The story represents a granular, executable task that can be implemented independently. Stories are the most detailed level in the issue hierarchy and are directly actionable by developers.

### Inputs
- `$story`: Story object containing the story name, description, requirements, and entire content extracted from the parent epic issue

### Output
- Single story sub-issue created and linked to the parent epic issue
- Story contains detailed tasks, acceptance criteria, and validation commands
- Story is assigned to the appropriate milestone
- Returns the created story issue object for downstream processing

### Acceptance Criteria

1. Parent epic issue has been reviewed and the story requirements understood
2. Story issue created using the official story template from `.github/ISSUE_TEMPLATE/story.md`
3. Story title follows format: `Story: <story name>`
4. Story contains clear objective with expected outcome
5. Scope is clearly defined (what's included and excluded)
6. Detailed plan with checkboxed tasks is provided
7. Acceptance criteria are specific and measurable
8. Validation commands are included (build, run, test commands)
9. Dependencies are identified (issues, environment variables, data)
10. Risks and mitigations are documented
11. Test strategy is defined (unit, integration, e2e)
12. Rollback guidance is provided
13. Story is linked as a sub-issue to the parent epic using GitHub's sub-issue feature
14. Story is linked to the appropriate milestone
15. Story has been added to the GitHub Project
16. Story is marked as blocking the parent epic issue
17. Story issue object is returned for downstream workflow processing

### Assignment

Your assignment is to create a single story sub-issue for one story from an existing epic issue. This involves:

1. Analyzing the story input to understand the task requirements
2. Breaking down the story into detailed, executable tasks
3. Creating a comprehensive story issue using the official template
4. Properly linking the story to the parent epic and milestone

The parent epic issue should already exist and contain high-level story descriptions. You will be creating ONE story for ONE specific task as provided in the `$story` input parameter.

This assignment is typically invoked by the `breakdown-plan` dynamic workflow, which orchestrates the creation of stories from epic issues.

**Always follow instructions given here and as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Issue Hierarchy Context

This assignment creates **Stories** at the bottom level of the issue hierarchy:

```
┌─────────────────────────────────────┐
│     Main Application Plan Issue     │  ← Top level: Overall application plan
└─────────────────────────────────────┘
                 │
        ┌────────┼────────┐
        │        │        │
┌───────▼──┐ ┌──▼──────┐ ┌▼────────┐
│ Phase 1  │ │ Phase 2 │ │ Phase 3 │
│  EPIC    │ │  EPIC   │ │  EPIC   │  ← Middle level: Epics (from phases)
└──────────┘ └─────────┘ └─────────┘
     │            │           │
  ┌──┼──┐      ┌─┼─┐      ┌──┼──┐
  │  │  │      │ │ │      │  │  │
  ▼  ▼  ▼      ▼ ▼ ▼      ▼  ▼  ▼
Story1 2 3   Story4 5 6  Story7 8 9   ← **THIS LEVEL**: Stories (granular tasks)
                                         (This assignment creates ONE of these)
```

**Your Role:** You are creating ONE Story from ONE Epic. Stories are directly implementable tasks.

### References

* Excellent example of a completed story sub-issue:
    * https://github.com/nam20485/advanced-memory3/issues/14 (Example Story)
    * https://github.com/nam20485/support-assistant/issues/5 (Example Story)

* Example parent epic issues:
    * https://github.com/nam20485/advanced-memory3/issues/13
    * https://github.com/nam20485/support-assistant/issues/3

### Detailed Steps

1. **Review Story Input**
   - Extract the story name, description, and requirements from the `$story` input
   - Identify the parent epic issue from the story context
   - Understand the story objectives and expected outcomes
   - Review any technical constraints or dependencies
   - Note related components and files that will be affected

2. **Analyze Story Requirements**
   - Extract all specific requirements for this story
   - Identify the technical approach and implementation strategy
   - Understand dependencies on other stories or external systems
   - Determine validation criteria and testing needs
   - Review any referenced documentation or design decisions

3. **Break Down Story into Tasks**
   - Divide the story into specific, actionable tasks (typically 3-8 tasks)
   - Ensure tasks follow a logical sequence
   - Make each task independently testable
   - Include setup, implementation, testing, and documentation tasks
   - Add checkboxes for all tasks

4. **Create Story Issue**
   - Use the official story template from `.github/ISSUE_TEMPLATE/story.md`
   - Fill in all sections completely:
     - **Objective**: Clear, concise statement of what the story achieves
     - **Scope**: Explicitly define what''s in scope and out of scope
     - **Plan**: Detailed checklist of tasks with checkboxes
     - **Acceptance Criteria**: Specific, measurable conditions for completion
     - **Validation Commands**: Actual commands to build, run, and test
     - **Dependencies**: List related issues, environment variables, configuration
     - **Risks & Mitigations**: Identify potential problems and solutions
     - **Test Strategy**: Define unit, integration, and e2e testing approach
     - **Rollback**: Provide clear instructions for reverting changes

5. **Link Story to Epic**
   - Create the story issue in the repository
   - Link the story to the GitHub Project for unified tracking
   - Use GitHub''s sub-issue feature to link the story to the parent epic issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
   - Link the story to the appropriate milestone matching the epic''s milestone
   - Add the story as a blocking dependency in the parent epic issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies
   - Apply appropriate labels (e.g., `story`, `feature`, `bug`, `enhancement`)

6. **Quality Validation**
   - Verify all template sections are completed (no placeholders remain)
   - Ensure tasks are specific and actionable
   - Confirm acceptance criteria are measurable
   - Validate that validation commands are correct and complete
   - Check that dependencies are identified
   - Ensure test strategy covers all critical paths
   - Verify rollback guidance is clear

### Completion

1. **Finalize Story:**
   - Confirm story is properly linked as sub-issue to parent epic
   - Verify milestone assignment is correct
   - Ensure story is marked as blocking the parent epic
   - Verify all template sections are complete
   - **DO NOT IMPLEMENT OR WRITE ANY CODE.** This assignment is planning only.

2. **Return Story Object:**
   - Return the created story issue object to the calling workflow
   - The story object will be used by the `breakdown-plan` workflow to:
     - Track progress of story creation
     - Enable downstream workflow processing
     - Support metrics and reporting

**Note:** Stakeholder review of individual stories is not required. The orchestrating workflow will handle review of all stories after they are created.

## Story Template Reference

The official story template is located at:
`.github/ISSUE_TEMPLATE/story.md`

Use this template when creating the story issue. It contains the complete structure including:
- Objective and expected outcome
- Scope (in/out)
- Detailed plan with checkboxed tasks
- Acceptance criteria
- Validation commands (build, run, test)
- Dependencies (issues, env vars, data)
- Risks and mitigations
- Test strategy (unit, integration, e2e)
- Rollback guidance