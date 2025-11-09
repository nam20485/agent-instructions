# Assignment: Pull Request (PR) Approval and Merge

## (pr-approval-and-merge)

### Goal

Complete the full PR approval and merge process, including resolving all PR comments, obtaining approval, merging the PR, and closing associated issues.

### Inputs
- `$pr_num`: (required) 
    - The pull request number to process

### Outputs

- `result` (required)
  - The status of the PR approval and merge process
  - Possible values:
    - `"merged"`: PR was successfully approved and merged to target branch
    - `"pending"`: PR merge is pending additional checks or manual intervention
    - `"failed"`: PR could not be merged due to conflicts, failed checks, or other issues

### Acceptance Criteria (All Must Pass)

**Review Comment Resolution**
- [ ] `ai-pr-comment-protocol.md` workflow executed and logged (`✓ Read ai-pr-comment-protocol.md`).
- [ ] `pr-review-comments` acceptance criteria satisfied (unique replies, explicit resolution via GraphQL/UI, summary comment posted).
- [ ] GraphQL verification artifacts captured: `pr-unresolved-threads.json` (empty) and final query output demonstrating `isResolved: true` for every thread.
- [ ] Evidence files and summary links attached to the run report and referenced in stakeholder communication.

**Approval & Merge**
- [ ] Stakeholder approval obtained after presenting resolution evidence.
- [ ] Merge performed (or blocked reason documented) using repository policies.
- [ ] Merge result recorded (`result` output set to `merged`, `pending`, or `failed` per guidance).

**Post-Merge Hygiene**
- [ ] Source branch deleted (if merge succeeded and policy allows).
- [ ] Related issues/tickets closed or updated with resolution notes.
- [ ] Run report updated with final status, evidence locations, and next steps.

### Assignment

In this stage your assignment will be to complete the full PR approval and merge process. This includes:

1. Iterating on PR comments until they are all resolved
2. Working with stakeholders to get the PR approved
3. Executing the merge operation to integrate changes upstream
4. Closing associated issues and branches

Once PR comments are available you will work systematically to resolve each comment, one after another.

> ⚠️ **Non-negotiable:** Before you begin, acknowledge and follow the canonical protocol (`ai-pr-comment-protocol.md`) and execute the `pr-review-comments` assignment. Skipping these prerequisites invalidates this assignment.

### Resolving Threads, Reply Content, and Commit Hygiene Protocol

Reference the following documents for details on resolving threads, reply content, commit hygiene, and the script used to manage PR review threads:

> 🚨 **Mandatory:** Failing to execute the canonical protocol exactly as written is an automatic failure of this assignment. Log your acknowledgement and capture artifacts as described.

- [PR Comment Protocols](../ai-pr-comment-protocol.md)

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

> 🚨 **Do not proceed** until you log `✓ Read ai-pr-comment-protocol.md` and confirm familiarity with [`pr-review-comments.md`](./pr-review-comments.md). These files are gatekeepers for this assignment.

#### Phase 0: Pre-flight Checklist
1. Confirm you have the correct PR number, branch permissions, and authentication (`gh auth status`).
2. Execute the GraphQL snapshot command from the protocol and store `.pr-thread-snapshot.json`.
3. Create or update a work log/issue (if required) capturing the current state of review threads and planned actions.

#### Phase 1: Resolve Review Comments (Execute `pr-review-comments`)
1. Follow the mandated workflow:
    - Implement fixes, push commits, reply using the template, and call the `resolveReviewThread` mutation for each unresolved, non-outdated thread.
    - Re-run the snapshot query until `pr-unresolved-threads.json` is empty.
2. Post the PR-wide summary comment that enumerates every thread (ID or link), associated commit SHA, and outcome.
3. Archive evidence in the run report:
    - Attach the final GraphQL output.
    - Record the location of `pr-review-threads-summary.md` and other helper outputs.
4. Notify the orchestrator/reviewer with links to the summary comment and evidence.

#### Phase 2: Secure Approval
1. Address any follow-up questions or additional review comments immediately, repeating Phase 1 as necessary.
2. Once stakeholders confirm that all feedback is satisfied, record their approval (screenshot, link to approval comment, or review state change).
3. Verify that CI checks are green and branch protection conditions are satisfied.

#### Phase 3: Merge Execution & Wrap-Up
1. Attempt the merge using the repository’s preferred strategy (squash, rebase, merge).
2. Set the `result` output:
    - `"merged"` if the merge succeeds and the target branch now contains the changes.
    - `"pending"` if waiting on status checks or additional approvals.
    - `"failed"` if merge conflicts or policy blocks require intervention.
3. On successful merge:
    - Delete the source branch (if policy allows).
    - Close or update related issues with links to the PR and summary comment.
4. Update the run report with final status, evidence links, and next steps.

### ⚠️ CRITICAL: Commit Changes Before Merge

**BEFORE the PR is merged upstream, you MUST:**

1. **Commit all local changes** to the PR branch using `git add .` and `git commit`
2. **Push changes** to the remote branch using `git push origin <branch-name>`
3. **Verify changes are in the remote branch** by checking the PR diff or using `git show origin/<branch-name>:<file-path>`

**Failure to commit and push changes will result in permanent loss of all implementation work when the branch is merged and deleted.**

### Execution Flow and Result Determination

The agent executing this assignment must follow these guidelines for different scenarios:

**When to return `"merged"`:**
- All PR comments have been resolved through the iterative process
- Stakeholder approval has been obtained
- Merge operation completes successfully without conflicts
- Target branch now contains the merged changes

**When to return `"pending"`:**
- All PR comments have been resolved and approval obtained
- Merge operation initiated but blocked by pending status checks (CI/CD, tests, etc.)
- Manual intervention may be required when checks complete
- The PR is ready to merge but waiting for external conditions

**When to return `"failed"`:**
- All PR comments have been resolved and approval obtained
- Merge operation fails due to conflicts with target branch
- Branch protection rules cannot be satisfied
- Merge blocked by unresolvable technical issues
- Required manual intervention for conflict resolution

### Completion Process

The completion process follows these steps:

1. **PR Approval**: Present the resolution evidence, obtain explicit stakeholder approval, and log the approval link or review state.
2. **Merge Attempt**: Attempt to merge the PR to the target branch using the repository’s preferred strategy.
3. **Result Determination**: Based on the merge attempt outcome, determine the result value:
    - If merge succeeds immediately: result = "merged"
    - If merge is blocked by pending status checks: result = "pending"
    - If merge fails due to conflicts, branch protection, or other issues: result = "failed"
4. **Evidence & Handoff**: Attach the final GraphQL output, empty `pr-unresolved-threads.json`, merge confirmation, and summary comment link to the run report. Notify stakeholders of completion and next steps.
5. **Issue Closure / Follow-up**: Close the associated issue and source branch (only if merge was successful and policy allows) or document the remediation plan if the result is `pending` or `failed`.
