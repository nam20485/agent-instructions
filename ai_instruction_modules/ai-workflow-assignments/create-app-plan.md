# Assignment: Create Application Plan

## (create-app-plan)

### Goal

Your goal is to create a plan for application, using the template in Appendix A, based on a filled-out new application template and its supporting documents.

### Acceptance Criteria

1. Application template has been thoroughly analyzed and understood
2. Plan's project structure has been created according to established guidelines and plan
3. Template from Appendix A has been used as a template for the plan.
4. Plan contains detailed breakdown of all phases required to achieve complete implementation.
5. All phases list important steps required to achieve completion of that phase.
6. All required components and dependencies have been planned.
7. Application plan follows the specified technology stack and design principles
8. All mandatory application requirements have been addressed in plan. (testing, documentation, containerization, etc.)
9. All acceptance criteria from the template have been addressed in the plan.
10. All risks and mitigations identified.
11. Code quality standards and best practices have been followed.
12. Application plan is ready for development and implementation.
13. Application plan has been documented in an issue using the template in #Appendix A.
14. Milestones have been created and issues linked to the appropriate milestone.
15. Created issue has been added to the GitHub Project for tracking.
16. Created issue has been assigned to the appropriate milestone (typically "Phase 1: Foundation").
17. Appropriate labels have been applied to the issue (typically "planning", "documentation").

### Assignment

Your assignment is to create a new application plan based on a filled-out application template and its supporting documents. This involves systematic analysis of requirements, careful implementation following established guidelines, and delivery of a application plan that meets all specified criteria. You will use the template in #Appendix A as a template for the plan, and then fill in the details for the specific application.

The application template can be found in the `plan_docs/` directory in a file called `ai-new-app-template.md`. The supporting files are linked to in that file and are also included in the same directory. These files contain all the necessary details about the application you need to create the plan for, including features, components, and requirements.

Specifically, you will:

