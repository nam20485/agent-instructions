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

## Completion

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
