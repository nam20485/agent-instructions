# Assignment: Report Progress After Workflow Step Completion

## (report-progress)

### Goal

Provide progress reporting, output capture, and validation checkpoints after each workflow step completes successfully, enabling visibility into workflow execution and facilitating recovery from interruptions.

### Prerequisites

- Workflow orchestrator is actively executing a dynamic workflow script
- Current workflow step has completed successfully
- Access to step execution context and outputs

### Acceptance Criteria

1. Generate structured progress report with step name, duration, and completion status
2. Capture and record all step outputs for use in subsequent steps
3. Validate that all expected outputs exist and meet format requirements
4. Save workflow state to enable resume-from-checkpoint capability
5. Provide optional user notifications for long-running workflows

### Assignment

This assignment implements the post-step-complete event handler functionality as a standardized workflow assignment. When executed, it handles progress reporting, output capture, validation checks, and state checkpointing after each workflow step completes successfully.

The assignment ensures that:
- Progress is tracked at granular step level
- Issues are caught early before workflow completes
- Execution can resume from the last successful checkpoint if interrupted
- A complete audit trail of execution flow is maintained
- Workflows can define their own custom progress handling actions

### Detailed Steps

#### 1. Generate Progress Report

1. Create structured progress update with the following information:
   - Step name that just completed
   - Execution duration
   - Completion status
   - Key outputs with their values or locations
   - Overall workflow progress (completed steps/total steps with percentage)
   - Next step name (if available)

2. Format the progress report as:
   ```
   === STEP COMPLETE: &lt;step-name> ===
   Status: ✓ COMPLETE
   Duration: &lt;elapsed-time>
   Outputs:
     - &lt;key-output-1>: &lt;value-or-location>
     - &lt;key-output-2>: &lt;value-or-location>
   Progress: &lt;completed-steps>/&lt;total-steps> (&lt;percentage>%)
   Next: &lt;next-step-name>
   ```

#### 2. Capture Step Outputs

1. Record all step outputs for use in subsequent steps:
   - Store output values in workflow context
   - Update variable bindings as needed
   - Record file paths, URLs, or identifiers created during the step
   - Tag outputs with step reference (e.g., `#create-structure.projectDir`)

2. Ensure all outputs are properly documented and accessible:
   - Verify output data types match expectations
   - Confirm file paths are valid if applicable
   - Check that all required outputs are captured

#### 3. Validate Step Acceptance Criteria

1. Verify step acceptance criteria to ensure proper completion:
   - Check that all expected outputs exist
   - Validate output format and structure
   - Confirm side effects occurred (files created, services deployed, etc.)
   - Run quick smoke tests if applicable

2. Document validation results:
   - Record which criteria passed
   - Note any criteria that failed
   - If any criteria fail, trigger appropriate error handling

#### 4. Create Checkpoint State

1. Save workflow state for recovery capabilities:
   - Record completed steps in persistent storage
   - Capture current variable state and bindings
   - Note any warnings or issues encountered during the step
   - Enable resume-from-checkpoint if workflow is interrupted

2. Ensure checkpoint data is properly stored:
   - Verify state saving mechanism is working
   - Confirm checkpoint data is accessible for recovery
   - Test restore functionality if possible

#### 5. Provide User Notification (Optional)

1. For long-running workflows, provide periodic updates to users:
   - Format notification with step completion information
   - Include key metrics like files created or changes made
   - Indicate next step in the workflow

2. Example notification format:
   ```
   ✓ Step 3/8 complete: Application structure created
     Created 24 files in src/MyApp/
     Next: Configure CI/CD pipeline
   ```

### Completion

1. **Verify Report Progress Assignment is Complete:**
   - Progress report was generated and logged
   - All step outputs were captured and stored
   - Validation checks passed successfully
   - Workflow state was checkpointed for recovery
   - User notification was provided (if applicable)

2. **Present to Stakeholder:**
   - Show the generated progress report
   - Demonstrate captured outputs
   - Verify validation results
   - Confirm checkpoint state was saved

3. **Stakeholder Review Process:**
   - Ask if they approve the progress reporting
   - Address any questions about output capture or validation
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit any changes to workflow state
   - Mark the report-progress assignment as complete
   - Proceed to next workflow step

### Notes

- This assignment is typically executed automatically by workflow orchestrators
- The assignment should execute quickly to minimize workflow overhead
- All outputs should be properly tagged for reference in subsequent steps
- Checkpoint data should be stored in a reliable, accessible location