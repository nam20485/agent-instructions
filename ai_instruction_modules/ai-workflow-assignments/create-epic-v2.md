# Assignment: Create Epic

## (create-epic)

### Goal

Transform a single task-list line item from a parent application plan into its own epic sub-issue. The epic inherits context from both the parent plan and phase while preserving the line item's checkbox-driven implementation guidance, providing a focused implementation roadmap for that specific line item.

### Inputs
- `$phase`: Phase object containing the phase name, description, requirements, and entire content from the parent plan issue including parent issue metadata
- `$line_item`: Line item object containing the identifier, title, description, acceptance criteria, dependencies, and source task-list structure from the parent plan

### Output
- Returns the created epic issue object containing the following data for downstream processing:
  - Epic issue ID: Unique identifier of the created epic issue
  - Epic issue URL: Full URL to access the created epic issue
  - Epic title: Title of the created epic issue
  - Parent issue ID: ID of the parent plan issue this epic is linked to
  - Phase context: The phase object that provided context for this epic
  - Line item data: The original line item object that was transformed into this epic

#### Structure of Returned Epic Issue Object
```json
{
  "id": 123456789,
  "url": "https://github.com/owner/repo/issues/123456789",
  "title": "[ProjectName] – [PhaseName] – [LineItemIdentifier] Epic",
  "parent_issue_id": 987654321,
  "phase": "$phase",
  "line_item": "$line_item"
}

### Acceptance Criteria

1. Parent plan issue has been reviewed and the specified phase and line item understood
2. Epic issue created using the official epic template from `.github/ISSUE_TEMPLATE/epic.md`
3. Epic title follows format: `[ProjectName] – [PhaseName] – [LineItemIdentifier] Epic`
4. Epic contains the preserved checkbox-driven task list from the line item
5. Epic contains high-level story bullets for downstream workflows (without nested tasks)
6. Technology stack specific to this epic/component is documented
7. Component architecture is clearly defined
8. Project structure area relevant to this epic is identified
9. All mandatory requirements sections are completed (Testing, Documentation, Build & Distribution, Infrastructure)
10. Acceptance criteria are specific and measurable
11. Risks and mitigation strategies are identified
12. Timeline estimates provided for each story
13. Success metrics defined
14. Epic is linked as a sub-issue to the parent plan issue using GitHub's sub-issue feature
15. Epic has been added to the GitHub Project
16. Epic is linked to the appropriate milestone
17. Epic is marked as blocking the parent plan issue
18. Epic issue object is returned for downstream workflow processing

### Assignment

Your assignment is to transform a single task-list line item from a parent application plan into its own epic sub-issue. This involves:

1. Analyzing the parent plan issue to understand the phase and line item requirements
2. Analyzing the line item to understand the specific implementation requirements and task hierarchy
3. Transforming the line item's task list into a checkbox-driven implementation plan within the epic
4. Creating a comprehensive epic issue from the line item using the official template
5. Properly linking the epic to the parent plan issue using GitHub's sub-issue feature

The parent application plan issue should already exist and contain the high-level phases with task-list line items. You will be creating ONE epic for ONE specific line item of ONE specific phase as provided in the $line_item input parameter.

This assignment is typically invoked by the `breakdown-plan` dynamic workflow, which orchestrates the creation of multiple line-item epics from a plan issue.

**Always follow instructions given here and as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Issue Hierarchy Context

This assignment creates **Line Item Epics** at the second level of the issue hierarchy:

```
┌─────────────────────────────────────┐
│     Main Application Plan Issue     │  ← Top level: Overall application plan
└─────────────────────────────────────┘
                 │
        ┌────────┼────────┐
        │        │        │
┌───────▼──┐ ┌──▼──────┐ ┌▼────────┐
│ Phase 1  │ │ Phase 2 │ │ Phase 3 │
│  (agg)   │ │  (agg)  │ │  (agg)  │  ← **THIS LEVEL**: Phase collections (aggregates)
└──────────┘ └─────────┘ └─────────┘
     │            │           │
 ┌──┼──┐      ┌─┼─┐      ┌──┼──┐
  │  │  │      │ │ │      │  │  │
  ▼  ▼ ▼      ▼ ▼ ▼      ▼ ▼ ▼
Epic1 2 3    Epic4 5 6 Epic7 8 9   ← **THIS LEVEL**: Line Item Epics (This assignment creates ONE of these)
  │  │      │   │      │ │ │
  │  │ │      │   │ │      │ │ │
 ▼ ▼ ▼      ▼   ▼ ▼      ▼ ▼ ▼
