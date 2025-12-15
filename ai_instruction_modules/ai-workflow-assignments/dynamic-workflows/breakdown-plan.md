# Dynamic Workflow: Breakdown Plan

Break down a plan into epics and stories. Serial (default) or parallel epic creation.

## Inputs

- `$issue_number` (optional): Plan issue number
- `$repository` (optional): Git repo (default: current workspace)
- `$parallel_execution` (optional, default: `false`): Parallelize epic creation

## Helper Functions

- **getplanissue($issue_number, $repository)**: Retrieve plan issue
- **getphases($plan_issue)**: Extract phases from plan
- **getstories($epic)**: Extract stories from epic

## Script

### breakdown-plan

`$plan_issue` = getplanissue($issue_number, $repository)
`$phases` = getphases($plan_issue)

if `$parallel_execution` is `true`:
   For each `$phase` in `$phases`, in parallel:
      - assign an available agent the `create-epic` assignment with input `$phase`
      - wait until agent finishes
      - record as `#breakdown-plan.create-epic`
   - wait until all agents complete
else:
   For each `$phase` in `$phases`, you will:
      - assign the agent the `create-epic` assignment with input `$phase`
      - wait until agent finishes
      - record as `#breakdown-plan.create-epic`

# Create stories for each epic
For each `$epic` in `#breakdown-plan.create-epic`, you will:
   `$stories` = getstories($epic)
   For each `$story` in `$stories`, you will:
      - assign the agent the `create-story-v2` assignment with input `$story`
      - wait until agent finishes
      - record as `#breakdown-plan.create-story-v2`

### Events

#### `pre-assignment-begin`
- assign agent `gather-context`

#### `on-assignment-failure`
- assign agent `recover-from-error`

#### `post-assignment-complete`
- assign agent `validate-assignment-completion`
- if validation failed: halt workflow

#### `post-step-completion`
- assign agent `report-progress`
