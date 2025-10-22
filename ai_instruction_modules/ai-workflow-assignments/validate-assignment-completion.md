# Assignment: Validate Assignment Completion

## (validate-assignment-completion)

### Goal

Validate that a completed assignment has successfully met all its acceptance criteria and that all outputs are functional. This assignment is typically called from the `post-assignment-completion` event in dynamic workflows.

### Prerequisites

* An assignment has just completed
* Assignment acceptance criteria are documented
* Assignment outputs are available for verification

### Acceptance Criteria

1. All required files from assignment exist
2. All verification commands pass (build, test, lint, etc.)
3. Validation report created documenting results
4. Pass/fail status determined
5. If failed, specific remediation steps provided

### Assignment

You will validate that the just-completed assignment has successfully met all its requirements. This involves checking file outputs, running verification commands, and creating a validation report.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

## Before Starting

Before beginning this assignment, complete these preparation steps:

### 1. Read Assignment Completely

- Read through all detailed steps
- Understand the overall goal
- Review acceptance criteria
- Note any dependencies on other assignments
- Identify potential challenges

### 2. Gather Context

- Review previous assignment outputs
  - Check what assignment just completed
  - Review that assignment's acceptance criteria
  - Understand expected outputs
  - Verify assignment file is accessible
- Check for related issues or PRs
  - Look for validation reports from similar work
  - Review any existing validation failures
  - Check for known validation issues
- Review project documentation
  - Understand project structure
  - Review build/test commands
  - Check deployment configurations
- Understand current state
  - What was just completed
  - What files were changed
  - What needs to be validated

### 3. Verify Prerequisites

- Check that required tools are installed
  - Build tools (npm, cargo, mvn, etc.)
  - Test runners (jest, pytest, etc.)
  - Linters and formatters
  - Docker (if deployment validation needed)
- Verify previous assignments completed
  - Assignment to validate is marked complete
  - Assignment outputs are available
  - No obvious blockers exist
- Ensure dependencies are met
  - All project dependencies installed
  - Build environment configured
  - Test environment ready
- Confirm environment is ready
  - Correct runtime versions
  - Environment variables set
  - Permissions configured

### 4. Create Task List

- Break down steps into specific tasks
  - Identify assignment to validate (~1 min)
  - Verify file outputs (~2 min)
  - Run verification commands (~3-5 min)
  - Create validation report (~2 min)
  - Determine pass/fail (~1 min)
- Identify potential challenges
  - Commands might fail
  - Build environment issues
  - Missing dependencies
  - Long-running tests
- Note any questions or uncertainties
  - Which commands to run
  - What constitutes passing
  - How to handle warnings
- Plan the approach
  - Order of verification steps
  - Parallel vs sequential checks
  - When to abort validation

### 5. Estimate Time

- Review estimated time for assignment
  - Baseline: 5-10 minutes
  - Consider assignment complexity
- Consider your specific context
  - Build time for project
  - Test suite runtime
  - Complexity of verification
- Add buffer for unexpected issues
  - 20-30% buffer recommended
  - More if build/tests are slow
  - Account for command failures
- Plan accordingly
  - Schedule uninterrupted time
  - Ensure clean environment
  - Set realistic expectations

### 6. Prepare Environment

- Set up workspace
  - Clean terminal/console
  - Navigate to project root
  - Close unnecessary applications
- Gather required resources
  - Assignment file to validate
  - Verification command documentation
  - Validation report template
- Create backup if needed
  - Commit current state
  - Tag validation checkpoint
  - Document starting point

**Only proceed once all preparation steps are complete.**

### Detailed Steps

#### 1. Identify Assignment to Validate

1. Determine which assignment was just completed
   - Check workflow context
   - Identify assignment name/ID
   - Locate assignment file

2. Read assignment acceptance criteria
   - Open assignment markdown file
   - Extract acceptance criteria section
   - List all criteria to verify

3. Identify expected outputs
   - Files that should be created
   - Commands that should work
   - Configuration that should be valid

#### 2. Verify Assignment Outputs

1. Check that all required files exist:
   - List files from acceptance criteria
   - Verify each file exists
   - Check file permissions are correct
   - Verify directories were created

2. Verify file contents (if specified):
   - Check configuration files are valid
   - Verify code files have expected structure
   - Check documentation is present

3. Record file verification results:
   - List of files checked
   - Which files exist
   - Which files are missing
   - Any permission issues

#### 3. Run Verification Commands

Based on assignment type, run appropriate verification commands:

**For Foundation Assignments:**
```bash
# Install dependencies
npm install  # or pip install, cargo build, etc.

# Run build
npm run build  # or cargo build, mvn compile, etc.

# Run linter
npm run lint  # or pylint, cargo clippy, etc.

# Run formatter check
npm run format:check  # or black --check, cargo fmt --check, etc.
```

