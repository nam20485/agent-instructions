# Assignment: Continuous Improvement Implementation

## (continuous-improvement)

<!-- version: v1 -->

### Goal

Convert an approved debrief report into an actionable continuous improvement program by prioritizing remediation opportunities, executing the highest-impact/lowest-risk changes immediately, and aligning stakeholders on the remaining improvement backlog.

### Prerequisites

- The `debrief-and-document` assignment has been completed and approved, and the finalized debrief report is accessible (path recorded in the debrief handoff).
- You have write access to update repository documentation and implement code/process fixes that emerge from the improvement plan.
- An independent validation agent (e.g., `qa-test-engineer`) is available to review the improvement plan and confirm implemented fixes.
- Branch protection rules, testing requirements, and deployment guardrails for the target repository are known.

> For GitHub permissions-related issues, refer to [scripts/test-github-permissions.ps1](../../scripts/test-github-permissions.ps1) and [scripts/gh-auth.ps1](../../scripts/gh-auth.ps1) for validation and authentication support.

### Acceptance Criteria

1. All improvement opportunities requiring remediation are extracted from the debrief report and captured with value, risk/complexity, ratio, owner, evidence source, and recommended action.
2. `docs/continuous-improvement/continuous-improvement.md` exists (or is updated) with clearly labeled sections for prioritized ratio bands, including scoring methodology, ranked tables, and narrative context for each improvement group.
3. The improvement plan is reviewed by an independent agent (e.g., `qa-test-engineer`), feedback is documented, and all actionable feedback is incorporated with traceable resolution notes.
4. Every item in the "High Value : Low Risk/Complexity" and "Moderate Value : Low Risk/Complexity" sections is implemented, validated (tests/builds as applicable), and annotated in the plan with evidence links and status.
5. A progress update is delivered to the user summarizing completed improvements, documenting outstanding items, and requesting explicit approval (or deferral) for remaining backlog sections.
6. A final report is recorded inside `docs/continuous-improvement/continuous-improvement.md` (or a linked appendix) summarizing outcomes, metrics, approvals, and next steps, and all artifacts are committed and pushed.

### Assignment

Leverage the debrief report to identify improvement opportunities, prioritize them using a value-to-risk/complexity ratio, and transform the analysis into a structured, continuously maintained improvement plan. Execute the highest-leverage, lowest-risk actions immediately, obtain stakeholder alignment on follow-on work, and document final outcomes for future audits.

### Detailed Steps

#### 1. Locate and Parse the Debrief Report

1. Retrieve the finalized debrief report path from the prior assignment handoff or repository logs.
2. Validate that the report reflects the approved version (stakeholder sign-off recorded, no pending revisions).
3. Note key metadata: report author, approval date, scope, and any linked artifacts (issues, PRs, documents).

#### 2. Extract Improvement Candidates

1. Review the debrief sections that capture gaps or future work, including (at minimum):
   - **Section 6. What Could Be Improved**
   - **Section 7. Errors Encountered and Resolutions** (focus on unresolved or workaround-level items)
   - **Section 8. Complex Steps and Challenges**
   - **Section 9. Suggested Changes**
   - **Section 11. Future Recommendations** (short/medium/long term items)
2. For each item needing improvement or fixes, capture:
   - Unique identifier (e.g., CI-001)
   - Source section and page/heading reference
   - Current pain point / defect description
   - Proposed improvement or fix
   - Dependencies or prerequisites
   - Supporting evidence (log links, issue/PR references, metrics)
3. Record the initial list in a working table (spreadsheet, markdown table, or structured JSON) to facilitate scoring.

#### 3. Score Value vs. Risk/Complexity

1. Define a numeric scoring rubric:
   - **Value Impact (1–5):**
     - 5 = Critical business/customer/system impact
     - 3 = Meaningful quality or productivity gains
     - 1 = Minor enhancement or cosmetic improvement
   - **Risk/Complexity (1–5):**
     - 1 = Low effort, minimal dependencies, low risk
     - 3 = Moderate effort or coordination required
     - 5 = High effort, complex dependencies, or significant risk of regression
2. For each improvement item, assign value and risk/complexity scores based on evidence from the debrief and repository context.
3. Calculate the ratio `value_score / risk_score` (higher is better). Record the ratio to two decimal places.
4. Capture rationale for each score (e.g., metrics, stakeholder quotes, failure modes) to make prioritization auditable.

#### 4. Prioritize and Segment the Backlog

1. Sort the improvement items in descending order by ratio (breaking ties by higher value score, then lower risk score).
2. Categorize items into the following sections:
   - **Section A: High Value : Low Risk/Complexity** (ratio ≥ 3.0 and value ≥ 4, risk ≤ 2)
   - **Section B: Moderate Value : Low Risk/Complexity** (ratio between 2.0 and 3.0, risk ≤ 2)
   - **Section C: Remaining Items** (all other combinations, including higher-risk initiatives)
3. For each section, summarize the overarching themes (e.g., “Improve validation guardrails”, “Upgrade deployment pipeline”).
4. Identify quick wins (expected completion ≤ 1 day) and highlight them for immediate execution.

#### 5. Create `continuous-improvement.md`

