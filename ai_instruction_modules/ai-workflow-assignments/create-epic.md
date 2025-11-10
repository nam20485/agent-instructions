# Assignment: Create Epic

## (create-epic)

### Goal

Create a single epic sub-issue for a specific phase from the main application plan. The epic will break down the phase into detailed stories and tasks, providing a comprehensive implementation roadmap for that phase.

### Inputs
- `$phase`: Phase object containing the phase name, description, requirements, and entire content from the parent plan issue

### Output
- Single epic sub-issue created and linked to the parent plan issue
- Epic contains detailed breakdown of stories and tasks for the phase
- Epic is assigned to the appropriate milestone
- Returns the created epic issue object for downstream processing

### Acceptance Criteria

1. Parent plan issue has been reviewed and the specified phase understood
2. Epic issue created using the official epic template from `.github/ISSUE_TEMPLATE/epic.md`
3. Epic title follows format: `[ProjectName] – [PhaseName] - Epic`
4. Epic contains complete breakdown of all stories within the phase
5. Each story lists detailed sub-tasks with checkboxes
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

Your assignment is to create a single epic sub-issue for one phase of an existing application plan. This involves:

1. Analyzing the parent plan issue to understand the phase requirements
2. Breaking down the phase into detailed stories and tasks
3. Creating a comprehensive epic issue using the official template
4. Properly linking the epic to the parent plan and milestone

The parent application plan issue should already exist and contain the high-level phases. You will be creating ONE epic for ONE specific phase as provided in the `$phase` input parameter.

This assignment is typically invoked by the `breakdown-plan` dynamic workflow, which orchestrates the creation of multiple epics from a plan issue.

**Always follow instructions given here and as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Issue Hierarchy Context

This assignment creates **Epics** at the second level of the issue hierarchy:

```
┌─────────────────────────────────────┐
│     Main Application Plan Issue     │  ← Top level: Overall application plan
└─────────────────────────────────────┘
                 │
        ┌────────┼────────┐
        │        │        │
┌───────▼──┐ ┌──▼──────┐ ┌▼────────┐
│ Phase 1  │ │ Phase 2 │ │ Phase 3 │
│  EPIC    │ │  EPIC   │ │  EPIC   │  ← **THIS LEVEL**: Epics created from phases
└──────────┘ └─────────┘ └─────────┘     (This assignment creates ONE of these)
     │            │           │
  ┌──┼──┐      ┌─┼─┐      ┌──┼──┐
  │  │  │      │ │ │      │  │  │
  ▼  ▼  ▼      ▼ ▼ ▼      ▼  ▼  ▼
Story1 2 3   Story4 5 6  Story7 8 9   ← Bottom level: Stories (granular tasks)
```

**Your Role:** You are creating ONE Epic for ONE Phase. The Epic will contain multiple Stories as sub-issues.

### References

* Excellent example of a completed epic sub-issue:
    * https://github.com/nam20485/advanced-memory3/issues/13 (Foundation & Core Services Epic)
    * https://github.com/nam20485/support-assistant/issues/3 (Phase 1 Epic)

* Example parent plan issues:
    * https://github.com/nam20485/advanced-memory3/issues/12
    * https://github.com/nam20485/support-assistant/issues/2

### Detailed Steps

1. **Review Phase Input**
   - Extract the phase name, description, and requirements from the `$phase` input
   - Identify the parent plan issue from the phase context
   - Understand the phase goals, requirements, and scope
   - Review the technology stack and architecture from the parent plan
   - Note the project structure and components involved in this phase

2. **Analyze Phase Requirements**
   - Extract all requirements and features for this specific phase
   - Identify the component(s) this phase belongs to
   - Understand dependencies and prerequisites from other phases
   - Clarify any ambiguous requirements with stakeholders
   - Review any referenced documentation (tech stack, architecture docs)

3. **Break Down Phase into Stories**
   - Divide the phase into logical stories (typically 3-5 stories per epic)
   - For each story, identify specific sub-tasks with clear deliverables
   - Ensure stories follow a logical sequence (foundation → core → integration → testing)
   - Include all mandatory requirements: testing, documentation, containerization, CI/CD
   - Add checkboxes for all tasks and sub-tasks

4. **Create Epic Issue**
   - Use the official epic template from `.github/ISSUE_TEMPLATE/epic.md`
   - Fill in all sections completely:
     - Overview: Concise summary of the epic
     - Project: Name of the project
     - Component: Specific component this epic implements
     - Goals: Clear, measurable goals
     - Technology Stack: Technologies specific to this epic
     - Epic Stories: List all stories
     - Component Architecture: Core services and key tasks
     - Project Structure Area: Highlight affected directories
     - Implementation Plan: Detailed breakdown of all stories with checkboxes
     - Mandatory Requirements: Testing, Docs, Build, Infrastructure sections
     - Acceptance Criteria: Specific and measurable
     - Risk Mitigation Strategies: Table of risks and mitigations
     - Timeline Estimate: Time estimate per story
     - Success Metrics: Measurable success indicators

5. **Link Epic to Plan**
   - Create the epic issue in the repository
   - Link the epic to the GitHub Project for unified tracking
   - Use GitHub's sub-issue feature to link the epic to the parent plan issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
   - Link the epic to the appropriate milestone matching the phase
   - Add the epic as a blocking dependency in the parent plan issue
     - Reference: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies
   - Apply appropriate labels (e.g., `epic`, `plan`, `phase-name`)

6. **Quality Validation**
   - Verify all template sections are completed (no placeholders remain)
   - Ensure all stories have detailed sub-tasks
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

**Note:** Stakeholder review of individual epics is not required. The orchestrating workflow will handle review of all epics after they are created.

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