**For Structure Assignments:**
```bash
# Run type checker
tsc --noEmit  # or mypy, cargo check, etc.

# Run linter
npm run lint

# Try to start application
npm run dev  # or python main.py, cargo run, etc.
# (then stop it)
```

**For Testing Assignments:**
```bash
# Run tests
npm test  # or pytest, cargo test, mvn test, etc.

# Run with coverage
npm run test:coverage

# Verify coverage report exists
ls coverage/  # or htmlcov/, target/coverage/, etc.
```

**For Deployment Assignments:**
```bash
# Build Docker image (if applicable)
docker build -t test-image .

# Run CI workflow locally (if possible)
act  # or gitlab-runner exec, etc.

# Verify deployment scripts are executable
chmod +x deploy.sh
./deploy.sh --dry-run  # if supported
```

1. Run each verification command
2. Capture exit codes
3. Capture output (stdout and stderr)
4. Record success/failure for each command

#### 4. Check Exit Codes

1. Verify all commands exit with code 0:
   - Build command: exit code 0
   - Test command: exit code 0
   - Lint command: exit code 0
   - Type check command: exit code 0

2. If any command fails:
   - Record which command failed
   - Capture error message
   - Identify root cause if possible

3. Categorize failures:
   - Critical: Build fails, tests fail
   - Warning: Linter warnings, type warnings
   - Info: Documentation issues, style issues

#### 5. Create Validation Report

1. Create validation report file:
   - Location: `docs/validation/VALIDATION_REPORT_<assignment-name>_<timestamp>.md`
   - Create docs/validation/ directory if needed

2. Document validation results:
   ```markdown
   # Validation Report: <Assignment Name>
   
   **Date**: <timestamp>
   **Assignment**: <assignment-name>
   **Status**: ✅ PASSED / ❌ FAILED / ⚠️ WARNINGS
   
   ## Summary
   
   Brief summary of validation results.
   
   ## File Verification
   
   ### Expected Files
   - ✅ file1.ts - Present
   - ✅ file2.ts - Present
   - ❌ file3.ts - Missing
   
   ### Unexpected Issues
   - None / List issues
   
   ## Command Verification
   
   ### Build
   - Command: `npm run build`
   - Exit Code: 0
   - Status: ✅ PASSED
   - Output: [truncated or link to full output]
   
   ### Tests
   - Command: `npm test`
   - Exit Code: 0
   - Status: ✅ PASSED
   - Tests Run: 5
   - Tests Passed: 5
   - Coverage: 85%
   
   ### Linter
   - Command: `npm run lint`
   - Exit Code: 0
   - Status: ✅ PASSED
   - Errors: 0
   - Warnings: 0
   
   ## Acceptance Criteria Verification
   
   1. ✅ Criterion 1 - Met
   2. ✅ Criterion 2 - Met
   3. ❌ Criterion 3 - Not met (reason)
   
   ## Issues Found
   
   ### Critical Issues
   - None / List critical issues
   
   ### Warnings
   - None / List warnings
   
   ## Recommendations
   
   - Recommendation 1
   - Recommendation 2
   
   ## Conclusion
   
   Overall assessment and pass/fail decision.
   
   ## Next Steps
   
   - What should happen next
   - Any required fixes
   ```

3. Include all verification details:
   - What was checked
   - Results of each check
   - Any errors or warnings
   - Recommendations

#### 6. Determine Pass/Fail Status

1. Evaluate overall status:
   - **PASSED**: All acceptance criteria met, all commands succeed
   - **PASSED WITH WARNINGS**: All critical criteria met, minor warnings present
   - **FAILED**: One or more acceptance criteria not met, or critical commands failed

2. Document decision rationale:
   - Why passed or failed
   - Which criteria were not met
   - Impact of any warnings

3. Provide remediation steps if failed:
   - Specific steps to fix issues
   - Which files need changes
   - Which commands to re-run
   - How to verify fixes

#### 7. Report Results

1. Print validation summary to console:
   ```
   ========================================
   VALIDATION RESULTS: <assignment-name>
   ========================================
   Status: ✅ PASSED / ❌ FAILED / ⚠️ WARNINGS
   
   Files Checked: X/Y passed
   Commands Run: X/Y passed
   Acceptance Criteria: X/Y met
   
   Report: docs/validation/VALIDATION_REPORT_<assignment-name>_<timestamp>.md
   ========================================
   ```

2. If failed, block progression:
   - Do NOT proceed to next assignment
   - Notify user of validation failure
   - Provide link to validation report
   - Request manual intervention