1. Create (or update) `docs/continuous-improvement/continuous-improvement.md` with the following structure:
   - Introduction (context, scope, stakeholders, last updated timestamp)
   - Scoring methodology (rubric, ratio formula, decision thresholds)
   - Consolidated backlog table with columns: ID, Description, Value, Risk, Ratio, Owner, Evidence, Recommended Action, Status
   - Dedicated subsections for Section A, Section B, and Section C containing narrative summaries and bullet-level action items
   - Open questions, dependencies, and required follow-ups
   - Final Report placeholder to be completed in a later step
2. Ensure tables are readable (consider Markdown table formatting or embed CSV/JSON references if large).
3. Cross-link to source sections in the debrief and any existing GitHub issues/PRs.
4. Commit interim drafts only after validation; otherwise maintain drafts locally until reviewer sign-off.

#### 6. Build the Execution Plan

1. For Sections A and B, define execution details for each item:
   - Required tasks or sub-assignments (e.g., which workflow assignments to invoke)
   - Estimated time/effort and owners
   - Acceptance criteria or success metrics for each fix
   - Validation steps (tests, builds, deployments, documentation updates)
2. Map Section C items to longer-term roadmap buckets (short, medium, long term) and note what approvals or dependencies are needed before implementation.
3. Update the document with the plan, including a Gantt-style timeline or milestone table if helpful.

#### 7. Independent Review and Feedback Loop

1. Delegate the plan to an independent agent such as `qa-test-engineer` (or a domain-specific reviewer) for validation.
2. Provide the reviewer with:
   - The debrief report
   - The scoring rubric and backlog table
   - The draft `continuous-improvement.md`
3. Request feedback on scoring accuracy, prioritization logic, completeness, and implementation feasibility.
4. Record reviewer feedback directly in the document (e.g., feedback log table) along with resolution status.
5. Incorporate required changes, updating scores or plan details as needed. Document rationales for any feedback you choose not to adopt (requires stakeholder approval).

#### 8. Implement Priority Improvements (Sections A & B)

1. For each item in Sections A and B:
   - Execute the necessary workflow assignments (e.g., `perform-task`, `update-from-feedback`, or domain-specific assignments) to implement the fix.
   - Follow repository guardrails: branch strategy, code review, testing, deployment procedures.
   - Run and document required validations (unit tests, integration tests, linters, build pipelines, manual checks).
   - Update the backlog table with status `Complete`, evidence links (PRs, commits, tickets), and validation outcomes.
2. If a fix cannot be completed immediately, document blockers, mitigation steps, and a scheduled follow-up date, then surface to the user for decision.
3. If any Section A or B item uncovers new high-value, low-risk issues during implementation, pause and re-evaluate the backlog. Consider promoting these new items into Section A or B and adjust the plan accordingly before proceeding further.
4. If any Section A or B item is found to be unfeasible during implementation, document the reasons and re-evaluate its importance and priority. Document and skip if necessary.
5. **IMPORTANT** If any identified change is too risky, or long, or required too complex or too many files changed, DO NOT implement unattended. Document and skip.

#### 9. Report Progress and Seek Approval

1. Summarize completed work:
   - Changes implemented, files/issues updated, validation results
   - Metrics improvements observed (if any)
2. Present outstanding items (Section C and any deferred Section A/B items) with rationale and recommended next actions.
3. Explicitly request stakeholder approval on which remaining items should proceed, be deferred, or be archived.
4. Record approvals/decisions in the document and, if needed, create GitHub issues or tasks reflecting the agreed backlog.

#### 10. Finalize Documentation and Handoff

1. Complete the "Final Report" section of `continuous-improvement.md` with:
   - Summary of implemented improvements and validation evidence
   - Updated metrics or KPIs
   - Stakeholder approvals and decisions
   - Outstanding risks and next steps
2. Ensure all tables, links, and references are accurate and up to date.
3. Commit the finalized document (and related files) with a descriptive message (e.g., `docs: add continuous improvement plan and apply priority fixes`).
4. Push changes to the repository and verify availability.
5. Notify stakeholders that the continuous improvement cycle is complete and provide links to all relevant artifacts.

### Completion

1. **Verify Continuous Improvement Assignment is Complete:**
   - `continuous-improvement.md` is updated with prioritized sections, execution details, reviewer feedback log, and final report.
   - Section A and Section B items are implemented, validated, and marked complete with evidence.
   - Section C backlog items have documented decisions, owners, and next steps.

2. **Present to Stakeholder:**
   - Walk through the improvement document, highlighting completed actions and approvals.
   - Share evidence links (PRs, issues, validation reports).
   - Confirm stakeholder understanding of remaining backlog and agreed timeline.

3. **Stakeholder Review Process:**
   - Request explicit approval of the completed improvements and documented deferrals.
   - Capture any additional feedback and integrate or schedule follow-up work as needed.
   - Update the improvement plan to reflect final stakeholder decisions.

4. **Finalization:**
   - Commit and push all related documentation and implementation changes.
   - Tag or annotate the improvement cycle (e.g., in release notes or project tracking).
   - Archive working notes and ensure the document is ready for the next continuous improvement iteration.

### Notes

- Re-run this assignment after future debriefs to maintain a living improvement backlog.
- Maintain historical versions of `continuous-improvement.md` (or append changelog entries) to track progress over time.
- When new high-value, low-risk items emerge, fast-track them into Section A and repeat validation/implementation steps.
