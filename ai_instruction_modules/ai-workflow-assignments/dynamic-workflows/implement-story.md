# Dynamic Workflow: Implement Story

Implement a single story: code → PR → review → merge. Called from `implement-epic` or standalone.

## Inputs

- `$story` (required): Story issue object or number
- `$epic` (optional): Parent epic for context
- `$repository` (optional): Git repo (default: current workspace)

## Prerequisites

Read: `ai-core-instructions.md`, `dynamic-workflow-syntax.md`, `orchestrate-dynamic-workflow.md`

## Helper Functions

- **getstory($story, $repository)**: Retrieve story issue
- **create_pull_request($story)**: Create PR from feature branch
- **request_automated_reviews($pr)**: Trigger @gemini and @claude reviews
- **update_story_progress($story, $status)**: Update story with progress

## Script

### implement-story

if `$story` is number:
   `$story_issue` = getstory($story, $repository)
else:
   `$story_issue` = `$story`

- log: "Implementing story #{story_issue.number}"

# Implement
- assign the agent the `perform-task` assignment with input `$story_issue`
- wait until agent completes
- record as `#implement-story.perform-task`

# Create PR
`$pull_request` = create_pull_request(#implement-story.perform-task)
- record as `#implement-story.pull-request`

# Automated reviews
- request_automated_reviews($pull_request)
- record as `#implement-story.automated-reviews`

# Merge
- assign agent `pr-approval-and-merge` with input `$pull_request`
- wait until complete
- record as `#implement-story.pr-approval-and-merge`

if result is "merged":
   - record as `#implement-story.pr-merged`
   - close story issue
   - check parent epic progress
else:
   - STOP workflow: manual intervention required

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
