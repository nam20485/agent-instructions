# Dynamic Workflow: Create Stories for Epic

Create story issues for an epic by extracting story bullets and creating individual issues.

## Inputs

- `$epic_issue_number` (required): Epic issue number
- `$repository` (optional): Git repo (default: current workspace)
- `$parallel_execution` (optional, default: `false`): Create stories concurrently

## Prerequisites

Read before executing: `ai-core-instructions.md`, `dynamic-workflow-syntax.md`, `orchestrate-dynamic-workflow.md`, `create-story-v2.md`

## Helper Functions

- **getepic($issue_number, $repository)**: Retrieve epic issue
- **getstories($epic)**: Extract story items from epic

## Script

### create-stories-for-epic

`$epic_issue` = getepic($epic_issue_number, $repository)
`$stories` = getstories($epic_issue)
`$full_epic_json` = JSON.stringify($epic_issue)

if `$parallel_execution` is `true`:
   For each `$story` in `$stories`, in parallel:
      if `$story` not already linked to `$epic_issue`:
         - assign an available agent the `create-story-v2` assignment with input `$story` and `$full_epic_json`
         - wait until agent finishes
         - record output as `#create-stories-for-epic.create-story-v2`
   - wait until all complete
   - verify linked story count matches expected
   - if mismatch: trigger `recover-from-error` and halt
else:
   For each `$story` in `$stories`, you will:
      if `$story` not already linked to `$epic_issue`:
         - assign the agent the `create-story-v2` assignment with input `$story` and `$full_epic_json`
         - wait until agent finishes
         - record output as `#create-stories-for-epic.create-story-v2`
   - verify linked story count matches expected

### Events

#### `pre-assignment-begin`
- assign agent `gather-context` assignment
- record as `#events.pre-assignment-begin.gather-context`

#### `on-assignment-failure`
- assign agent `recover-from-error` assignment
- record as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-complete`
- assign agent `validate-assignment-completion` assignment
- if validation failed: halt workflow
- record as `#events.post-assignment-complete`

#### `post-script-complete`
- assign agent `debrief-and-document` assignment
- assign agent `continuous-improvement` assignment
