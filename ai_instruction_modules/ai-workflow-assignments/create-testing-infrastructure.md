# Assignment: Create Testing Infrastructure

## (create-testing-infrastructure)

### Goal

Set up testing infrastructure and create initial test suite to establish testing culture from the start. This assignment works with any testing framework and tech stack.

### Prerequisites

* Application Foundation completed (dependencies, build system)
* Application Structure completed (entry point, core components)
* Understanding of the application's architecture and components

### Applicability

Works with any testing framework:
- **JavaScript/TypeScript**: Jest, Vitest, Mocha, Jasmine
- **Python**: pytest, unittest, nose
- **Java**: JUnit, TestNG
- **C#**: xUnit, NUnit, MSTest
- **Go**: testing package
- **Rust**: cargo test
- **Ruby**: RSpec, Minitest

### Acceptance Criteria

1. Test framework configured and working
2. Test directory structure created
3. Test utilities created
4. At least 5 smoke tests passing
5. Test command works (e.g., `npm test`, `pytest`, `cargo test`)
6. Coverage reporting configured
7. docs/TESTING.md created with clear documentation
8. Example tests demonstrate best practices

### Assignment

You will set up the testing infrastructure and create an initial test suite. This establishes testing patterns and culture from the beginning of the project.

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
  - Check what files were created
  - Understand current project state
  - Verify previous work is complete
- Check for related issues or PRs
  - Search for similar work
  - Review any existing discussions
  - Check for known issues
- Review project documentation
  - Read README and setup guides
  - Check architecture documentation
  - Review coding standards
- Understand current state
  - What's already been done
  - What's left to do
  - Any blockers or dependencies

### 3. Verify Prerequisites

- Check that required tools are installed
  - Runtime environment (Node.js, Python, etc.)
  - Build tools
  - Package managers
  - Development tools
- Verify previous assignments completed
  - Check acceptance criteria were met
  - Verify outputs are available
  - Confirm no blockers exist
- Ensure dependencies are met
  - External services available
  - Required credentials accessible
  - Network connectivity working
- Confirm environment is ready
  - Correct versions installed
  - Environment variables set
  - Permissions configured

### 4. Create Task List

- Break down steps into specific tasks
  - List all major tasks
  - Identify subtasks
  - Estimate time for each
- Identify potential challenges
  - Technical challenges
  - Integration points
  - Unknown areas
- Note any questions or uncertainties
  - What needs clarification
  - What might need research
  - What could go wrong
- Plan the approach
  - Order of operations
  - Parallel vs sequential work
  - Checkpoints for validation

### 5. Estimate Time

- Review estimated time for assignment
  - Understand the baseline estimate
  - Consider assignment complexity
- Consider your specific context
  - Your familiarity with tech stack
  - Complexity of the project
  - Any unique challenges
- Add buffer for unexpected issues
  - 20-30% buffer recommended
  - More for unfamiliar territory
  - Less for well-known tasks
- Plan accordingly
  - Schedule uninterrupted time
  - Plan for breaks
  - Set realistic expectations

### 6. Prepare Environment

- Set up workspace
  - Close unnecessary applications
  - Open required tools
  - Prepare terminal/IDE
- Gather required resources
  - Documentation links
  - Reference materials
  - Example code
- Create backup if needed
  - Commit current state
  - Tag important points
  - Document starting point

**Only proceed once all preparation steps are complete.**

### Detailed Steps

#### 1. Configure Test Framework

1. Install test framework appropriate for the tech stack:
   - **JavaScript/TypeScript**: `npm install --save-dev jest` or `vitest`
   - **Python**: `pip install pytest` or use built-in `unittest`
   - **Java**: Add JUnit dependency to pom.xml or build.gradle
   - **C#**: Add xUnit/NUnit/MSTest package to .csproj
   - **Go**: Built-in `testing` package
   - **Rust**: Built-in `cargo test`
   - **Ruby**: `gem install rspec` or use built-in minitest

