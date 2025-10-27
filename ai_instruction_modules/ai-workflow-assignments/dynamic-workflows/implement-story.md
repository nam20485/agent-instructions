# Dynamic Workflow: Implement Story

## ⚠️ MANDATORY: Pre-Execution Reading Chain (NO EXCEPTIONS)

**STOP! Before executing this workflow, you MUST read these files in order and LOG each one:**

1. **[ai-core-instructions.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-core-instructions.md)** - Core protocol and rules
   - Log: "✓ Read ai-core-instructions.md"
2. **[dynamic-workflow-syntax.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)** - Event system and DSL syntax
   - Log: "✓ Read dynamic-workflow-syntax.md"
3. **[orchestrate-dynamic-workflow.md](https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/orchestrate-dynamic-workflow.md)** - Orchestration rules and guardrails
   - Log: "✓ Read orchestrate-dynamic-workflow.md"

**After reading all three files, log: "✓ Completed mandatory reading chain for implement-story workflow"**

**Do not proceed with workflow execution until all three files are read and logged.**

## Overview

This dynamic workflow performs implementation of a single story from an epic. It is designed to be called from the `implement-epic` workflow (serial flow) or used standalone when you need to implement one specific story. This workflow handles the complete lifecycle of a story: implementation, PR creation, automated reviews, and merge.

## Script

### Inputs
- `$story` (required)
  - Story issue object or issue number containing the story to implement
  - Can be passed from `implement-epic` workflow or specified directly
- `$epic` (optional)
  - Parent epic issue object or number for context
  - Used for linking and progress tracking
- `$repository` (optional)
  - Git repo containing the story issue
  - If not provided, use current workspace

### Events

#### `pre-assignment-begin`

Before executing each assignment in this workflow, gather context and prepare:

- assign the agent the `gather-context` assignment with input:
  - upcoming_assignment: the assignment about to be executed
  - workflow_context: current workflow state and previous outputs
- wait until the agent completes context gathering
- record output as `#events.pre-assignment-begin`
- log: "✓ Context gathered for upcoming assignment"

### Declarations

#### getstory($story, $repository)
Retrieves the story issue from the specified repository.
- **Input:** Story issue number or object and repository path
- **Returns:** Story issue object containing the story description, acceptance criteria, and requirements
- **Example:** `getstory(42, "myorg/myrepo")` returns story issue #42 from myorg/myrepo

#### create_pull_request($story)
Creates a pull request for the completed story implementation.
- **Input:** Story object with completed implementation
- **Returns:** Pull request object containing PR number, URL, and metadata
- **Actions:**
  - Creates PR from story's feature branch to target branch
  - Links PR to story issue
  - Sets PR title and description from story details
  - Links to parent epic if provided
  - Auto-assigns reviewers based on CODEOWNERS or repository settings
  - Sets default reviewers for the PR
- **Example:** `create_pull_request($story)` returns PR object for story implementation

#### request_automated_reviews($pull_request)
Requests automated reviews from AI bots on the pull request.
- **Input:** Pull request object
- **Returns:** Review request confirmation
- **Actions:**
  - Posts comment `@gemini review` to trigger Gemini bot review
  - Posts comment `@claude review this PR` to trigger Claude bot review
  - Waits for automated reviews to complete
- **Example:** `request_automated_reviews($pr)` triggers both AI bot reviews

#### update_story_progress($story, $status)
Updates the story issue with current progress status.
- **Input:** Story object and status message
- **Returns:** Confirmation of update
- **Actions:**
  - Updates story issue with progress comment
  - Updates labels if needed (e.g., state:in-progress, state:review)
  - Links to PR if created
- **Example:** `update_story_progress($story, "Implementation complete, PR created")` updates the story issue

#### auto_approve_pr($pull_request, $validation_results)
Automatically approves a pull request if all validation checks pass.
- **Input:** Pull request object and validation results from automated reviews
- **Returns:** Approval status (approved/pending_manual/failed)
- **Approval criteria:**
  - All automated CI/CD checks must pass (build, tests, linting)
  - All automated review comments are informational or approved
  - No requested changes from automated reviewers
  - Code coverage meets or exceeds threshold
  - No merge conflicts with target branch
  - Branch protection rules satisfied
- **Actions:**
  - Evaluates validation results against approval criteria
  - Posts approval review if all criteria met
  - Adds approval comment with summary of validation results
  - Returns approval status for workflow decision making
