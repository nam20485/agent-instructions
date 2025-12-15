# Dynamic Workflow: Review Epic PRs

Review and merge all open PRs for an epic. Supports serial (default, safe) or parallel execution.

## Inputs

- `$epic` (required): Epic issue object or number
- `$repository` (optional): Git repo (default: current workspace)
- `$parallel_execution` (optional, default: `false`): Parallelize when PRs are independent

## Helper Functions

- **get_epic_prs($epic, $repository)**: Get open PRs linked to epic stories, sorted by story number
- **analyze_pr_dependencies($prs, $repository)**: Check if PRs modify overlapping files
- **get_pr_review_status($pr)**: Get review status (comments, approval, mergeable state)
- **validate_pr_ready_for_merge($pr)**: Validate PR is approved, no conflicts, checks pass

## Script

### review-epic-prs

`$epic_prs` = get_epic_prs($epic, $repository)

if `$epic_prs` is empty:
   - log: "No open PRs for epic"
   - exit workflow

`$can_parallelize` = analyze_pr_dependencies($epic_prs, $repository)

if `$can_parallelize` is `false` OR `$parallel_execution` is `false`:
   # SERIAL (Default)
   For each `$pr` in `$epic_prs`, you will:
      - assign the agent the `pr-approval-and-merge` assignment with input `$pr`
      - wait until agent completes
      - record output as `#review-epic-prs.pr-{pr.number}-merged`
      - validate merge success before proceeding
else:
   # PARALLEL
   For each `$pr` in `$epic_prs`, in parallel:
      - assign an available agent the `pr-approval-and-merge` assignment with input `$pr`
      - wait until agent completes
      - record output as `#review-epic-prs.pr-{pr.number}-merged`
   - wait until all agents finish
   - validate integration

- verify all PRs merged
- record completion as `#review-epic-prs.complete`

### Events

#### `pre-script-begin`
- verify epic exists and accessible
- verify agent permissions

#### `post-script-complete`
- generate completion report
- update epic issue

#### `on-assignment-failure`
- capture PR state and error
- serial mode: halt workflow
- parallel mode: allow others to continue
