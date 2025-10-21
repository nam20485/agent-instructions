# Dynamic Workflow: Implement Story

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

# Step 6: Assign PR approval and merge
- assign the agent the `pr-approval-and-merge` assignment with input `$pull_request`
- wait until the agent completes PR approval and merge
- record output as `#implement-story.pr-merged`
- log: "PR #{pull_request.number} merged for story #{story_issue.number}"

# Step 7: Final story update and closure
- update_story_progress($story_issue, "PR merged, story implementation complete")
- close the story issue with completion summary
- record completion as `#implement-story.complete`
- log: "Story #{story_issue.number} complete"
