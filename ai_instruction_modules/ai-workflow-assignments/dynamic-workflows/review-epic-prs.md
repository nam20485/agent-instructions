# Dynamic Workflow: Review Epic PRs

## Overview

This dynamic workflow orchestrates the review and approval of all open pull requests associated with an epic. It systematically assigns agents to execute the `pr-approval-and-merge` workflow assignment for each PR, parallelizing when PRs are independent and executing serially in story-order when PRs have dependencies.

This workflow is designed to be used with the `orchestrate-dynamic-workflow` assignment.

## Orchestrator Guidance: Parallel vs Serial PR Review

The orchestrator should evaluate whether PRs within an epic can be reviewed and merged in parallel by multiple agents:

### When to Use Parallel Execution

PRs are suitable for parallel review when:
- ✅ PRs modify **different files or components** with no overlap
- ✅ PRs have **independent review comments** that don't affect each other
- ✅ PRs can be **merged independently** without causing integration issues
- ✅ PRs don't have **sequential dependencies** (PR B doesn't require PR A merged first)
- ✅ Review comments are **isolated to individual PRs** and don't require cross-PR coordination
- ✅ The epic's architecture supports **loose coupling** between components

### When to Use Serial Execution

PRs must be reviewed serially in story-order when:
- ❌ PRs have **dependencies** (PR B builds on changes in PR A)
- ❌ PRs modify the **same files or components** (merge conflicts likely)
- ❌ PRs require **integration testing** across multiple PRs before merge
- ❌ Review comments in one PR **affect decisions** in another PR
- ❌ PRs must be merged **in specific order** to maintain functionality
- ❌ The epic's architecture has **tight coupling** between components
- ❌ Database migrations or schema changes must occur **sequentially**

### Orchestrator Decision Process

1. **Analyze PR structure** and dependencies
   - Check which files each PR modifies
   - Identify overlapping file changes
   - Review PR descriptions for explicit dependencies

2. **Assess merge conflict risk**
   - Use `gh pr view <pr-number> --json files` to get changed files per PR
   - Compare file lists across PRs to detect overlap
   - Check for base branch conflicts

3. **Evaluate review comment coordination needs**
   - Review existing PR comments
   - Identify comments that might affect other PRs
   - Assess whether cross-PR discussion is needed

4. **Choose execution mode**:
   - **Parallel**: Assign multiple PRs to different agents simultaneously (faster)
   - **Serial**: Assign PRs one at a time in story-order (safer, maintains dependencies)

### Implementation Notes

- **Story-order** means PRs are sorted by their associated story issue number (lowest first)
- When executing in **parallel**, the orchestrator tracks all agent assignments simultaneously
- Wait for all parallel PR reviews to complete before marking the epic as done
- **Serial execution is the safe default** when dependencies are unclear
- Each agent works independently on their assigned PR, resolving comments and merging when approved

### Parallel Execution and Workspace Management

**How Parallel Execution Works:**
- Each agent is assigned a different PR simultaneously
- Agents work in their respective PR branches independently
- Agents push commits to remote as they resolve review comments
- The orchestrator coordinates assignments but agents don't interfere with each other
- True parallelism happens through:
  1. **Time-sliced work**: Different agents work at different times, switching PRs as needed
  2. **Separate review threads**: Each PR has independent review conversations
  3. **Remote coordination**: All work pushed to remote; no local conflicts

**Conflict Prevention:**
- PRs are already on separate feature branches from implementation
- Review work happens within existing PR branches
- Conflicts only occur during merge, not during review/approval
- The orchestrator ensures PRs merge in safe order even with parallel review

## Script

### Inputs

- `$epic` (required)
  - Epic issue object or issue number containing the stories with open PRs
  - Used to identify which PRs belong to this epic
- `$repository` (optional)
  - Git repo containing the epic and its PRs
  - If not provided, use current workspace
- `$parallel_execution` (optional, default: `false`)
  - Whether to execute PR reviews in parallel when possible
  - Set to `true` only when PRs are independent and can be safely parallelized

### Helper Functions

#### get_epic_prs($epic, $repository)
Retrieves all open pull requests associated with an epic's stories.
- **Input:** Epic issue object and repository path
- **Returns:** Array of PR objects sorted in story-order (by linked story issue number)
- **Actions:**
  - Finds all story issues linked to the epic
  - For each story, finds the linked PR (via `gh pr list --search "linked:<story-number>"`)
  - Filters for PRs that are open (not merged, not closed)
  - Sorts PRs by story issue number (ascending) to maintain story-order
  - Returns PR objects containing: number, title, url, head branch, base branch, story issue number
