# Dynamic Workflow: Implement Epic

Implement a single epic by completing its story issues. Serial (default) or parallel execution.

## Inputs

- `$epic` (optional): Epic issue object or number (auto-selects next incomplete if not provided)
- `$repository` (optional): Git repo (default: current workspace)
- `$parallel_execution` (optional, default: `false`): Parallelize independent stories

## Helper Functions

- **find_next_incomplete_epic($repository)**: Find next epic with incomplete stories
- **getepic($epic, $repository)**: Retrieve epic issue
- **getstories($epic)**: Extract story items from epic
- **analyze_story_dependencies($stories)**: Check if stories can run in parallel
- **create_pull_request($story)**: Create PR from story branch
- **request_automated_reviews($pr)**: Trigger @gemini and @claude reviews
- **mark_milestone_complete($epic)**: Close associated milestone
- **update_project_progress($epic, $repository)**: Update project board

## Script

### implement-epic

if `$epic` not provided:
   `$epic_issue` = find_next_incomplete_epic($repository)
else:
   `$epic_issue` = getepic($epic, $repository)

`$stories` = getstories($epic_issue)
`$can_parallelize` = analyze_story_dependencies($stories)

if `$parallel_execution` is `true` AND `$can_parallelize` is `true`:
   # PARALLEL
   For each `$story` in `$stories`, in parallel:
      - assign an available agent the `perform-task` assignment with input `$story`
      - wait until agent completes
      - `$pr` = create_pull_request(#implement-epic.perform-task)
      - request_automated_reviews($pr)
      - assign agent `pr-approval-and-merge` with input `$pr`
      - wait for merge
      - record as `#implement-epic.pr-{story.number}-merged`
   - wait for all agents
   - review integration
   - resolve any conflicts
else:
   # SERIAL (Default)
   For each `$story` in `$stories`, you will:
      - assign the agent the `perform-task` assignment with input `$story`
      - wait until agent completes
      - `$pr` = create_pull_request(#implement-epic.perform-task)
      - request_automated_reviews($pr)
      - assign agent `pr-approval-and-merge` with input `$pr`
      - wait for merge
      - review and approve before next story

- mark_milestone_complete($epic_issue)
- update_project_progress($epic_issue, $repository)
- close epic issue
- record as `#implement-epic.complete`

### Events

#### `pre-assignment-begin`
- assign agent `gather-context` assignment
- record as `#events.pre-assignment-begin`

#### `on-assignment-failure`
- assign agent `recover-from-error` assignment
- record as `#events.on-assignment-failure`

#### `post-assignment-complete`
- assign agent `validate-assignment-completion`
- if validation failed: halt workflow
- assign agent `report-progress`
- record as `#events.post-assignment-complete`

#### `post-script-complete`
- assign agent `debrief-and-document` assignment
- update epic issue with completion summary