3. If passed, allow progression:
   - Log validation success
   - Save validation report
   - Proceed to next assignment

## Error Recovery

If an error occurs during validation, follow these steps:

### Common Validation Errors

#### Error: Assignment File Not Found
- **Symptoms**: Cannot locate assignment file to validate, 404 errors, file path issues
- **Possible Causes**: 
  - Incorrect assignment name/ID
  - Assignment file moved or renamed
  - Workflow context not properly passed
  - Typo in assignment identifier
- **Solutions**:
  1. Verify assignment name matches workflow context
  2. Search for assignment file in standard locations (`ai_instruction_modules/ai-workflow-assignments/`)
  3. Check for recent file renames in git history
  4. Confirm assignment ID format (should be kebab-case)
  5. Review workflow script for correct assignment references

#### Error: Verification Command Not Found
- **Symptoms**: Command not found errors, shell errors, executable not in PATH
- **Possible Causes**:
  - Required build tools not installed
  - Missing dependencies (npm, cargo, mvn, etc.)
  - PATH environment variable misconfigured
  - Wrong working directory
- **Solutions**:
  1. Verify required tools are installed: `which npm`, `which cargo`, etc.
  2. Install missing tools according to project documentation
  3. Check working directory is project root
  4. Add tool location to PATH if needed
  5. Verify tool versions match project requirements

#### Error: Build Command Fails
- **Symptoms**: Compilation errors, build process exits with non-zero code
- **Possible Causes**:
  - Code errors introduced by assignment
  - Missing dependencies
  - Configuration errors
  - Environment setup issues
- **Solutions**:
  1. Review build output for specific errors
  2. Check if dependencies need to be installed/updated
  3. Verify configuration files are valid
  4. Compare with known-good build from before assignment
  5. Run dependency installation: `npm install`, `cargo build`, etc.
  6. Check for circular dependencies or import errors

#### Error: Test Command Fails
- **Symptoms**: Test failures, test runner crashes, assertion errors
- **Possible Causes**:
  - Tests legitimately failed (code quality issue)
  - Test environment not configured
  - Missing test dependencies
  - Test fixtures missing
  - Tests are flaky
- **Solutions**:
  1. Review test output to understand failures
  2. Determine if tests are legitimate failures or environment issues
  3. If legitimate failures, mark validation as FAILED
  4. If environment issues, fix environment and retry
  5. Check test fixtures and test data are available
  6. Run tests in isolation to identify problematic tests
  7. Verify test environment variables are set

#### Error: Lint/Format Command Fails
- **Symptoms**: Linter errors, format check failures, style violations
- **Possible Causes**:
  - Code style violations introduced
  - Linter configuration issues
  - Missing linter dependencies
  - Incorrect linter version