- **Example:** `get_epic_prs($epic, "myorg/myrepo")` returns `[PR#45 (story#12), PR#46 (story#13), PR#47 (story#14)]`

#### analyze_pr_dependencies($prs, $repository)
Analyzes PRs to determine if they can be safely reviewed and merged in parallel.
- **Input:** Array of PR objects and repository path
- **Returns:** Boolean indicating whether PRs are independent (`true`) or have dependencies (`false`)
- **Analysis includes:**
  - Checking which files each PR modifies using `gh pr view <pr-number> --json files`
  - Identifying file overlap between PRs (same files modified)
  - Checking PR descriptions for dependency keywords ("depends on", "requires", "builds on")
  - Evaluating merge conflict risk based on file overlap
  - Assessing base branch divergence
- **Decision logic:**
  - If any two PRs modify the same file → return `false` (must be serial)
  - If PR descriptions mention dependencies → return `false` (must be serial)
  - If all PRs modify different files and no dependencies → return `true` (can parallelize)
- **Example:** `analyze_pr_dependencies($prs, "myorg/myrepo")` returns `true` if PRs are independent

#### get_pr_review_status($pr)
Retrieves the current review status of a pull request.
- **Input:** PR object
- **Returns:** Object containing review status information
- **Status includes:**
  - `has_unresolved_comments`: Boolean indicating if there are unresolved review comments
  - `review_decision`: String ("APPROVED", "CHANGES_REQUESTED", "REVIEW_REQUIRED", null)
  - `mergeable_state`: String ("MERGEABLE", "CONFLICTING", "UNKNOWN")
  - `is_draft`: Boolean indicating if PR is in draft state
- **Example:** `get_pr_review_status($pr)` returns review status object

#### validate_pr_ready_for_merge($pr)
Validates that a PR is ready to be merged after review completion.
- **Input:** PR object
- **Returns:** Boolean indicating if PR is ready to merge (`true`) or needs more work (`false`)
- **Validation checks:**
  - All review comments are resolved
  - PR is approved (reviewDecision == "APPROVED")
  - No merge conflicts (mergeable_state == "MERGEABLE")
  - Not in draft state
  - All status checks passing (if configured)
- **Example:** `validate_pr_ready_for_merge($pr)` returns `true` if ready

### review-epic-prs

# Step 0: Retrieve epic PRs and determine execution mode
`$epic_prs` = get_epic_prs($epic, $repository)

if `$epic_prs` is empty:
   - log: "No open PRs found for epic {epic.number}. Epic may be complete or PRs not created yet."
   - record output as `#review-epic-prs.no-prs`
   - exit workflow with success status
   
`$pr_count` = $epic_prs->length
- log: "Found {pr_count} open PR(s) for epic {epic.number}"

# Analyze PR dependencies to determine if parallel execution is safe
`$can_parallelize` = analyze_pr_dependencies($epic_prs, $repository)

if `$can_parallelize` is `false`:
   - log: "PRs have dependencies or file overlap. Using serial execution in story-order."
   `$execution_mode` = 'serial'
else if `$pr_count` is 1:
   - log: "Only one PR found. Using serial execution."
   `$execution_mode` = 'serial'
else if `$parallel_execution` is `true`:
   - log: "PRs are independent and parallel execution is enabled. Using parallel execution."
   `$execution_mode` = 'parallel'
else:
   - log: "PRs are independent but parallel execution is disabled. Using serial execution in story-order."
   `$execution_mode` = 'serial'

# Step 1: Execute PR reviews based on execution mode

if `$execution_mode` is 'parallel':
   # PARALLEL EXECUTION MODE
   # Assign all PRs to agents simultaneously for parallel review
   - log: "Starting parallel review of {pr_count} PRs"
   
   For each `$pr` in `$epic_prs`, in parallel:
      - log: "Assigning agent to review PR#{pr.number} (Story#{pr.story_number})"
      
      # Assign pr-approval-and-merge workflow to available agent
      - assign an available agent the `pr-approval-and-merge` assignment with input `$pr`
      - wait until the agent completes PR review, approval, and merge
      - record output as `#review-epic-prs.pr-{pr.number}-merged`
      
      # Validate merge completion
      `$merge_status` = validate_pr_ready_for_merge($pr)
      if `$merge_status` is `false`:
         - log: "WARNING: PR#{pr.number} may not have merged successfully. Manual verification needed."
   
   # Wait for all parallel PR reviews to complete
   - wait until all agents finish their assigned PRs
   - log: "All parallel PR reviews complete"
   - record outputs as `#review-epic-prs.parallel-complete`
   
   # Step 2: Validate epic integration after all PRs merged
   - log: "Validating epic integration after parallel merges"
   - verify all PRs are merged and closed
   - check for any integration issues in the target branch
   - run integration tests if configured
   - record validation as `#review-epic-prs.integration-validated`

