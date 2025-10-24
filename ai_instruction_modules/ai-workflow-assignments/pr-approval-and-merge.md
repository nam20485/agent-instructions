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

### Acceptance Criteria

1. All PR comments resolved.
2. PR approved.
3. Branch merged upstream.
4. Issue closed.

### Assignment

In this stage your assignment will be to complete the full PR approval and merge process. This includes:

1. Iterating on PR comments until they are all resolved
2. Working with stakeholders to get the PR approved
3. Executing the merge operation to integrate changes upstream
4. Closing associated issues and branches

Once PR comments are available you will work systematically to resolve each comment, one after another.

### Resolving Threads, Reply Content, and Commit Hygiene Protocol

Reference the following documents for details on resolving threads, reply content, commit hygiene, and the script used to manage PR review threads:

- [PR Comment Protocols](../ai-pr-comment-protocol.md)

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

**NOTE** For a concise pseudocode version of the comment resolution algorithm see the workflow assignment here:
    - [PR Review Comments Assignment](./pr-review-comments.md)

**Phase 1: Comment Resolution**
1. Fetch and analyze all of the review comments for the assigned PR.
2. Create an issue that lists each issue with a link, a description of the issue and its cause, and then your plan to resolve.
3. After gaining an approval, create a branch off of the PR's base branch, link it to your issue, start a review, and then being resolving each issue systematically in order. After finishing resolution of each issue, commit your changes, update the issue, and reply with a comment explaining the outcome on the original review comment. Then mark the comment resolved.

1. For each unresolved, non-outdated review comment:

    1. If you have already submitted a reply with a plan, then you must wait for the stake holder to review your plan and approve it before you can move any further to implement the changes.
        1. Move on to the next comment.
    1. If you have not yet submitted a reply, then you will need to review and address the comment.
        1. This involves reading the comment and the entire context of this comment to gain a full understanding.
        1. Including:
            1. All the replies in this comment's thread
            1. The PR's original code changes
            1. Any code changes or plans resulting from previous iterations on this comment.
            1. Have you already submitted any plans that were rejected?
            1. At this point, go read the issue and PR again
            1. Given the context determine the options to resolve the comment.

            You must then leave a reply explaining the plan, and/or different options for them to choose from.
            1. Using the original comment from the reviewer, reply to that comment so that the replies are all in the original thread.
            2. If you have a recommendation, then state so and why.
            3. Ask for approval, direction, or other required input/feedback to proceed.
            4. Move on the next comment.
            5. If you are unsure how to proceed, then ask for help in the chat or reply.
            6. If the stake-holder reply contains approval for a previously submitted plan, then you will be able to implement the changes now.
               1. After implementing the changes, commit your work, update the issue, and reply with a comment explaining the outcome on the original review comment. Then mark the comment resolved.
            7. If the stake-holder reply contains a request for changes, then you will need to review the comment and ensure that you understand the feedback provided.
            8. Address the feedback and update your implementation accordingly.
            9.  Communicate your changes and seek further clarification if needed.

Once you have addressed all of the comments to the degree with which you can for this round, then notify the orchestrator and reviewer that you are ready for them to look at your replies and then wait for them to noify you again.

**After implementing each approved plan, leave a comment reply to the preceding approval comment informing stakeholders that you have completed implementing the indicated plan.** Include details of what was changed and confirm the implementation status.

* Iterate in this manner until all comments and replies have been addressed.
* Once all PR comments have been resolved, the stake-holder will approve the PR.

**Phase 2: Merge and Completion**
1. After PR approval is obtained, attempt to merge the PR to the target branch
2. Determine the appropriate result value based on merge outcome:
   - If merge succeeds: result = "merged"
   - If merge is pending checks: result = "pending"
   - If merge fails: result = "failed"
3. Close associated issue and branch if merge was successful

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

1. **PR Approval**: Wait for all PR comments to be resolved and get explicit approval from stakeholders
2. **Merge Attempt**: Attempt to merge the PR to the target branch
3. **Result Determination**: Based on the merge attempt outcome, determine the result value:
   - If merge succeeds immediately: result = "merged"
   - If merge is blocked by pending status checks: result = "pending"
   - If merge fails due to conflicts, branch protection, or other issues: result = "failed"
4. **Issue Closure**: Close the associated issue and branch (only if merge was successful)
