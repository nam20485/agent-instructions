# Assignment: Analyze Plan Issue

## (analyze-plan-issue)

### Input

**Repository** (optional)
- Default: Current workspace
- Example: `nam20485/my-project`
- Git repository containing the plan issue to analyze

**Issue Number** (required)
- Example: `42`
- The GitHub issue number containing the application plan

### Goal

Analyze an application development plan issue to:
- Determine fitness for implementation
- Identify gaps and areas requiring additional work
- Rate existing risk mitigations and propose new ones
- Identify missing acceptance criteria
- Assess overall development readiness
- Provide actionable recommendations
- Document findings in a comprehensive issue 

### Acceptance Criteria

1. New issue created documenting findings with clear analysis and recommendations.
2. Comprehensive repository analysis completed using all available tools and information.
3. Detailed findings documented with evidence sources for verification.
4. Clear documentation of all identified risks and mitigations.
5. Assessment of readiness for development with specific recommendations.
6. New issue linked to original if provided.
7. Gap analysis completed with prioritized recommendations.
8. Roundtable discussion conducted with relevant expert delegates.
9. Presentation of findings to stakeholder for review.
10. Stakeholder approval obtained for the analysis and recommendations.

### Assignment

Analyze the repository to assess implementation readiness and identify gaps in the plan issue. Conduct a roundtable discussion with delegates to review findings item-by-item. Document the agreed-upon results in a new issue.

**⚠️ CRITICAL: Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Delegate Roles

Include at least one delegate from each role (multiple delegates per role are allowed):
- Yourself (orchestrator)
- Project planner
- Product manager
- Backend developer
- Frontend developer
- QA engineer
- Researcher

### Detailed Steps

1. **Start by reading the issue if provided.**
   1. If no issue provided, check for `APP_PLAN.md` in the repository root.
   2. If neither an issue nor `APP_PLAN.md` file is found, inform the stakeholder that no plan was provided and that you cannot proceed.

2. **Conduct independent repository analysis:**
   - You and each delegate should independently perform the repository analysis steps below.

3. **Create initial draft findings:**
   - Create an initial draft list of findings and recommendations based on your analysis.
   - Include specific evidence for each finding (commits, files, features).
   - Prioritize recommendations by importance and effort required.

4. **Gather delegate input:**
   - Pass the draft list to each delegate for their review and addition of findings and recommendations.
   - Merge all delegate inputs into a single consolidated list.

5. **Conduct roundtable discussion:**
   - Review each item systematically with all delegates.
   - Have researcher delegate present any relevant background information or context.
   - Discuss each finding and recommendation in detail.
   - Resolve any disagreements through discussion and consensus.
   - Document the final agreed-upon findings and recommendations.
   - Ensure all delegates sign off on the final list before proceeding.
   
   **Example Discussion Flow:**
   ```
   1. Orchestrator: "Finding #1 - Missing CI/CD pipeline. Researcher, what's the industry standard?"
   2. Researcher: "Most modern projects use GitHub Actions with automated testing..."
   3. Backend Dev: "We should prioritize this as must-have because..."
   4. [Discussion continues until consensus]
   5. Orchestrator: "Agreed: Must-have, 3-day effort. Moving to Finding #2..."
   ```

6. **Categorize recommendations:**
   - Split recommendations into priority categories.
   
   **Prioritization Examples:**
   - **Must-haves**: Authentication system, database migrations, error handling
   - **Should-haves**: API documentation, logging framework, monitoring
   - **Nice-to-haves**: Admin dashboard, analytics integration, UI themes

7. **Present to stakeholder:**
7. **Present to stakeholder:**
   - Present the final list to the stakeholder for review and approval.

8. **Link and reference appropriately:**
   - If original issue provided, link the new issue using GitHub references (e.g., "Related to #123")
   - Reference specific commits, files, and branches in your analysis
   - Include links to relevant documentation or external resources

9. **Provide evidence and methodology:**
   - List all tools and sources used to make your determination
   - Include specific commands run and files analyzed
   - Document the branch with latest commits and the branch with most work completed
   - Include any assumptions or limitations in your analysis
   
   **Example Finding Format:**
   ```
   Finding: Missing database migration strategy
   Evidence: No migration scripts found in `/db/migrations`, no references in `package.json`
   Priority: Must-have
   Effort: Medium (2-3 days)
   Risk: High - could cause data loss in production deployment
   ```

10. **Quality validation:**
    - Review your analysis for completeness and accuracy
    - Ensure all major project components have been examined
    - Verify that recommendations are actionable and specific
    - Confirm that the new issue follows proper formatting and standards

#### Repository Analysis Steps

Each delegate performs these steps independently before the roundtable discussion:

**Conduct systematic repository analysis using all available tools and information:**
   - Use `semantic_search` and `grep_search` for comprehensive code analysis
   - Use `mcp_github_list_issues` to review all existing issues
   - Use `mcp_github_search_pull_requests` to analyze pull request history
   - Use `git log --oneline --graph --all` to examine commit history and branches
   - Use `read_file` to examine key documentation and configuration files
   - Review project structure, dependencies, and build configurations
   - Examine any workflow runs that exist

   **⚠️ CRITICAL: VERIFICATION REQUIREMENTS**
   - **DO NOT accept statements in issues, PRs, or documentation as factual without verification**
   - Base your analysis ONLY on what you can verify in the actual codebase, commits, and branches
   - Your job is to perform an independent investigation and establish the definitive factual state of the repository
   - You must evaluate all claims yourself and provide verifiable evidence for every assertion you make
   - Include a dedicated "Evidence Sources" section documenting exactly where each finding was discovered

1. **Analyze branch status and recent activity:**
   - Find the branch with the latest commits using `git branch -v --sort=-committerdate`
   - Identify the branch with the most work completed
   - Compare branches to understand development flow and current state

2. **If an issue was provided, perform targeted analysis:**
   - Detail the progress made against each item in the original issue
   - Identify any gaps or areas that need further work based on what was outlined
   - Cross-reference issue requirements with actual implementation

3. **Create comprehensive findings documentation:**
   - Document all completed work with evidence (commits, files, features)
   - Identify specific gaps and missing components
   - Prioritize recommendations by importance and effort required
   - Include risk assessment for incomplete items

4. **Create a new issue documenting your findings:**
   - Use clear, structured format with sections for completed work, gaps, and recommendations
   - If original issue provided, follow its structure and format
   - Include checkboxes: checked for completed work, unchecked for remaining tasks
   - Include original parts of the old issue, then add new sections for your findings
   - **Must include "Evidence Sources" section** documenting where each finding was discovered
   - Good examples of completed analyses:
       - https://github.com/nam20485/advanced-memory3/issues/17
       - https://github.com/nam20485/advanced-memory3/issues/20


### Completion

1. **Present findings to stakeholder:**
   - Inform the stakeholder that the analysis is complete
   - Present the new issue with issue number and summary
   - Provide direct link to the issue for review

2. **Stakeholder review process:**
   - Ask if they approve the analysis and recommendations
   - Address any questions or requests for clarification
   - Make revisions if needed based on feedback

3. **Finalization:**
   - Mark the analysis as complete once approved
   - Update any related project tracking or documentation
   - Prepare for next steps based on the identified gaps and recommendations