- **Example:** `auto_approve_pr($pr, $validation_results)` returns `"approved"` if all checks pass

#### auto_merge_pr($pull_request)
Automatically merges a pull request if approved and all checks pass.
- **Input:** Pull request object (must be approved)
- **Returns:** Merge status (merged/pending/failed)
- **Merge criteria:**
  - PR must be approved (manual or automated)
  - All required status checks must pass
  - No merge conflicts with target branch
  - Branch protection rules must be satisfied (required reviews, CI checks, etc.)
  - PR cannot be in draft state
- **Actions:**
  - Validates PR is ready to merge against all branch protection rules
  - Attempts merge using configured merge strategy (merge commit, squash, or rebase)
  - Handles branch protection bypasses if authorized and necessary
  - Deletes source branch after successful merge (if configured)
  - Posts merge confirmation comment with commit SHA
  - Returns merge status for workflow tracking
- **Branch Protection Handling:**
  - **Protected branches:** Respects all branch protection rules (required reviews, status checks)
  - **Merge strategies:** Uses repository's configured default merge method
  - **Bypass rules:** Only bypasses if explicitly authorized (admin/maintainer role) AND necessary
  - **Failure handling:** Returns failed status if protection rules not met, allowing manual intervention
- **Example:** `auto_merge_pr($pr)` returns `"merged"` if PR successfully merged, `"pending"` if waiting for checks, `"failed"` if merge blocked

### implement-story

# Step 0: Get story details
if `$story` is an issue number:
   `$story_issue` = getstory($story, $repository)
else:
   `$story_issue` = `$story`

- log: "Implementing story: {story_issue.number} - {story_issue.title}"
if `$epic` is provided:
   - log: "Parent epic: {epic.number} - {epic.title}"

# Step 1: Implement the story
- assign the agent the `perform-task` assignment with input `$story_issue`
- wait until the agent completes the story implementation
- record output as `#implement-story.perform-task`

# Step 2: Update story progress
- update_story_progress($story_issue, "Implementation complete, creating PR")

# Step 3: Create pull request for the story
`$pull_request` = create_pull_request(#implement-story.perform-task)
- record PR as `#implement-story.pull-request`
- log: "Created PR #{pull_request.number} for story #{story_issue.number}"

# Step 4: Request automated reviews
- post comment on `$pull_request`: "@gemini review"
- post comment on `$pull_request`: "@claude review this PR"
- wait until both automated reviews complete
- record reviews as `#implement-story.automated-reviews`
- log: "Automated reviews complete for PR #{pull_request.number}"

# Step 5: Update story with review status
- update_story_progress($story_issue, "PR #{pull_request.number} reviews complete, ready for approval")

# Step 6: Automated PR approval and merge
$approval_status = auto_approve_pr(#implement-story.pull-request, #implement-story.automated-reviews)

if $approval_status is "approved":
   - log: "PR #{pull_request.number} auto-approved, proceeding to merge"
   $merge_status = auto_merge_pr(#implement-story.pull-request)
   
   if $merge_status is "merged":
      - record merge as `#implement-story.pr-merged`
      - log: "PR #{pull_request.number} successfully merged for story #{story_issue.number}"
   else if $merge_status is "pending":
      - log: "PR #{pull_request.number} merge pending additional checks, requires manual intervention"
      - post comment on `$pull_request`: "⚠️ Automated merge pending: waiting for additional status checks to complete. Manual merge may be required."
      - STOP workflow with message: "Manual intervention required: PR #{pull_request.number} merge is pending additional checks"
   else:
      - log: "PR #{pull_request.number} auto-merge failed, requires manual intervention"
      - post comment on `$pull_request`: "❌ Automated merge failed: branch protection rules not satisfied or merge conflicts present. Manual intervention required."
      - STOP workflow with message: "Manual intervention required: PR #{pull_request.number} could not be automatically merged"
else:
   - log: "PR #{pull_request.number} requires manual approval"
   - post comment on `$pull_request`: "⚠️ Automated approval criteria not met. Manual review and approval required."
   - STOP workflow with message: "Manual intervention required: PR #{pull_request.number} needs manual approval"

# Step 7: Final story update and closure
- update_story_progress($story_issue, "PR merged, story implementation complete")
- close the story issue with completion summary
- record completion as `#implement-story.complete`
- log: "Story #{story_issue.number} complete"