1. Analyze the filled-out application template and linked supporting documents to understand requirements and expectations and then create a comprehensive plan, documented as an issue (use the template in #Appendix A), for the development of the application. There is no coding in this assignment. It is strictly planning. Create the milestones and link the issues to the appropriate milestone.

**Always follow instructions given here and as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

## Before Starting

Before beginning this assignment, complete these preparation steps:

### 1. Read Assignment Completely

- Read through all detailed steps
- Understand the overall goal
- Review acceptance criteria
- Note any dependencies on other assignments
- Identify potential challenges

### 2. Gather Context

- Review previous assignment outputs
  - Check what files were created
  - Understand current project state
  - Verify previous work is complete
- Check for related issues or PRs
  - Search for similar work
  - Review any existing discussions
  - Check for known issues
- Review project documentation
  - Read README and setup guides
  - Check architecture documentation
  - Review coding standards
- Understand current state
  - What's already been done
  - What's left to do
  - Any blockers or dependencies

### 3. Verify Prerequisites

- Check that required tools are installed
  - GitHub CLI for issue/milestone creation
  - Git for repository access
  - Markdown editor/viewer
- Verify previous assignments completed
  - Repository initialized
  - Check acceptance criteria were met
  - Verify outputs are available
  - Confirm no blockers exist
- Ensure dependencies are met
  - Access to `plan_docs/` directory
  - `ai-new-app-template.md` exists and is filled out
  - Supporting documents are available
- Confirm environment is ready
  - GitHub permissions for issue/milestone creation
  - Repository access configured
  - Able to read/write files

### 4. Create Task List

- Break down steps into specific tasks
  - Review application template (~15 min)
  - Analyze supporting documents (~15 min)
  - Design plan structure (~20 min)
  - Create issue from template (~10 min)
  - Create milestones (~10 min)
  - Iterate on feedback (~variable)
- Identify potential challenges
  - Understanding complex requirements
  - Unclear or ambiguous specifications
  - Technology choices and justifications
  - Stakeholder approval iterations
- Note any questions or uncertainties
  - What needs clarification from stakeholders
  - What might need research
  - What could be interpreted differently
- Plan the approach
  - Order of analysis activities
  - When to seek stakeholder input
  - Checkpoints for validation

### 5. Estimate Time

- Review estimated time for assignment
  - Baseline: 45-60 minutes
  - Consider assignment complexity
- Consider your specific context
  - Familiarity with application domain
  - Complexity of requirements
  - Number of supporting documents
  - Stakeholder availability for feedback
- Add buffer for unexpected issues
  - 20-30% buffer recommended
  - More for complex/novel requirements
  - Account for iteration cycles
- Plan accordingly
  - Schedule uninterrupted time
  - Plan for stakeholder check-ins
  - Set realistic expectations

### 6. Prepare Environment

- Set up workspace
  - Open `plan_docs/` directory
  - Have application template ready
  - Open issue template file
  - Prepare note-taking tool
- Gather required resources
  - Reference examples (GitHub issues linked)
  - GitHub issue template location
  - Milestone naming conventions
  - Tech stack documentation
- Create backup if needed
  - Save current work state
  - Commit any pending changes
  - Document starting point

**Only proceed once all preparation steps are complete.**

### References:

* Excellent examples of previously-completed plans created for different applications: 
    * https://github.com/nam20485/advanced-memory3/issues/12
    * https://github.com/nam20485/support-assistant/issues/2

### Detailed Steps

1. **Analyze the Application Template**
   - Review the provided application template and any linked documents
   - Identify all requirements, features, and components that need to be implemented
   - Understand the technology stack and design principles to be followed
   - Identify and clarify any ambiguous or unclear requirements with stakeholders
   - Identify languages, frameworks, tools, and packages to be used. Document in `plan_docs/tech-stack.md`.
   - Document high level architecture, components, and design decisions in `plan_docs/architecture.md`.

2. **Design Plan**
   - Create a detailed design plan based on the new app template
   - Define the project structure, including directories, files, and naming conventions
   - Identify necessary frameworks, tools, and packages to be used
   - Plan for testing, documentation, containerization, and other mandatory requirements
   - Create Issue documenting plan from the #Appendix A plan template and iterate to gain approval from the orchestrator or stakeholders
   - Create milestones based on the phases in the plan using `gh api` or the GitHub CLI
   - Link created issue to the GitHub Project for unified tracking
   - Assign issue to appropriate milestone (typically the first phase: "Phase 1: Foundation")
   - Apply appropriate labels to issue from the imported label set (typically: "planning", "documentation")

## Progress Reporting

This assignment has multiple steps and may take 45-60 minutes. Report progress at these checkpoints:

### Checkpoint 1: Template Analysis Complete (25% complete)

**Tasks**:
- [ ] Application template reviewed and understood
- [ ] Supporting documents analyzed
- [ ] Requirements identified and documented
- [ ] Ambiguities identified for clarification

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 1 Complete (25%)
- Completed: Reviewed ai-new-app-template.md and 3 supporting docs
- Issues: Found 2 ambiguous requirements, need stakeholder clarification
- Time remaining: ~40 minutes
- Next: Design plan structure
```

---

### Checkpoint 2: Plan Structure Designed (50% complete)

**Tasks**:
- [ ] Tech stack identified and documented
- [ ] Architecture documented
- [ ] Project structure defined
- [ ] Phases and milestones outlined

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 2 Complete (50%)
- Completed: Created tech-stack.md and architecture.md, defined 5 phases
- Issues: None
- Time remaining: ~25 minutes
- Next: Create GitHub issue from template
```

---

### Checkpoint 3: Issue and Milestones Created (75% complete)

**Tasks**:
- [ ] Issue created from application-plan template
- [ ] All plan sections filled out
- [ ] Milestones created in GitHub
- [ ] Issues linked to milestones

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 3 Complete (75%)
- Completed: Created issue #5 with full plan, 5 milestones created
- Issues: None
- Time remaining: ~15 minutes
- Next: Stakeholder review and iteration
```

---

### Final Checkpoint: Plan Approved (100%)

**Tasks**:
- [ ] Stakeholder feedback incorporated
- [ ] All acceptance criteria verified
- [ ] Plan approved by stakeholder
- [ ] Documentation complete

**Report**: Provide final summary including:
- All completed work
- Total time taken
- Any issues resolved
- Final status

**Example Report**:
```
✅ Assignment Complete (100%)
- Completed: Application plan approved after 2 iteration rounds
- Total time: 55 minutes
- Issues resolved: Clarified 2 requirements, adjusted 1 milestone scope
- Status: Ready for implementation phase
```

---

### How to Report Progress

After completing each checkpoint, provide a brief update including:

1. **What was completed**:
   - List specific tasks finished
   - Highlight major milestones
   - Note any deliverables created

2. **Any issues encountered**:
   - Describe problems faced
   - Explain how they were resolved
   - Note any ongoing concerns

3. **Estimated time remaining**:
   - Calculate based on progress
   - Adjust for complexity
   - Account for any delays

4. **Next steps**:
   - What comes next
   - Any dependencies
   - Expected timeline

### Progress Tracking Tips

- **Be honest about progress**: Don't overestimate completion
- **Report blockers immediately**: Don't wait until the end
- **Update estimates**: Adjust time estimates as you learn more
- **Document issues**: Keep notes on problems and solutions
- **Celebrate milestones**: Acknowledge progress at each checkpoint

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: Application Template Not Found or Incomplete
- **Symptoms**: Missing `ai-new-app-template.md`, empty file, missing sections
- **Possible Causes**: 
  - Previous assignment not completed
  - File moved or renamed
  - Template not filled out properly
- **Solutions**:
  1. Verify file exists in `plan_docs/` directory
  2. Check if file is in different location
  3. Review previous assignment completion
  4. Request stakeholder to complete template if empty
  5. Do not proceed without complete template

#### Error: Supporting Documents Missing or Invalid
- **Symptoms**: Broken links, missing files, incomplete documents
- **Possible Causes**:
  - Links not updated after file creation
  - Files not committed to repository
  - Documents partially completed
- **Solutions**:
  1. Check all links in application template
  2. Search repository for missing files
  3. Request stakeholder to provide missing documents
  4. Document which documents are missing
  5. Clarify with stakeholder if documents are optional

#### Error: Requirements Ambiguous or Contradictory
- **Symptoms**: Unclear specifications, conflicting requirements
- **Possible Causes**:
  - Template filled out hastily
  - Evolving requirements
  - Multiple stakeholders with different visions
- **Solutions**:
  1. Document all ambiguities clearly
  2. Prepare specific questions for stakeholder
  3. Request clarification before proceeding with plan
  4. Do not make assumptions about unclear requirements
  5. Document all assumptions made if forced to proceed

#### Error: Cannot Create GitHub Issue
- **Symptoms**: Permission denied, API errors, template not found
- **Possible Causes**:
  - Insufficient GitHub permissions
  - GitHub CLI not authenticated
  - Template file moved or deleted
- **Solutions**:
  1. Verify GitHub CLI authentication: `gh auth status`
  2. Check repository permissions (need write access)
  3. Verify template exists at `.github/ISSUE_TEMPLATE/application-plan.md`
  4. Try creating issue via GitHub web UI as fallback
  5. Check GitHub service status if API errors persist

#### Error: Cannot Create Milestones
- **Symptoms**: Milestone creation fails, permission errors
- **Possible Causes**:
  - Insufficient permissions
  - Milestones already exist
  - GitHub API issues
- **Solutions**:
  1. Check if milestones already exist: `gh api repos/:owner/:repo/milestones`
  2. Verify you have write/admin access to repository
  3. Use different milestone names if conflicts exist
  4. Create milestones via GitHub web UI if CLI fails
  5. Link issues to existing milestones if appropriate

#### Error: Stakeholder Not Available for Feedback
- **Symptoms**: No response to approval requests, delayed feedback
- **Possible Causes**:
  - Stakeholder busy or unavailable
  - Unclear communication
  - Wrong stakeholder contacted
- **Solutions**:
  1. Document plan status and wait for availability
  2. Send clear, specific request for feedback with deadline
  3. Highlight areas that need decision/approval
  4. Identify alternative stakeholder if primary unavailable
  5. Do not proceed to implementation without approval

#### Error: Tech Stack Choices Rejected
- **Symptoms**: Stakeholder rejects technology choices in plan
- **Possible Causes**:
  - Mismatch with organizational standards
  - Concerns about maintainability/support
  - Cost or licensing issues
  - Team expertise gaps
- **Solutions**:
  1. Request clarification on preferred technologies
  2. Document rationale for original choices
  3. Research and propose alternatives
  4. Update tech-stack.md with approved technologies
  5. Ensure architecture.md reflects technology changes

### Escalation Procedure

If errors persist after troubleshooting:

1. **Document the Error**:
   - Full description of the problem
   - What was expected vs what happened
   - Which documents/files are involved
   - What solutions were attempted
   - Current blocker status

2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug", "planning", "blocker"
   - Link to this assignment
   - Include all relevant context

3. **Notify User**:
   - Report the blocker to the user/stakeholder
   - Provide clear description of impact
   - Request specific decisions or actions needed
   - Suggest alternatives if possible

4. **Do Not Proceed**:
   - Do not mark assignment as complete
   - Do not proceed to implementation assignments
   - Wait for error resolution and approval
   - Document the blocker and timeline

### Rollback Procedure

If changes need to be reverted:

1. **Assess Impact**:
   - Check what was created (issue, milestones, files)
   - Identify what needs to be removed
   - Verify no dependent work has started

2. **Perform Rollback**:
   - Close GitHub issue: `gh issue close <number>`
   - Delete milestones via GitHub UI (no CLI command)
   - Remove created files: `git rm plan_docs/tech-stack.md plan_docs/architecture.md`
   - Revert any file changes: `git checkout -- <files>`
   - Commit rollback: `git commit -m "Rollback: create-app-plan"`

3. **Verify Rollback**:
   - Confirm issue closed: `gh issue list`
   - Check milestones removed via GitHub UI
   - Verify files removed: `ls plan_docs/`
   - Confirm repository state restored

4. **Document Rollback**:
   - Document what was rolled back and why
   - Record lessons learned
   - Update blocker issue with rollback details
   - Plan corrective action before retry

### Prevention Tips

To avoid common errors:

1. **Before Starting**:
   - Verify application template is complete and approved
   - Check all supporting documents exist and are accessible
   - Ensure GitHub permissions are adequate
   - Confirm stakeholder availability for feedback
   - Review reference examples to understand expected quality

2. **During Execution**:
   - Seek clarification immediately when requirements unclear
   - Document all assumptions and decisions
   - Create draft plan early for stakeholder feedback
   - Validate milestone names against conventions
   - Test GitHub CLI commands before bulk operations

3. **After Completion**:
   - Verify all acceptance criteria are met
   - Confirm all milestones created and linked
   - Ensure plan issue has all required sections
   - Get explicit stakeholder approval before marking complete
   - Review plan against reference examples for quality

### Completion

- Ask the stake-holder if they are happy with the plan and can approve it. If not then make the requested changes and iterate asking for approval and making changes until approval is gained.
- **DO NOT IMPLEMENT OR WRITE ANY CODE.** 
- This assignment is planning only.
- Ask the stake-holder for your next assignment.

## Appendix A: Application Plan Issue Template (Copy-Paste)

Use the template below when you “Create Issue documenting plan” in step 2. It aligns with the Acceptance Criteria and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Copy this into a new GitHub Issue and fill in the placeholders.

**TEMPLATE MOVED**.

Template has been moved to [application-plan.md](/.github/ISSUE_TEMPLATE/application-plan.md) file under the [.github/ISSUE_TEMPLATE/](/.github/ISSUE_TEMPLATE/) directory in the root of the repository.


