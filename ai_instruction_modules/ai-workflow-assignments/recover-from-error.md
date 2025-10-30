# Assignment: Recover From Error During Workflow Assignment Execution

<!-- v2: Introduced tiered retry protocol and objective escalation limits (2025-10-29) -->

## (recover-from-error)

### Goal

Handle errors that occur during workflow assignment execution by following systematic troubleshooting steps, performing escalations when needed, and executing rollback procedures to restore system state.

### Prerequisites

- An error has occurred during workflow assignment execution
- Access to error logs and context about the failure
- Required tools for troubleshooting are available
- Permissions to create issues and notify stakeholders

### Acceptance Criteria

1. Common errors have been identified with symptoms, causes, and solutions documented
2. Escalation procedure has been followed when errors persist after troubleshooting
3. Rollback procedure has been executed when changes need to be reverted
4. Error has been properly documented with full context and attempted solutions
5. Stakeholders have been notified of persistent errors requiring manual intervention
6. Prevention tips have been documented to avoid similar errors in the future

### Assignment

This assignment implements the on-assignment-failure event handler functionality as a standardized workflow assignment. When executed, it handles error recovery processes that should occur when errors are encountered during workflow assignment execution.

The assignment ensures that:
- Errors are systematically diagnosed with root cause analysis
- Common error patterns are identified and addressed with known solutions
- Escalation procedures are followed for persistent issues
- Rollback procedures restore system state when needed
- Errors are properly documented for future reference
- Prevention tips help avoid similar errors in future assignments

### Detailed Steps

#### 1. Identify and Troubleshoot Common Errors

1. Identify the specific error type from the error message and symptoms:
   - Dependency Installation Fails
   - Build Fails
   - Type Checking Fails
   - Linter/Formatter Fails
   - Tests Fail
   - Container Build Fails
   - CI/CD Pipeline Fails

2. For Dependency Installation Fails:
   - Check for symptoms like package installation errors, network timeouts, version conflicts
   - Identify possible causes such as network connectivity issues, incompatible runtime version, corrupted package cache, or version conflicts between dependencies
   - Try solutions in order: verify runtime version, clear package cache, check network connectivity, try installing with legacy flags, check for known issues

3. For Build Fails:
   - Check for symptoms like compilation errors, bundling failures, build process crashes
   - Identify possible causes such as missing dependencies, configuration errors, import/module path issues, syntax errors, or circular dependencies
   - Try solutions in order: verify dependencies, check configuration files, verify import paths, check for circular dependencies, review build output, try clean build

4. For Type Checking Fails:
   - Check for symptoms like type errors or type checking failures
   - Identify possible causes such as type errors in code, missing type definitions, misconfigured type checker, or incompatible type definitions
   - Try solutions in order: check type checker configuration, verify type definition packages, run dependency installation, check for type errors, verify definitions match versions

5. For Linter/Formatter Fails:
   - Check for symptoms like linting errors, warnings, or formatting check failures
   - Identify possible causes such as code style violations, unused variables, missing dependencies, or configuration errors
   - Try solutions in order: run auto-fix command, manually fix remaining issues, check configuration, verify plugins, review error messages

6. For Tests Fail:
   - Check for symptoms like test failures or test runner crashes
   - Identify possible causes such as actual bugs, incorrect test setup, missing dependencies, or environment issues
   - Try solutions in order: review test output, run tests in isolation, verify environment, check dependencies, review test code, ensure test data is available

7. For Container Build Fails:
   - Check for symptoms like Docker build errors or image creation failures
   - Identify possible causes such as Dockerfile syntax errors, missing files, base image issues, or network issues
   - Try solutions in order: check Dockerfile syntax, verify COPY/ADD paths, try pulling base image, check Docker daemon, review build context, try building with --no-cache

8. For CI/CD Pipeline Fails:
   - Check for symptoms like CI workflow failures or deployment errors
   - Identify possible causes such as configuration syntax errors, missing secrets, environment differences, or timeout issues
   - Try solutions in order: check CI configuration syntax, verify secrets, review CI logs, test commands locally, check environment differences, verify timeout settings

