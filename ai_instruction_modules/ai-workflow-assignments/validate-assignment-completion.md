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
6. If **any** acceptance criterion is not met, the assignment is marked as **failed**

### Assignment

You will validate that the just-completed assignment has successfully met all its requirements. This involves checking file outputs, running verification commands, and creating a validation report.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

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

**For .NET C# Assignments:**
```bash
# Restore dependencies
dotnet restore

# Run build
dotnet build

# Run tests
dotnet test

# Run linter (using dotnet-format)
dotnet tool install -g dotnet-format
dotnet format --check

# run application (if applicable)
dotnet run --project <ProjectName>.csproj
# (then stop it)
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
