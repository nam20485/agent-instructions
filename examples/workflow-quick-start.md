# Workflow Quick Start Examples

## Example 1: Orchestrate an Existing Dynamic Workflow
1. Read the workflow file: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/breakdown-plan.md`
2. Read the orchestration assignment: `ai_instruction_modules/ai-workflow-assignments/orchestrate-dynamic-workflow.md`
3. Run validation: assign yourself `validate-dynamic-workflow-script` with $workflow_name=`breakdown-plan`
4. If validation passes, assign yourself `orchestrate-dynamic-workflow` with $workflow_name=`breakdown-plan`
5. Follow the orchestration assignment's detailed steps exactly
6. Execute all events at their designated lifecycle points
7. Produce the Run Report with evidence for all acceptance criteria

## Example 2: Create a New Simple Assignment
1. Copy template: `ai_instruction_modules/ai-workflow-assignments/ai-workflow-assignment-empty-template.md`
2. Save as: `ai_instruction_modules/ai-workflow-assignments/my-new-task.md`
3. Fill in all sections:
   - Title: "Create Feature Documentation"
   - Short ID: (create-feature-docs)
   - Goal: "Create comprehensive documentation for a new feature"
   - Acceptance Criteria: List 5-10 specific, measurable criteria
   - Assignment: Detailed description of the task
   - Detailed Steps: Step-by-step instructions with sub-bullets
   - Completion: Finalization steps
4. Add to master index in `ai-workflow-assignments.md`
5. Test by running the assignment

## Example 3: Add Events to Existing Dynamic Workflow
1. Read the existing workflow file
2. Add "Events" section as third-level heading under "Script":
   
   ### Events
   
   #### `pre-script-begin`
   - validate environment
   - record as `#events.pre-script-begin`
   
   #### `post-assignment-complete`
   `$summary_tasks` = [`create-repository-summary`]
   
   For each `$assignment_name` in `$summary_tasks`, you will:
      - assign the agent the `$assignment_name` assignment
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#events.post-assignment-complete.$assignment_name`
   
   #### `post-script-complete`
   - generate final report
   - record completion as `#events.post-script-complete`
   
3. Validate using `validate-dynamic-workflow-script`
4. Test by orchestrating the workflow
5. Verify events execute at correct lifecycle points
6. Confirm event outputs appear in Run Report

## Example 4: Validate Before Orchestrating
1. Assign yourself: `validate-dynamic-workflow-script`
2. Provide input: $workflow_name=`implement-by-stories`
3. Check validation output:
   - Syntax correctness
   - All assignment IDs exist
   - Event definitions valid (if present)
   - Logical structure coherent
4. If validation passes: proceed to orchestration
5. If validation fails: fix issues and re-validate