else:
   # SERIAL EXECUTION MODE (Default/Safe)
   # Assign PRs one at a time in story-order
   - log: "Starting serial review of {pr_count} PRs in story-order"
   
   For each `$pr` in `$epic_prs`, you will:
      - log: "Reviewing PR#{pr.number} (Story#{pr.story_number}) - {pr.title}"
      
      # Check current review status before assignment
      `$review_status` = get_pr_review_status($pr)
      - log: "PR#{pr.number} status: {review_status.review_decision}, {review_status.mergeable_state}"
      
      # Assign pr-approval-and-merge workflow to agent
      - assign the agent the `pr-approval-and-merge` assignment with input `$pr`
      - wait until the agent completes PR review, approval, and merge
      - record output as `#review-epic-prs.pr-{pr.number}-merged`
      
      # Validate merge completion before proceeding to next PR
      `$merge_status` = validate_pr_ready_for_merge($pr)
      if `$merge_status` is `false`:
         - log: "ERROR: PR#{pr.number} did not merge successfully. Stopping workflow."
         - record error as `#review-epic-prs.merge-failed`
         - exit workflow with failure status
      
      - log: "PR#{pr.number} merged successfully. Proceeding to next PR."
      - review the merged PR and validate integration with previous merges
      - approve before moving to next PR

# Step 3: Mark epic PR review complete
- log: "All PRs for epic {epic.number} have been reviewed and merged"
- verify all PRs are merged and stories are closed
- record completion summary as `#review-epic-prs.complete`

### Events

#### `pre-script-begin`

- log: "Starting Review Epic PRs workflow for epic {epic.number}"
- log: "Parallel execution: {parallel_execution}"
- verify epic exists and is accessible
- verify agent has necessary permissions (repo read, PR write, issue write)
- record pre-flight checks as `#events.pre-script-begin`

#### `pre-assignment-begin`

# This event runs before each pr-approval-and-merge assignment in the loop
- log: "Starting PR review for PR#{pr.number} (Story#{pr.story_number})"
- fetch latest PR status to ensure current information
- verify PR is still open (not closed or already merged)
- create checkpoint with PR current state (for rollback if needed)
- record pre-assignment state as `#events.pre-assignment-begin.pr-{pr.number}`

#### `post-assignment-completion`

# This event runs after each pr-approval-and-merge assignment completes successfully
- log: "Completed PR review for PR#{pr.number} (Story#{pr.story_number})"
- verify PR was merged successfully
- verify story issue was closed
- update epic progress tracking
- record post-assignment state as `#events.post-assignment-completion.pr-{pr.number}`

#### `on-assignment-failure`

# This event runs when a pr-approval-and-merge assignment fails
- log: "ERROR: PR review failed for PR#{pr.number} (Story#{pr.story_number})"
- log: "Failure reason: {error.message}"
- capture current PR state and error context
- notify stakeholders of failure
- if `$execution_mode` is 'parallel':
   - log: "Parallel execution failure. Other agents may continue."
   - record failure but allow other parallel tasks to complete
else:
   - log: "Serial execution failure. Stopping workflow."
   - halt workflow execution and require manual intervention
- record failure details as `#events.on-assignment-failure.pr-{pr.number}`

#### `post-script-complete`

- log: "Review Epic PRs workflow completed successfully for epic {epic.number}"
- generate completion report with all merged PRs
- verify all PRs are merged and stories closed
- update epic issue with completion summary
- notify stakeholders of epic PR completion
- record final report as `#events.post-script-complete`

#### `on-script-failure`

# This event runs when the entire workflow fails
- log: "CRITICAL: Review Epic PRs workflow failed for epic {epic.number}"
- log: "Failure occurred during step: {error.step}"
- capture full workflow state at failure point
- generate failure report with:
  - Which PRs were successfully merged
  - Which PRs are still open/in-progress
  - Error messages and context
  - Recommended remediation steps
- notify stakeholders with failure report
- do NOT automatically retry or rollback (preserve state for investigation)
- record failure report as `#events.on-script-failure`

