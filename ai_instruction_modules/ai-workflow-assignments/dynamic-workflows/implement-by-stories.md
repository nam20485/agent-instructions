# Dynamic Workflow: Implement by Stories

## Overview

This dynamic workflow performs implementation of an application development plan by systematically completing story issues. It builds upon the breakdown of the plan into epics and stories, ensuring that each story is addressed in sequence or in parallel when appropriate. This workflow is designed to be used with the `orchestrate-dynamic-workflow` assignment.

## Orchestrator Guidance: Parallel vs Serial Execution

The orchestrator should evaluate whether stories within an epic can be implemented in parallel by multiple agents:

### When to Use Parallel Execution
Stories are suitable for parallel execution when:
- ✅ Stories have **minimal or no dependencies** on each other
- ✅ Stories work on **different files or components** with no overlap
- ✅ Stories have **clear, independent acceptance criteria**
- ✅ Each story can be **tested independently** without waiting for others
- ✅ Stories don't require **sequential database migrations or schema changes**
- ✅ The epic's architecture supports **loose coupling** between stories

### When to Use Serial Execution
Stories must be executed serially when:
- ❌ Stories have **dependencies** (Story B requires Story A to be complete)
- ❌ Stories modify the **same files or components** (merge conflicts likely)
- ❌ Stories require **shared resources** that can't be accessed concurrently
- ❌ Stories build **incrementally** (each adds to the previous)
- ❌ Integration testing requires **all stories complete** before validation
- ❌ The epic's architecture has **tight coupling** between components

### Orchestrator Decision Process
1. **Analyze epic structure** and story dependencies
2. **Identify independent story clusters** that can run in parallel
3. **Assess merge conflict risk** based on files each story will modify
4. **Evaluate available agent capacity** for parallel work
5. **Choose execution mode**:
   - **Parallel**: Assign multiple stories to different agents simultaneously
   - **Hybrid**: Assign independent clusters in parallel, dependent stories serially
   - **Serial**: Assign one story at a time in sequence

### Implementation Notes
- When executing in parallel, the orchestrator should track all agent assignments
- Wait for all parallel stories to complete before reviewing the epic as a whole
- Be prepared to handle merge conflicts when integrating parallel work
- Serial execution is the **safe default** when dependencies are unclear

## Script

### Inputs
- `$issue_number` (optional)
  - Issue number of the plan issue to implement
- `$repository` (optional)
  - git repo with plan issue to implement
  - if not provided, use current workspace
- `$parallel_execution` (optional, default: `false`)
  - Whether to execute stories in parallel when possible
  - Set to `true` only when stories are independent and can be safely parallelized

### Declarations

#### getplanissue($issue_number, $repository)
Retrieves the plan issue from the specified repository.
- **Input:** Issue number and repository path
- **Returns:** Issue object containing the application development plan
- **Example:** `getplanissue(42, "myorg/myrepo")` returns issue #42 from myorg/myrepo

#### getepics($plan_issue)
Extracts development epics from the plan issue.
- **Input:** Plan issue object
- **Returns:** Array of epic objects, each containing epic description and requirements and entire content of epic
- **Example:** `getepics($plan_issue)` returns `["Epic 1: User Management", "Epic 2: Product Catalog", ...]`

#### getstories($epic)
Extracts story items from an epic issue.
- **Input:** Epic issue object
- **Returns:** Array of story descriptions to be converted into story issues
- **Example:** `getstories($epic)` returns `["Story 1: User login", "Story 2: Password reset", ...]`

#### analyze_story_dependencies($stories)
Analyzes stories to determine if they can be safely executed in parallel.
- **Input:** Array of story objects
- **Returns:** Boolean indicating whether stories are independent (`true`) or have dependencies (`false`)
- **Analysis includes:**
  - Checking for explicit dependencies between stories
  - Identifying file/component overlap
  - Evaluating shared resource requirements
  - Assessing integration complexity
- **Example:** `analyze_story_dependencies($stories)` returns `true` if stories are independent, `false` if dependencies exist

#### create_pull_request($story)
Creates a pull request for the completed story implementation.
- **Input:** Story object with completed implementation
- **Returns:** Pull request object containing PR number, URL, and metadata
- **Actions:**
  - Creates PR from story's feature branch to target branch
  - Links PR to story issue
  - Sets PR title and description from story details
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

 ### implement-by-stories

`$plan_issue` = getplanissue($issue_number, $repository)
`$epics` = getepics($plan_issue)

For each `$epic` in `$epics`, you will:
   
   # Analyze epic for parallel execution suitability
   $stories = getstories($epic)
   $can_parallelize = analyze_story_dependencies($stories)
   
   # Decision: Parallel or Serial execution
   if `$parallel_execution` is `true` AND `$can_parallelize` is `true`:
      # PARALLEL EXECUTION MODE
      # Assign all stories to agents simultaneously
      For each `$story` in `$stories`, in parallel:
         # Step 1: Implement the story
         - assign an available agent the `perform-task` assignment with input `$story`
         - wait until the agent completes the story implementation
         - record output as `#implement-by-stories.perform-task`
         
         # Step 2: Create pull request for the story
         $pull_request = create_pull_request(#implement-by-stories.perform-task)
         - record PR as `#implement-by-stories.pull-request`
         
         # Step 3: Request automated reviews
         - post comment on `$pull_request`: "@gemini review"
         - post comment on `$pull_request`: "@claude review this PR"
         - wait until both automated reviews complete
         - record reviews as `#implement-by-stories.automated-reviews`
         
         # Step 4: Assign PR approval and merge
         - assign an available agent the `pr-approval-and-merge` assignment with input `$pull_request`
         - wait until the agent completes PR approval and merge
         - record output as `#implement-by-stories.pr-merged`
      
      # Wait for all parallel stories to complete (all PRs merged)
      - wait until all agents finish their assigned stories and PRs are merged
      - collect all outputs as `#implement-by-stories.parallel-complete`
      
      # Review epic integration
      - review all completed work for integration issues
      - resolve any merge conflicts that occurred during parallel merges
      - validate the epic as a whole
      - approve the epic
   
   else:
      # SERIAL EXECUTION MODE (Default/Safe)
      # Assign stories one at a time in sequence
      For each `$story` in `$stories`, you will:
         # Step 1: Implement the story
         - assign the agent the `perform-task` assignment with input `$story`
         - wait until the agent completes the story implementation
         - record output as `#implement-by-stories.perform-task`
         
         # Step 2: Create pull request for the story
         $pull_request = create_pull_request(#implement-by-stories.perform-task)
         - record PR as `#implement-by-stories.pull-request`
         
         # Step 3: Request automated reviews
         - post comment on `$pull_request`: "@gemini review"
         - post comment on `$pull_request`: "@claude review this PR"
         - wait until both automated reviews complete
         - record reviews as `#implement-by-stories.automated-reviews`
         
         # Step 4: Assign PR approval and merge
         - assign an available agent the `pr-approval-and-merge` assignment with input `$pull_request`
         - wait until the agent completes PR approval and merge
         - record output as `#implement-by-stories.pr-merged`
         
         # Step 5: Review and continue
         - review the merged story
         - approve before moving to next story
