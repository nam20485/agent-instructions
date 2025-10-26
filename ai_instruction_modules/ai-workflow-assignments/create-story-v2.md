# Assignment: Create Story

## (create-story)

### Goal

Transform a high-level story bullet from a parent epic into its own story sub-issue. The story inherits context from the epic while expanding the bullet into a fully scoped, executable work item with validation commands, dependencies, and quality gates.

### Inputs
- `$epic`: Epic issue object containing the epic title, description, acceptance criteria, dependencies, template metadata, and parent plan references
- `$story`: Story bullet object containing the identifier, title, description, acceptance criteria, dependencies, task-list structure, and guidance extracted from the epic

### Output
- Returns the created story issue object containing the following data for downstream processing:
   - Story issue ID: Unique identifier of the created story issue
   - Story issue URL: Full URL to access the created story issue
   - Story title: Title of the created story issue
   - Parent epic ID: ID of the epic this story is linked to
   - Epic context: The epic object that provided context for this story
   - Story bullet data: The original story bullet object that was transformed into this story
- Maintains references required by downstream workflows for validation and implementation sequencing

#### Structure of Returned Story Issue Object
```json
{
   "id": 987654321,
   "url": "https://github.com/owner/repo/issues/987654321",
   "title": "Story: <story name>",
   "parent_epic_id": 123456789,
   "epic": "$epic",
   "story": "$story"
}
```

### Acceptance Criteria

1. Parent epic issue has been reviewed and the targeted story bullet fully understood
2. Story issue created using the official story template from `.github/ISSUE_TEMPLATE/story.md`
3. Story title follows format: `Story: <story name>`
4. Story objective captures the intent of the original story bullet with clear expected outcome
5. Scope is clearly defined (what's included and excluded) and aligned with the parent epic
6. Implementation plan preserves the checkbox hierarchy from the story bullet while expanding steps where needed
7. Acceptance criteria are specific, measurable, and derived from the original story guidance
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

Your assignment is to transform a single story bullet from an existing epic issue into a fully scoped story sub-issue. This involves:

1. Analyzing the epic and story inputs to understand context, intent, and constraints
2. Expanding the story bullet into detailed, executable tasks while preserving its original structure
3. Creating a comprehensive story issue using the official template
4. Properly linking the story to the parent epic, project, and milestone for downstream workflows

The parent epic issue should already exist and contain the story bullet that triggered this assignment. You will be creating ONE story for ONE specific bullet as provided in the `$story` input parameter, using `$epic` for context and linkage.

This assignment is typically invoked by the `create-stories-for-epic` dynamic workflow (and remains compatible with `breakdown-plan`) to convert epic story bullets into executable story issues.

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

1. **Review Epic and Story Inputs**
   - Extract epic metadata (title, summary, acceptance criteria, dependencies, labels) from the `$epic` input
   - Identify the parent plan issue and milestone from the epic context
   - Analyze the `$story` bullet to capture its identifier, description, acceptance criteria, dependencies, and checkbox hierarchy
   - Understand objectives, outcomes, and sequencing expectations communicated in the epic

2. **Analyze Story Requirements**
   - Determine technical approach, architectural touchpoints, and integration requirements based on epic guidance
   - Identify dependencies on other stories, external services, data sets, or environment prerequisites
   - Capture validation expectations (commands, test suites, tooling) specified or implied in the story bullet
   - Review referenced documentation, designs, or prior implementation notes linked from the epic or story bullet

3. **Transform Story Bullet into Implementation Plan**
   - Preserve the original checkbox/task hierarchy from the story bullet while expanding each item with actionable detail
   - Introduce additional setup, testing, documentation, or cleanup steps required to complete the work safely
   - Ensure sequencing supports iterative delivery (foundation → core implementation → integration → validation)
   - Map each expanded task to acceptance criteria and validation commands for traceability

4. **Create Story Issue**
   - Use the official story template from `.github/ISSUE_TEMPLATE/story.md`
   - Populate every section with concrete, measurable content derived from `$epic` and `$story`:
     - **Objective**: Summarize intent and expected outcome from the story bullet
     - **Scope**: Detail inclusions/exclusions, highlighting alignment with the epic and adjacent work
     - **Plan**: Present the expanded checkbox plan that preserves the original hierarchy
     - **Acceptance Criteria**: Translate bullet-level criteria into measurable statements
     - **Validation Commands**: Provide precise build/test/run commands required to prove completion
     - **Dependencies**: List upstream issues, environment variables, configuration, and data needs
     - **Risks & Mitigations**: Document foreseeable risks with mitigation strategies
     - **Test Strategy**: Outline unit, integration, and e2e coverage expectations
     - **Rollback**: Describe safe rollback/abort steps if implementation fails

5. **Link Story to Epic and Tracking Artifacts**
   - Create the story issue in the repository using the template output
   - Link the story to the GitHub Project for unified tracking
   - Use GitHub's sub-issue feature to link the story to the parent epic issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
   - Link the story to the appropriate milestone inherited from the epic
   - Add the story as a blocking dependency in the parent epic issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies
   - Apply labels consistent with the parent epic and story taxonomy (e.g., `story`, `feature`, `component-area`)

6. **Quality Validation**
   - Verify every template section is complete with no placeholders or TBD entries
   - Confirm the expanded plan fully preserves and elaborates on the original story bullet content
   - Ensure acceptance criteria and validation commands are specific, measurable, and executable
   - Validate dependencies and risks are documented with actionable mitigations
   - Check the test strategy covers critical paths and regression concerns
   - Confirm rollback guidance provides clear, safe recovery steps

### Completion

1. **Finalize Story:**
   - Confirm the story is linked as a sub-issue to the parent epic and reflects accurate blocking relationships
   - Verify milestone assignment matches the parent epic (or designated sprint/milestone)
   - Ensure GitHub Project links, labels, and dependencies mirror epic taxonomy
   - Reconfirm every template section is complete and consistent with `$story` intent
   - **DO NOT IMPLEMENT OR WRITE ANY CODE.** This assignment remains planning-only.

2. **Return Story Object:**
   - Return the created story issue object (matching the structure documented above) to the calling workflow
   - The story object will be used by `create-stories-for-epic`, `breakdown-plan`, and downstream implementation workflows to:
     - Track progress of story creation and approvals
     - Enable automated validation, sequencing, and status reporting
     - Provide inputs for implementation, testing, and deployment assignments

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