## Usage Examples

### Example 1: Serial Review (Default, Safe)

```bash
# Orchestrate serial review of all PRs for epic #42
orchestrate-dynamic-workflow review-epic-prs \
  --epic 42 \
  --repository "myorg/myrepo"
```

This will:
1. Find all open PRs linked to epic #42's stories
2. Sort PRs in story-order (by story issue number)
3. Analyze PR dependencies (finds file overlap, assumes serial needed)
4. Assign PRs to agents one at a time in story-order
5. Wait for each PR to be fully merged before starting the next
6. Validate integration after each merge

### Example 2: Parallel Review (Fast, Risky)

```bash
# Orchestrate parallel review of all PRs for epic #42
orchestrate-dynamic-workflow review-epic-prs \
  --epic 42 \
  --repository "myorg/myrepo" \
  --parallel-execution true
```

This will:
1. Find all open PRs linked to epic #42's stories
2. Analyze PR dependencies (checks for file overlap and dependencies)
3. If PRs are independent:
   - Assign all PRs to different agents simultaneously
   - Agents work in parallel resolving review comments
   - All PRs merge when approved (possibly out of story-order)
   - Validate integration after all merges complete
4. If PRs have dependencies:
   - Fall back to serial execution in story-order

### Example 3: Review Single Epic's PRs (Current Workspace)

```bash
# Orchestrate review in current workspace (repo inferred)
orchestrate-dynamic-workflow review-epic-prs --epic 42
```

This will:
1. Use current workspace repository
2. Default to serial execution (parallel_execution = false)
3. Process PRs in story-order safely

## Integration with Other Workflows

### After `implement-epic` Workflow

The `review-epic-prs` workflow is typically executed after the `implement-epic` workflow has created all PRs:

```
implement-epic (creates all PRs)
  → review-epic-prs (reviews and merges all PRs)
    → mark epic complete
```

### Used by Epic Management Workflows

This workflow is commonly orchestrated by higher-level epic management workflows:

```
breakdown-epic
  → implement-epic (creates stories and PRs)
    → review-epic-prs (handles all PR reviews)
      → close epic
```

## Best Practices

1. **Start with Serial Execution**
   - Use serial execution as default until you understand PR dependencies
   - Only enable parallel execution when you're confident PRs are independent

2. **Monitor Parallel Execution Carefully**
   - Watch for merge conflicts during parallel merges
   - Be prepared to resolve integration issues after all PRs merge
   - Ensure adequate test coverage to catch integration bugs

3. **Story-Order Matters**
   - Always process PRs in story-order when executing serially
   - This maintains logical dependencies and reduces conflicts

4. **Review Event Logs**
   - Check `pre-assignment-begin` and `post-assignment-completion` events
   - These provide detailed progress tracking for each PR

5. **Handle Failures Gracefully**
   - Serial mode: Stop immediately on failure (safe)
   - Parallel mode: Let other agents complete, then investigate (efficient)
   - Always check `on-assignment-failure` event for failure details

## Troubleshooting

### Problem: "No open PRs found for epic"

**Cause:** PRs haven't been created yet, or all PRs are already merged

**Solution:**
- Verify stories have been implemented and PRs created
- Check if PRs were already merged by another process
- Run `implement-epic` workflow if PRs don't exist

### Problem: Parallel execution causes merge conflicts

**Cause:** PRs modified overlapping files despite analysis saying they're independent

**Solution:**
- Fall back to serial execution
- Manually resolve conflicts after parallel merges
- Improve `analyze_pr_dependencies` logic to detect file overlap more accurately

### Problem: Agent fails during pr-approval-and-merge

**Cause:** Review comments are complex, merge conflicts, or CI failures

**Solution:**
- Check `on-assignment-failure` event for detailed error
- Manually investigate the problematic PR
- Resume workflow with remaining PRs after fixing the issue

### Problem: PRs merge out of story-order in parallel mode

**Cause:** This is expected behavior in parallel mode (agents finish at different times)

**Solution:**
- This is not a bug, it's how parallel execution works
- Integration testing after all merges will catch any issues
- Use serial mode if story-order must be strictly maintained

## Notes

- This workflow focuses on **orchestration** of the pr-approval-and-merge assignment, not the actual PR review work
- The actual review comment resolution happens in the `pr-approval-and-merge` assignment
- Agents assigned to PRs will iterate on review comments until approved
- The orchestrator's job is to coordinate multiple agents working on multiple PRs
- Event handlers provide detailed logging and progress tracking throughout the workflow