St1 St2 St3  St4  St5 St6  St7 St8 St9  ← Bottom level: Story Issues (created later)
```

**Your Role:** You are creating ONE Line Item Epic for ONE Phase. The Epic will contain checkbox-driven tasks from the line item and high-level story bullets for downstream workflows.

### References

* Excellent example of a completed epic sub-issue:
    * https://github.com/nam20485/advanced-memory3/issues/13 (Foundation & Core Services Epic)
    * https://github.com/nam20485/support-assistant/issues/3 (Phase 1 Epic)

* Example parent plan issues:
    * https://github.com/nam20485/advanced-memory3/issues/12
    * https://github.com/nam20485/support-assistant/issues/2

* GitHub Documentation:
    * GitHub Sub-Issues: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
    * GitHub Tasklists: https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/about-tasklists
    * GitHub Sub-Issues REST API: https://docs.github.com/en/rest/issues/sub-issues?apiVersion=2022-11-28
### Detailed Steps

1. **Review Phase and Line Item Input**
   - Extract the phase name, description, and requirements from the `$phase` input
   - Identify the parent plan issue from the phase context
   - Extract the line item identifier, title, description, acceptance criteria, dependencies, and source task-list structure from the `$line_item` input
   - Understand the phase and line item goals, requirements, and scope
   - Review the technology stack and architecture from the parent plan
   - Note the project structure and components involved in this line item

2. **Analyze Line Item Requirements**
   - Extract all requirements and features for this specific line item
   - Identify the component(s) this line item belongs to
   - Understand dependencies and prerequisites from other line items or phases
   - Clarify any ambiguous requirements with stakeholders
   - Review any referenced documentation (tech stack, architecture docs)

3. **Transform Line Item Task List**
   - Extract the checkbox-driven task list from the line item in the parent plan
   - Preserve the numbering and hierarchy of tasks (e.g., 1.1, 1.1.1, 1.1.2, etc.)
   - Convert the task list into the Implementation Plan section of the epic
   - Add clarifying context where needed for the tasks

4. **Outline High-Level Stories**
   - Draft 3-5 high-level story bullets that will be implemented later by downstream workflows
   - Ensure stories follow a logical sequence (foundation → core → integration → testing)
   - Include ownership notes and sequencing information
   - Do not add nested tasks or checkboxes to these story bullets

5. **Create Epic Issue**
   - Use the official epic template from `.github/ISSUE_TEMPLATE/epic.md`
   - Fill in all sections completely:
     - Overview: Concise summary of the epic
     - Project: Name of the project
     - Component: Specific component this epic implements
     - Goals: Clear, measurable goals
     - Technology Stack: Technologies specific to this epic
     - Epic Stories: List all high-level story bullets (without nested tasks)
     - Component Architecture: Core services and key tasks
     - Project Structure Area: Highlight affected directories
     - Implementation Plan: Detailed breakdown of the line item's checkbox-driven tasks
     - Mandatory Requirements: Testing, Docs, Build, Infrastructure sections
     - Acceptance Criteria: Specific and measurable
     - Risk Mitigation Strategies: Table of risks and mitigations
     - Timeline Estimate: Time estimate per story
     - Success Metrics: Measurable success indicators

6. **Link Epic to Plan**
   - Create the epic issue in the repository
   - Link the epic to the GitHub Project for unified tracking
   - Use GitHub's sub-issue feature to link the epic to the parent plan issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
   - Link the epic to the appropriate milestone matching the phase
   - Add the epic as a blocking dependency in the parent plan issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies
   - Apply appropriate labels (e.g., `epic`, `plan`, `phase-name`, `line-item-epic`)

7. **Quality Validation**
   - Verify all template sections are completed (no placeholders remain)
   - Ensure the checkbox-driven task list is properly preserved
   - Confirm high-level story bullets are present without nested tasks
   - Confirm mandatory requirements are addressed
   - Validate timeline estimates are reasonable
   - Check that risks are identified with mitigations
   - Ensure acceptance criteria are measurable

### Completion

1. **Finalize Epic:**
   - Confirm epic is properly linked as sub-issue to parent plan
   - Verify milestone assignment is correct
   - Ensure epic is marked as blocking the parent issue
   - Verify all template sections are complete
   - **DO NOT IMPLEMENT OR WRITE ANY CODE.** This assignment is planning only.

2. **Return Epic Object:**
   - Return the created epic issue object to the calling workflow
   - The epic object will be used by the `breakdown-plan` workflow to:
     - Extract stories for the `create-story-v2` assignment (if `$PARALLEL_EPIC_BREAKDOWN` is true)
     - Track progress of epic creation
     - Enable downstream workflow processing
**Note:** Stakeholder review of individual epics is not required. The orchestrating workflow will handle review of all epics after they are created. The epic created by this assignment will contain checkbox-driven tasks from the line item and high-level story bullets for future story creation workflows.


## Epic Template Reference

The official epic template is located at:
`.github/ISSUE_TEMPLATE/epic.md`

Use this template when creating the epic issue. It contains the complete structure including:
- Overview and goals
- Technology stack
- Epic stories breakdown
- Component architecture
- Implementation plan with detailed sub-tasks
- Mandatory requirements sections
- Acceptance criteria
- Risk mitigation strategies
- Timeline estimates
- Success metrics