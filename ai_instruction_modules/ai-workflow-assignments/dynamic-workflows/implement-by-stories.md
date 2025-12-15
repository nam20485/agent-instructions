# Dynamic Workflow: Implement by Stories

Implement a plan by completing stories across all epics. Serial (default) or parallel execution.

## Inputs

- `$issue_number` (optional): Plan issue number
- `$repository` (optional): Git repo (default: current workspace)
- `$parallel_execution` (optional, default: `false`): Parallelize independent stories

## Helper Functions

- **getplanissue($issue_number, $repository)**: Retrieve plan issue
- **getepics($plan_issue)**: Extract epics from plan
- **getstories($epic)**: Extract stories from epic
- **analyze_story_dependencies($stories)**: Check if stories can run in parallel
- **create_pull_request($story)**: Create PR from story branch
- **request_automated_reviews($pr)**: Trigger @gemini and @claude reviews
- **auto_approve_pr($pr, $reviews)**: Auto-approve if all checks pass
- **auto_merge_pr($pr)**: Auto-merge if approved

## Script

### implement-by-stories

`$plan_issue` = getplanissue($issue_number, $repository)
`$epics` = getepics($plan_issue)

For each `$epic` in `$epics`, you will:
   `$stories` = getstories($epic)
   `$can_parallelize` = analyze_story_dependencies($stories)
   
   if `$parallel_execution` is `true` AND `$can_parallelize` is `true`:
      # PARALLEL
      For each `$story` in `$stories`, in parallel:
         - assign an available agent the `perform-task` assignment with input `$story`
         - wait until agent completes
         - `$pr` = create_pull_request(#implement-by-stories.perform-task)
         - request_automated_reviews($pr)
         - `$status` = auto_approve_pr($pr, #reviews)
         - if approved: auto_merge_pr($pr)
         - record as `#implement-by-stories.pr-merged`
      - wait for all agents
      - review integration
   else:
      # SERIAL (Default)
      For each `$story` in `$stories`, you will:
         - assign the agent the `perform-task` assignment with input `$story`
         - wait until agent completes
         - `$pr` = create_pull_request(#implement-by-stories.perform-task)
         - request_automated_reviews($pr)
         - `$status` = auto_approve_pr($pr, #reviews)
         - if approved: auto_merge_pr($pr)
         - review and approve before next story

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
- record as `#events.post-assignment-complete`

#### `post-script-complete`

- assign agent `debrief-and-document` assignment