2. Create test configuration file:
   - **Jest**: `jest.config.js` or `jest.config.ts`
   - **Vitest**: `vitest.config.ts`
   - **pytest**: `pytest.ini` or `pyproject.toml`
   - **JUnit**: Configuration in pom.xml or build.gradle
   - **xUnit/NUnit**: Configuration in .csproj or test project
   - **Go**: No config file needed
   - **Rust**: Configuration in `Cargo.toml`
   - **RSpec**: `.rspec` file

3. Configure test environment:
   - Set up test database (if needed)
   - Configure test environment variables
   - Set up browser environment (for frontend tests)
   - Configure test timeouts

4. Configure coverage reporting tool:
   - **JavaScript/TypeScript**: Built into Jest/Vitest
   - **Python**: `pip install pytest-cov`
   - **Java**: JaCoCo plugin
   - **C#**: Coverlet package
   - **Go**: Built-in coverage
   - **Rust**: `cargo-tarpaulin` or `cargo-llvm-cov`
   - **Ruby**: SimpleCov gem

#### 2. Create Test Directory Structure

1. Create unit test directory:
   - **JavaScript/TypeScript**: `src/__tests__/` or `tests/unit/`
   - **Python**: `tests/unit/` or `tests/`
   - **Java**: `src/test/java/`
   - **C#**: Separate test project
   - **Go**: `*_test.go` files alongside source
   - **Rust**: `tests/` directory or inline tests
   - **Ruby**: `spec/` directory

2. Create integration test directory (if applicable):
   - `tests/integration/`
   - `tests/e2e/`
   - Separate from unit tests

3. Create test fixtures/mocks directory:
   - `tests/fixtures/`
   - `tests/mocks/`
   - `tests/__mocks__/` (Jest)

4. Create test utilities/helpers directory:
   - `tests/utils/`
   - `tests/helpers/`
   - Shared test utilities

#### 3. Create Test Utilities

1. Create test helper functions:
   - Setup/teardown helpers
   - Database seeding helpers
   - API client helpers
   - File system helpers

2. Create mock/stub factories for common dependencies:
   - Database mocks
   - API client mocks
   - External service mocks
   - Configuration mocks

3. Create test data builders/fixtures:
   - Factory functions for test data
   - Fixture files with sample data
   - Builder pattern for complex objects

4. Create custom assertions/matchers (if needed):
   - Domain-specific assertions
   - Custom matchers for common checks
   - Error message helpers

#### 4. Write Initial Smoke Tests

Create at least 5 smoke tests covering:

1. **Core Module/Class**: Basic instantiation and initialization
   ```javascript
   // Example: JavaScript/TypeScript
   describe('Application', () => {
     it('should initialize without errors', () => {
       const app = new Application();
       expect(app).toBeDefined();
     });
   });
   ```

2. **Configuration**: Configuration loading works correctly
   ```python
   # Example: Python
   def test_configuration_loads():
       config = load_configuration()
       assert config is not None
       assert config.app_name is not None
   ```

3. **Utilities**: Core utility functions work as expected
   ```java
   // Example: Java
   @Test
   public void testStringUtilityWorks() {
       String result = StringUtils.capitalize("hello");
       assertEquals("Hello", result);
   }
   ```

4. **Entry Point**: Application/module starts without errors
   ```go
   // Example: Go
   func TestApplicationStarts(t *testing.T) {
       app := NewApplication()
       err := app.Initialize()
       if err != nil {
           t.Errorf("Application failed to initialize: %v", err)
       }
   }
   ```

5. **Integration**: Basic integration between components works
   ```rust
   // Example: Rust
   #[test]
   fn test_service_integration() {
       let service = Service::new();
       let result = service.process();
       assert!(result.is_ok());
   }
   ```

#### 5. Create Test Examples

1. Create example unit test with clear structure:
   - Arrange-Act-Assert pattern
   - Clear test names
   - Good comments explaining the test
   - Edge cases covered

2. Create example integration test (if applicable):
   - Test multiple components together
   - Test realistic scenarios
   - Clean up after test

3. Create example mock usage:
   - Show how to mock dependencies
   - Show how to verify mock calls
   - Show how to stub return values