- **Solutions**:
  1. Check if violations are legitimate (assignment didn't follow style guide)
  2. If legitimate, mark validation as FAILED or WARNINGS depending on severity
  3. Run auto-fix if appropriate: `npm run lint -- --fix`
  4. Verify linter configuration is correct
  5. Check linter dependencies are installed
  6. Review specific linting errors for guidance

#### Error: Docker Build Fails
- **Symptoms**: Docker build errors, image creation failures, Dockerfile errors
- **Possible Causes**:
  - Dockerfile syntax errors
  - Missing files referenced in Dockerfile
  - Base image unavailable
  - Docker daemon not running
  - Network issues
- **Solutions**:
  1. Check Docker daemon is running: `docker info`
  2. Verify Dockerfile syntax
  3. Check all COPY/ADD paths exist
  4. Try pulling base image manually: `docker pull <base-image>`
  5. Review build context and .dockerignore
  6. Try build with --no-cache flag
  7. Check Docker logs for detailed errors

#### Error: Missing Expected Files
- **Symptoms**: Files from acceptance criteria don't exist
- **Possible Causes**:
  - Assignment didn't complete successfully
  - Files were created in wrong location
  - File paths are incorrect
  - Files were deleted accidentally
- **Solutions**:
  1. Search for files in project: `find . -name "<filename>"`
  2. Check git status for untracked files: `git status`
  3. Review assignment steps to see if files should have been created
  4. Mark validation as FAILED if files truly missing
  5. Provide specific remediation: which files need to be created
  6. Check for typos in expected file names

#### Error: Validation Report Creation Fails
- **Symptoms**: Cannot write validation report, file system errors, permission errors
- **Possible Causes**:
  - docs/validation/ directory doesn't exist
  - Permission issues
  - Disk space issues
  - Invalid file path
- **Solutions**:
  1. Create docs/validation/ directory if missing: `mkdir -p docs/validation`
  2. Check file system permissions
  3. Verify disk space available: `df -h`
  4. Use alternative path if needed
  5. Simplify report filename if path too long
  6. Check for invalid characters in filename

#### Error: Command Times Out
- **Symptoms**: Commands hang, exceed reasonable execution time, no progress
- **Possible Causes**:
  - Long-running tests
  - Infinite loops in code
  - Waiting for user input
  - Network operations hanging
  - Resource constraints
- **Solutions**:
  1. Identify which command is hanging
  2. Check if command requires user input (avoid interactive commands)
  3. Add timeout flags to commands if supported
  4. Run command manually to diagnose issue
  5. Check system resources (CPU, memory)
  6. Consider skipping long-running commands and noting in report
  7. For tests, try running subset: `npm test -- --testPathPattern=<pattern>`

#### Error: Exit Code Ambiguous
- **Symptoms**: Unclear if non-zero exit code is critical, warnings vs errors
- **Possible Causes**:
  - Command returns warnings as exit code 1
  - Tool has non-standard exit codes
  - Different exit codes for different error types
- **Solutions**:
  1. Check tool documentation for exit code meanings
  2. Review command output to understand severity
  3. Categorize as CRITICAL, WARNING, or INFO
  4. If warnings only, consider PASSED WITH WARNINGS status
  5. Document exit code interpretation in validation report
  6. Consult project guidelines for acceptance thresholds

### Escalation Procedure

If validation errors persist or are ambiguous:

1. **Document the Error**:
   - Capture complete validation output
   - Note which acceptance criterion failed
   - Document environment details
   - Record what solutions were attempted
   - Save command outputs and error messages

2. **Create Validation Report**:
   - Create report even if incomplete
   - Document what was checked and what failed
   - Mark status as FAILED
   - Include detailed error information
   - Provide remediation recommendations

3. **Notify User**:
   - Report validation failure immediately
   - Provide link to validation report
   - Explain which acceptance criteria not met
   - Recommend next steps (fix issues or investigate)
   - Do NOT proceed to next assignment

4. **Halt Workflow**:
   - Mark validation as FAILED
   - Do not proceed to next assignment
   - Block workflow progression
   - Wait for manual intervention
   - Document the blocker in workflow context

### False Positives

If you suspect a validation failure is a false positive:

1. **Investigate Thoroughly**:
   - Re-run verification commands
   - Check for environment-specific issues
   - Compare with baseline/known-good state
   - Review recent changes that might affect validation

2. **Document Investigation**:
   - Note why failure might be false positive
   - Document evidence supporting this theory
   - Include comparison with expected behavior

3. **Escalate for Confirmation**:
   - Create validation report with findings
   - Mark as NEEDS REVIEW
   - Request user confirmation
   - Do not bypass validation without approval

4. **Adjust Validation if Confirmed**:
   - Update acceptance criteria if too strict
   - Adjust verification commands if incorrect
   - Document the adjustment rationale
   - Re-run validation with updated criteria

### Prevention Tips

To avoid validation errors:

1. **Before Starting Validation**:
   - Ensure assignment actually completed
   - Verify all prerequisites met
   - Check tools are installed and working
   - Review assignment acceptance criteria carefully

2. **During Validation**:
   - Run commands from project root directory
   - Capture all output for later reference
   - Test commands manually if automated execution fails
   - Document each step's results

3. **After Validation**:
   - Review validation report for completeness
   - Verify all acceptance criteria were checked
   - Confirm status determination is accurate
   - Provide clear remediation steps for failures

### Event Integration

This assignment is designed to be called from the `post-assignment-completion` event in dynamic workflows:

```markdown
### Events

#### `post-assignment-completion`

`$validation_assignments` = [`validate-assignment-completion`]

For each `$assignment_name` in `$validation_assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the validation results
   - if validation failed, halt workflow and request manual intervention
   - if validation passed, record output as `#events.post-assignment-completion.$assignment_name`
   - proceed to next assignment only if validation passed
```

### Completion

1. **Verify Validation is Complete:**
   - Validation report created
   - All checks performed
   - Pass/fail status determined
   - Results documented

2. **Present to Stakeholder (if failed):**
   - Show validation report
   - Explain what failed
   - Provide remediation steps
   - Request approval to proceed or fix

3. **Finalization:**
   - Save validation report
   - Return pass/fail status to workflow
   - If passed, allow workflow to continue
   - If failed, halt workflow

### Notes

- This assignment is typically automated via events, not run manually
- Validation should be fast (< 5 minutes)
- Focus on critical checks, not exhaustive testing
- Provide actionable remediation steps
- Keep validation reports for audit trail
- Validation prevents cascading failures
- Early validation catches issues before they compound
