# Assignment: Create Application Plan

## (create-app-plan)

### Goal

Your goal is to create a plan for application, using the template in Appendix A, based on a filled-out new application template.

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
14. Epic sub-issue have been created for each and every phase. (Use template in #Appendix B)
15. Phase sub-issues have been assigned to milestones.

### Assignment

Your assignment is to create a new application plan based on a filled-out application template. This involves systematic analysis of requirements, careful implementation following established guidelines, and delivery of a application plan that meets all specified criteria. You will use the template in #Appendix A as a template for the plan, and then fill in the details for the specific application.

The application template can be found in the `docs/` directory in a file called `ai-new-app-template.md`. The supporting files are linked to in that file and are also included in the same directory. These files contain all the necessary details about the application you need to create the plan for, including features, components, and requirements.

Specifically, you will:

1. Analyze the filled-out application template and linked supporting documents to understand requirements and expectations and then create a comprehensive plan, documented as an issue (use the template in # #Appendix A), for the development of the application. There is no coding in this assignment. It is strictly planning.

**Always follow instructions given here (generally) and specifically as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### References:

* Excellent examples of previously-completed plans created for different applications: 
    * https://github.com/nam20485/advanced-memory3/issues/12
    * https://github.com/nam20485/support-assistant/issues/2

### Detailed Steps

1. **Analyze the Application Template**
   - Review the provided application template and any linked documents
   - Identify all requirements, features, and components that need to be implemented
   - Understand the technology stack and design principles to be followed

2. **Design Plan**
   - Create a detailed design plan based on the new app template
   - Define the project structure, including directories, files, and naming conventions
   - Identify necessary frameworks, tools, and packages to be used
   - Plan for testing, documentation, containerization, and other mandatory requirements
   - Create Issue documenting plan from the #Appendix A plan template and iterate to gain approval from the orchestrator or stakeholders   
   - Import the issue labels using the `import-labels.ps1` and `.labels.json` files.
   - Milestones have been created and issues linked to the appropriate milestone.
3. **Create Epic Sub-Issues for Each Phase**
    -Create a detailed sub-issue subordinate from the main plan issue for each phase of the plan.
    - These sub-issues are epics.
    - The sub-issue title should be the phase name.
    - The per-phase epic sub-issues should contain all of the sub-tasks (called Stories therein) listed in that phase
    - Use the template in # #Appendix B below, as a template for the sub-issue epics. 


### Completion

Ask the stake-holder if they are happy with the plan and can approve it. If not then make the requested changes and iterate asking for approval and making changes until approval is gained. **DO NOT IMPLEMENT OR WRITE ANY CODE.** This assignment is planning only.
Ask the stake-holder for your next assignment.

## Appendix A: Application Plan Issue Template (Copy-Paste)

Use the template below when you “Create Issue documenting plan” in step 2. It aligns with the Acceptance Criteria and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Copy this into a new GitHub Issue and fill in the placeholders.

Template has been moved to [application-plan.md](/.github/ISSUE_TEMPLATE/application-plan.md)

---

## Appendix B: Application Plan Phases's Epic Sub-Issue Template (Copy-Paste)

Use the template below when you create a sub-issue for each phase in the application plan in step 4. It aligns with the Phases and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Create a sub-issue off of the main plan issue for each phase, using the template below, and then fill in the placeholders.

Template has been moved to [epic.md](/.github/ISSUE_TEMPLATE/epic.md)