4. Add comments explaining test patterns:
   - Explain the testing approach
   - Document common patterns
   - Provide guidance for future tests

#### 6. Configure Test Commands

1. Add test run command to build system:
   - **npm**: `"test": "jest"` or `"test": "vitest"`
   - **Python**: `pytest` command
   - **Java**: Maven `test` goal or Gradle `test` task
   - **C#**: `dotnet test`
   - **Go**: `go test ./...`
   - **Rust**: `cargo test`
   - **Ruby**: `rspec` or `rake test`

2. Add coverage command:
   - `npm run test:coverage`
   - `pytest --cov`
   - `cargo test --coverage`
   - `dotnet test /p:CollectCoverage=true`

3. Add watch mode command (if applicable):
   - `npm run test:watch`
   - `pytest --watch`
   - `cargo watch -x test`

4. Add test filtering/selection commands:
   - Run specific test files
   - Run tests matching pattern
   - Run only failed tests

#### 7. Document Testing Approach

1. Create `docs/TESTING.md` with:
   - Overview of testing strategy
   - How to run tests
   - How to write tests
   - Testing patterns and best practices
   - Coverage requirements
   - Examples of good tests

2. Document how to run tests:
   - Command to run all tests
   - Command to run specific tests
   - Command to run with coverage
   - Command to run in watch mode

3. Document how to write tests:
   - Test file naming conventions
   - Test structure (Arrange-Act-Assert)
   - Mocking and stubbing
   - Test data management

4. Document testing patterns and best practices:
   - Unit test best practices
   - Integration test best practices
   - What to test and what not to test
   - Test naming conventions

5. Provide test examples:
   - Example unit test
   - Example integration test
   - Example with mocks
   - Example with fixtures

6. Document coverage requirements:
   - Minimum coverage percentage
   - What should be covered
   - What can be excluded
   - How to view coverage reports

## Progress Reporting

This assignment has multiple steps and may take 60-90 minutes. Report progress at these checkpoints:

### Checkpoint 1: Test Framework Configuration (25% complete)

**Tasks**:
- [ ] Test framework installed
- [ ] Test configuration file created
- [ ] Test environment configured
- [ ] Coverage reporting configured
- [ ] Test directory structure created

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 1 Complete (25%)
- Completed: Jest installed and configured, test directories created
- Issues: None
- Time remaining: ~60 minutes
- Next: Create test utilities
```

---

### Checkpoint 2: Test Utilities and Fixtures (50% complete)

**Tasks**:
- [ ] Test helper functions created
- [ ] Mock/stub factories created
- [ ] Test data builders/fixtures created
- [ ] Custom assertions/matchers created (if needed)
- [ ] Utilities tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 2 Complete (50%)
- Completed: Test utilities, mocks, and fixtures created
- Issues: Had to adjust mock factory for async operations
- Time remaining: ~40 minutes
- Next: Write initial smoke tests
```

---

### Checkpoint 3: Initial Smoke Tests (75% complete)