#### 2. Follow Escalation Procedure for Persistent Errors (Tiered Retry Protocol)

1. Document the error thoroughly (Diagnostic Log):
   - Capture full error message and stack trace
   - Record steps that led to the error and the exact inputs used
   - Document environment details (OS, runtime version, credentials)
   - List attempted solutions and tag the log as `#recover-from-error.diagnosis`

2. Attempt 1: Targeted Fix (Fast Remediation)
   - Use sequential-thinking to identify the most likely root cause (e.g., missing data interpolation, stale context)
   - Re-fetch required data (e.g., re-run `getepic` to rebuild `$full_epic_json`)
   - Re-template prompts with interpolated values—remove placeholders such as "[paste ...]"
   - Log: "Applied targeted fix; re-delegating with complete data."
   - Retry the specific assignment once with the corrected inputs

3. If Attempt 1 Fails: Attempt 2 (Scratch Retry)
   - Restart the assignment from a clean slate
   - Re-run `pre-assignment-begin` (`gather-context`) to rebuild context
   - Fetch fresh data and regenerate all prompts
   - Treat the retry as brand new execution; log: "Scratch retry initiated due to persistent failure."
   - Delegate the assignment again using the refreshed context

4. If Attempt 2 Fails: Attempt 3 (Final Escalation)
   - Halt the workflow and create a GitHub issue with the complete diagnostic log
   - Tag issue with `bug` and `needs-investigation`, linking the failing assignment
   - Notify stakeholders (orchestrator/user) with summary and request manual intervention
   - Log: "Max retries exceeded; manual intervention required."
   - Do **not** attempt further retries beyond this point

5. Retry Limits and Objectivity
   - Maximum of three attempts (targeted fix, scratch retry, final escalation)
   - Use a different subagent persona (e.g., `qa-test-engineer`) during retries for independent perspective where practical
   - Record outcomes of each attempt to prevent infinite loops and provide traceability

#### 3. Execute Rollback Procedure When Needed

1. Assess the impact of partial changes:
   - Determine what changes were made before the error
   - Identify what needs to be rolled back
   - Check for dependencies on the partial changes

2. Perform the rollback:
   - Use git to revert changes: `git checkout -- .` or `git reset --soft`
   - Delete any generated files or directories
   - Restore from backup if available
   - Clean any build artifacts

3. Verify the rollback was successful:
   - Confirm system is in previous state
   - Test that previous functionality still works
   - Verify no orphaned files remain

4. Document the rollback:
   - Record what was rolled back and why
   - Document lessons learned
   - Update issue/ticket with rollback details
   - Plan next steps for retry or alternative approach

#### 4. Apply Prevention Tips

1. Before starting future assignments:
   - Read assignments completely
   - Verify prerequisites are met
   - Check environment configuration
   - Ensure necessary permissions

2. During execution:
   - Follow steps exactly as specified
   - Verify each step before proceeding
   - Test incrementally rather than waiting until the end
   - Keep detailed notes of what has been done

3. After completion:
   - Run all verification commands
   - Check that acceptance criteria are met
   - Document any deviations from the plan
   - Create validation reports

### Completion

1. **Verify Recover From Error Assignment is Complete:**
   - Error has been properly diagnosed and categorized
   - Appropriate troubleshooting steps have been attempted
   - Escalation or rollback procedure has been executed successfully
   - Error has been documented with full context
   - Prevention tips have been applied
   - Stakeholders have been notified if needed

2. **Present to Stakeholder:**
   - Show the error diagnosis and recovery steps taken
   - Demonstrate that system has been restored to stable state
   - Provide documentation of the error and resolution
   - Explain any prevention measures applied

3. **Stakeholder Review Process:**
   - Ask if they approve the error recovery work
   - Address any questions about the recovery process
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit any recovery documentation
   - Mark the recover-from-error assignment as complete
   - Proceed to next workflow step or retry failed assignment

### Notes

- This assignment is typically executed automatically by workflow orchestrators when errors occur
- The assignment should execute quickly to minimize downtime
- All errors should be thoroughly documented for future reference
- Prevention tips should be applied to avoid similar errors in future assignments
- Communication with stakeholders is critical during error recovery