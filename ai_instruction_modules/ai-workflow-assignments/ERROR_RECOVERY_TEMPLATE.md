# Error Recovery Template

This template should be added to all workflow assignments after the "Detailed Steps" section and before "Completion".

---

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: Dependency Installation Fails
- **Symptoms**: Package installation errors, network timeouts, version conflicts
- **Possible Causes**: 
  - Network connectivity issues
  - Incompatible runtime version
  - Corrupted package cache
  - Version conflicts between dependencies
- **Solutions**:
  1. Verify runtime version matches requirements (Node.js, Python, etc.)
  2. Clear package cache (e.g., `npm cache clean --force`, `pip cache purge`)
  3. Check network connectivity and proxy settings
  4. Try installing with legacy/compatibility flags if needed
  5. Check for known issues with specific package versions

#### Error: Build Fails
- **Symptoms**: Compilation errors, bundling failures, build process crashes
- **Possible Causes**:
  - Missing dependencies
  - Configuration errors
  - Import/module path issues
  - Syntax errors in code
  - Circular dependencies
- **Solutions**:
  1. Verify all dependencies are installed
  2. Check configuration files for syntax errors
  3. Verify import paths are correct
  4. Check for circular dependencies
  5. Review build output for specific error messages
  6. Try clean build (remove build artifacts and rebuild)

#### Error: Type Checking Fails
- **Symptoms**: Type errors, type checking failures
- **Possible Causes**:
  - Type errors in code
  - Missing type definitions
  - Misconfigured type checker
  - Incompatible type definitions
- **Solutions**:
  1. Check type checker configuration for syntax errors
  2. Verify all type definition packages are installed
  3. Run dependency installation to ensure types are current
  4. Check for type errors in source files
  5. Verify type definitions match installed package versions

#### Error: Linter/Formatter Fails
- **Symptoms**: Linting errors or warnings, formatting check failures
- **Possible Causes**:
  - Code style violations
  - Unused variables or imports
  - Missing dependencies
  - Configuration errors
- **Solutions**:
  1. Run auto-fix command (e.g., `npm run lint -- --fix`)
  2. Manually fix remaining issues
  3. Check linter/formatter configuration
  4. Verify all required plugins are installed
  5. Review specific error messages for guidance

#### Error: Tests Fail
- **Symptoms**: Test failures, test runner crashes
- **Possible Causes**:
  - Actual bugs in code
  - Incorrect test setup
  - Missing test dependencies
  - Environment issues
- **Solutions**:
  1. Review test output for specific failures
  2. Run tests in isolation to identify problematic tests
  3. Verify test environment is configured correctly
  4. Check that all test dependencies are installed
  5. Review test code for errors
  6. Ensure test data/fixtures are available

#### Error: Container Build Fails
- **Symptoms**: Docker build errors, image creation failures
- **Possible Causes**:
  - Dockerfile syntax errors
  - Missing files referenced in Dockerfile
  - Base image issues
  - Network issues during build
- **Solutions**:
  1. Check Dockerfile syntax
  2. Verify all COPY/ADD paths are correct
  3. Try pulling base image manually
  4. Check Docker daemon is running
  5. Review build context (.dockerignore)
  6. Try building with --no-cache flag

#### Error: CI/CD Pipeline Fails
- **Symptoms**: CI workflow failures, deployment errors
- **Possible Causes**:
  - Configuration syntax errors
  - Missing secrets/credentials
  - Environment differences
  - Timeout issues
- **Solutions**:
  1. Check CI configuration file syntax
  2. Verify all required secrets are configured
  3. Review CI logs for specific errors
  4. Test commands locally before running in CI
  5. Check for environment-specific issues
  6. Verify timeout settings are appropriate

### Escalation Procedure

If errors persist after troubleshooting:

1. **Document the Error**:
   - Full error message and stack trace
   - Steps that led to the error
   - Environment details (OS, runtime version, etc.)
   - What solutions were attempted
   - Any relevant configuration files

2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug" and "needs-investigation"
   - Link to this assignment
   - Include reproduction steps

3. **Notify User**:
   - Report the error to the user
   - Provide error details and context
   - Request manual intervention
   - Suggest potential next steps

4. **Do Not Proceed**:
   - Do not mark assignment as complete
   - Do not proceed to next assignment
   - Wait for error resolution
   - Document the blocker

### Rollback Procedure

If changes need to be reverted:

1. **Assess Impact**:
   - Determine what changes were made
   - Identify what needs to be rolled back
   - Check for dependencies on the changes

2. **Perform Rollback**:
   - Use git to revert changes: `git checkout -- .` or `git reset --hard`
   - Delete generated files/directories
   - Restore from backup if available
   - Clean build artifacts

3. **Verify Rollback**:
   - Confirm system is in previous state
   - Test that previous functionality still works
   - Verify no orphaned files remain

4. **Document Rollback**:
   - Document what was rolled back and why
   - Record lessons learned
   - Update issue/ticket with rollback details
   - Plan next steps

### Prevention Tips

To avoid common errors:

1. **Before Starting**:
   - Read assignment completely
   - Verify prerequisites are met
   - Check environment is properly configured
   - Ensure you have necessary permissions

2. **During Execution**:
   - Follow steps exactly as specified
   - Verify each step before proceeding
   - Test incrementally (don't wait until the end)
   - Keep notes of what you've done

3. **After Completion**:
   - Run all verification commands
   - Check acceptance criteria are met
   - Document any deviations from plan
   - Create validation report

---

**Note**: This error recovery section should be customized for each specific assignment to include assignment-specific errors and solutions.