**Tasks**:
- [ ] Core module/class test written
- [ ] Configuration test written
- [ ] Utilities test written
- [ ] Entry point test written
- [ ] Integration test written
- [ ] All tests passing

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 3 Complete (75%)
- Completed: 5 smoke tests written and passing
- Issues: None
- Time remaining: ~20 minutes
- Next: Configure test commands and documentation
```

---

### Final Checkpoint: Complete (100%)

**Tasks**:
- [ ] Test run command configured
- [ ] Coverage command configured
- [ ] Watch mode command configured (if applicable)
- [ ] Test filtering commands configured
- [ ] TESTING.md documentation created
- [ ] All validation passed
- [ ] Acceptance criteria verified

**Report**: Provide final summary including:
- All completed work
- Total time taken
- Any issues resolved
- Final status

**Example Report**:
```
✅ Assignment Complete (100%)
- Completed: Full testing infrastructure with 5 passing tests, coverage reporting, and comprehensive documentation
- Total time: 80 minutes
- Issues resolved: Async mock factory configuration
- Status: Ready for review
```

---

### How to Report Progress

After completing each checkpoint, provide a brief update including:

1. **What was completed**:
   - List specific tasks finished
   - Highlight major milestones
   - Note any deliverables created

2. **Any issues encountered**:
   - Describe problems faced
   - Explain how they were resolved
   - Note any ongoing concerns

3. **Estimated time remaining**:
   - Calculate based on progress
   - Adjust for complexity
   - Account for any delays

4. **Next steps**:
   - What comes next
   - Any dependencies
   - Expected timeline

### Progress Tracking Tips

- **Be honest about progress**: Don't overestimate completion
- **Report blockers immediately**: Don't wait until the end
- **Update estimates**: Adjust time estimates as you learn more
- **Document issues**: Keep notes on problems and solutions
- **Celebrate milestones**: Acknowledge progress at each checkpoint

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: Test Framework Installation Fails
- **Symptoms**: Package installation errors, dependency conflicts
- **Possible Causes**:
  - Incompatible versions
  - Missing peer dependencies
  - Network issues
  - Corrupted package cache
- **Solutions**:
  1. Check framework version compatibility with runtime
  2. Install missing peer dependencies
  3. Clear package cache and retry
  4. Try alternative test framework if issues persist
  5. Check framework documentation for known issues

#### Error: Tests Fail to Run
- **Symptoms**: Test runner crashes, configuration errors, no tests found
- **Possible Causes**:
  - Invalid test configuration
  - Incorrect test file patterns
  - Missing test dependencies
  - Environment issues
- **Solutions**:
  1. Verify test configuration syntax
  2. Check test file naming matches pattern
  3. Ensure all test dependencies are installed
  4. Verify test environment is configured correctly
  5. Run with verbose/debug mode to see detailed errors

#### Error: Coverage Reporting Fails
- **Symptoms**: Coverage not generated, coverage tool errors
- **Possible Causes**:
  - Coverage tool not installed
  - Invalid coverage configuration
  - Source files not found
  - Incompatible coverage tool version
- **Solutions**:
  1. Verify coverage tool is installed
  2. Check coverage configuration is valid
  3. Ensure source file paths are correct
  4. Check coverage tool version compatibility
  5. Test with minimal coverage configuration first

#### Error: Mock/Stub Creation Fails
- **Symptoms**: Mocking errors, stub not working as expected
- **Possible Causes**:
  - Incorrect mock syntax
  - Mocking framework issues
  - Trying to mock unmockable objects
  - Circular dependencies
- **Solutions**:
  1. Review mocking framework documentation
  2. Check mock syntax is correct
  3. Verify object can be mocked
  4. Look for circular dependency issues
  5. Try manual mocks instead of auto-mocking

#### Error: Tests Are Flaky
- **Symptoms**: Tests pass/fail inconsistently, timing issues
- **Possible Causes**:
  - Race conditions
  - Shared state between tests
  - Timing dependencies
  - External service dependencies
- **Solutions**:
  1. Ensure tests are independent
  2. Clean up state between tests
  3. Use proper async/await patterns
  4. Mock external dependencies
  5. Increase timeouts for slow operations

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

### Completion

1. **Verify Testing Infrastructure is Complete:**
   - All tests pass
   - Coverage reporting works
   - Test commands work
   - Documentation is clear and complete

2. **Present to Stakeholder:**
   - Demonstrate running tests
   - Show coverage report
   - Walk through test examples
   - Show testing documentation

3. **Stakeholder Review Process:**
   - Ask if they approve the testing infrastructure
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit all testing files
   - Mark the testing infrastructure creation as complete once approved
   - Proceed to next assignment (CI/CD Infrastructure or Deployment Infrastructure)

### Notes

- **Framework-agnostic**: Adapt to the specific testing framework being used
- **Focus on patterns**: Establish testing patterns, not comprehensive coverage
- **Smoke tests**: Should be simple, fast, and demonstrate the test infrastructure works
- **Documentation critical**: Good testing docs encourage team adoption
- **Coverage baseline**: Even 20-30% coverage is better than 0%
- Tests should be fast and reliable
- Avoid flaky tests
- Keep tests independent of each other
