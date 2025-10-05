# Assignment: Update Plan Issue

## (update-plan-issue)

### Input

**Repository** (optional)
- Default: Current workspace
- Example: `nam20485/my-project`
- Git repository containing the plan issue to analyze

**Issue Number** (optional)
- Example: `42`
- The GitHub issue number containing the application plan
- If not provided, will look for `APP_PLAN.md` in repository root

**Feedback File** (required)
- Example: `PLAN_ANALYSIS.md`
- Path to file containing the analysis results to use for updating the plan issue
- File should be in the repository root or provide full relative path
- Format: Markdown file with structured findings and recommendations

### Goal

Create a new, updated version of the original plan issue by incorporating findings and recommendations from the analysis file. The new issue will serve as the revised application development plan with all identified improvements applied.

**What "Apply Findings" Means:**
- Integrate recommendations from analysis file into corresponding plan sections
- Rewrite unclear or problematic sections based on feedback
- Add new sections for missing components identified in analysis
- Update task lists with additional requirements discovered
- Maintain original structure while enhancing content with findings

### Acceptance Criteria

1. New issue created which is findings from analysis file applied to original plan issue.
2. New issue has comment attached with:
   1. Linking to original plan issue
   2. Summary of changes made
   3. Link to analysis file used

### Assignment

1. Create a new issue in the specified repository.
2. Apply findings from the analysis file to the original plan issue.
3. Attach a comment to the new issue with:
   1. Linking to the original plan issue
   2. Summary of changes made
   3. Link to the analysis file used

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
   - You and each delegate should independently perform the repository analysis steps (see "Repository Analysis Steps" section below).
   - Each delegate documents their findings separately before the roundtable discussion.

3. **Create analysis findings draft:**
   - Create an initial draft list of findings and recommendations based on your independent analysis.
   - This is NOT the new issue itself - it's a working document to consolidate observations.
   - Include specific evidence for each finding (commits, files, features).
   - Prioritize recommendations by importance and effort required.

4. Orchestrator review findings and gives copy to all delegates for review.

5. Systematically process each finding, item by item:   

   1. **Gather delegate input:**
      - Pass the draft list to each delegate for their review and addition of findings and recommendations.
      - Merge all delegate inputs into a single consolidated list.

   2. **Conduct roundtable discussion:**
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
   
   3. **Document consensus and resolve conflicts:**
      - Document the final agreed-upon findings and recommendations in the draft.
      - If consensus cannot be reached on any item, the orchestrator makes the final decision after hearing all perspectives.
      - Ensure all delegates sign off on the final list before proceeding.

6. **Create the new plan issue:**
   - Draft the new issue following the structure of the original plan (if provided) or standard plan format.
   - For sections where analysis identified improvements: Apply the findings by rewriting or enhancing content.
   - For sections unchanged by analysis: Copy them verbatim from the original plan issue.
   
   **How to identify unchanged vs changed sections:**
   - Review each finding in the consolidated analysis
   - Map each finding to specific sections of the original plan
   - Sections not mentioned in any finding = unchanged (copy verbatim)
   - Sections mentioned in findings = changed (apply improvements)
   
   **New Issue Structure:**
   ```markdown
   # [Original Plan Title] - Updated
   
   ## Overview
   [Enhanced based on findings, or original if no changes needed]
   
   ## [Section Name]
   [Apply findings or copy original content]
   
   ## Evidence Sources
   [Document where findings came from - required section]
   ```
     

7. **Present to stakeholder:**
   - Present the new issue draft to the stakeholder for review and approval.

8. **Link and reference appropriately:**
   - If original issue provided, link the new issue using GitHub references (e.g., "Related to #123")
   - Reference specific commits, files, and branches in your analysis
   - Include links to relevant documentation or external resources
   - Document this in a comment to the new issue, not in the new issue body itself

9. **Provide evidence and methodology:**
   - List all tools and sources used to make your determination
   - Include specific commands run and files analyzed
   - Document the branch with latest commits and the branch with most work completed
   - Include any assumptions or limitations in your analysis
   - Document in comment attached to new issue
   

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
   - Mark the update as complete once approved
   - Update any related project tracking or documentation
   - Prepare for next steps based on the identified gaps and recommendations
