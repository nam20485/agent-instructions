# Assignment: Create Application Plan

## (create-app-plan)

### Goal

Your goal is to create a plan for application, using the template in Appendix A, based on a filled-out new application template and its supporting documents.

### Acceptance Criteria

1. Application template has been thoroughly analyzed and understood
2. Plan's project structure has been documented according to established guidelines and plan
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

### Important: Planning Only - No Implementation

This assignment is **PLANNING ONLY**. You will:
- ✅ Document the plan in an issue
- ✅ Create planning documents (tech-stack.md, architecture.md)
- ✅ Create milestones and link issues
- ✅ Link plan to GitHub Project
- ❌ NOT create any project files (.csproj, .sln, source code, etc.)
- ❌ NOT write any implementation code
- ❌ NOT create application directory structures

All implementation happens in subsequent assignments (create-application-foundation, create-application-structure, etc.).

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
   - Document the planned project structure, including directories, files, and naming conventions
   
   **Note**: You are documenting the PLAN for the project structure, not creating the actual directories or files. Actual file creation happens in the 'create-application-foundation' assignment.
   - Identify necessary frameworks, tools, and packages to be used
   - Plan for testing, documentation, containerization, and other mandatory requirements
   - Create Issue documenting plan from the #Appendix A plan template and iterate to gain approval from the orchestrator or stakeholders
   - Create milestones based on the phases in the plan using `gh api` or the GitHub CLI
   - Link created issue to the GitHub Project for unified tracking
   - Assign issue to appropriate milestone (typically the first phase: "Phase 1: Foundation")
   - Apply appropriate labels to issue from the imported label set (typically: "planning", "documentation")



### Events

#### `pre-assignment-begins`

This event runs before the assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begins.gather-context`

#### `on-assignment-failure`

This event runs if the assignment fails to recover from errors systematically.

- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-completion`

This event runs after the assignment completes to report progress.

- assign the agent the `report-progress` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.post-assignment-completion.report-progress`

### Completion

- Ask the stake-holder if they are happy with the plan and can approve it. If not then make the requested changes and iterate asking for approval and making changes until approval is gained.
- **DO NOT IMPLEMENT OR WRITE ANY CODE.** 
- This assignment is planning only.
- Ask the stake-holder for your next assignment.

## Appendix A: Application Plan Issue Template (Copy-Paste)

Use the template below when you “Create Issue documenting plan” in step 2. It aligns with the Acceptance Criteria and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Copy this into a new GitHub Issue and fill in the placeholders.

**TEMPLATE MOVED**.

Template has been moved to [application-plan.md](/.github/ISSUE_TEMPLATE/application-plan.md) file under the [.github/ISSUE_TEMPLATE/](/.github/ISSUE_TEMPLATE/) directory in the root of the repository.


