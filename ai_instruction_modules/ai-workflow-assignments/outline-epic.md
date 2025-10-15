# Assignment: Outline Epic Implementation

## (outline-epic)

### Goal

Create a comprehensive structural outline for a single **EXISTING** epic with all of its **EXISTING** stories. The epic and all story issues ALREADY EXIST in GitHub - you are NOT creating new issues. You are writing CODE (classes, interfaces, methods) based on the requirements in these existing issues.

This involves creating all main classes, interfaces, methods, and functions WITHOUT implementation (no function bodies). Provide comprehensive XML comment documentation for all classes and members describing their purpose, behavior, parameters, return values, and other important details. Create test case stubs for all functionality to enable Test-Driven Development (TDD) during the subsequent implementation stage.

This outline serves as the architectural blueprint that will be filled in with actual implementation code in the next stage.

### Inputs
- `$epic`: Epic issue object containing the epic name, description, requirements, story breakdown, and entire content from an **EXISTING GitHub issue**

### Output
- Complete structural outline with:
  - All classes defined (no implementation in methods)
  - All interfaces defined
  - All public methods and functions declared (signatures only)
  - Comprehensive XML documentation comments for all types and members
  - Test case stubs created for all functionality
  - Project compiles successfully (despite having no implementation)
- Returns the outlined epic object for downstream processing

### Acceptance Criteria

1. **EXISTING** Application Plan issue has been retrieved and reviewed
2. **EXISTING** Epic issue has been retrieved and reviewed (from GitHub, not created)
3. All **EXISTING** story issues within the epic have been retrieved and reviewed (from GitHub, not created)
4. All main classes have been created with class-level XML documentation
5. All interfaces have been created with interface-level XML documentation
6. All public methods and functions have been declared with complete signatures
7. Method/function bodies contain only `throw new NotImplementedException()` or language-equivalent placeholder
8. Every class has comprehensive XML documentation describing its purpose and responsibilities
9. Every method/function has comprehensive XML documentation including:
   - Summary of what it does
   - Description of each parameter (with `<param>` tags)
   - Description of return value (with `<returns>` tag)
   - Any exceptions thrown (with `<exception>` tags)
   - Remarks for important behavior or usage notes (with `<remarks>` tag)
10. Test case classes have been created for every production class
11. Test method stubs have been created for every public method/function
12. Test methods follow naming convention: `MethodName_Scenario_ExpectedBehavior`
13. Test methods contain `// Arrange`, `// Act`, `// Assert` comment sections
14. Project structure follows the plan's architecture
15. All necessary `using`/`import` statements are included
16. Code follows project coding standards and conventions
17. Project builds successfully without errors
18. All files are committed to a feature branch
19. Epic outline object is returned for workflow tracking
20. **NO NEW ISSUES WERE CREATED** - only code files were created

### Assignment

> **⚠️ CRITICAL INSTRUCTION - READ THIS FIRST ⚠️**
>
> **THE EPIC AND ALL STORIES ALREADY EXIST AS GITHUB ISSUES!**
> 
> - You are **NOT** creating new issues
> - You are **READING** existing issues and **WRITING CODE**
> - The `$epic` input contains an EXISTING GitHub issue
> - All stories are EXISTING sub-issues of the epic
> - Your job: Read the issues, then create CODE FILES (classes, interfaces, tests)
> 
> **If you find yourself creating GitHub issues, STOP - you're doing it wrong!**

Your assignment is to create the complete structural outline (CODE FILES ONLY) for an **EXISTING** epic and all of its **EXISTING** stories. The epic and stories ALREADY EXIST as GitHub issues - you will retrieve and read them, NOT create new ones.

This is a critical architectural phase that establishes the foundation for implementation.

**CRITICAL: About the Epic and Stories**
- ✅ The epic issue ALREADY EXISTS in GitHub - retrieve it using the `$epic` input
- ✅ All story issues ALREADY EXIST in GitHub - retrieve them from the epic
- ✅ You are creating CODE FILES (classes, interfaces, tests), NOT GitHub issues
- ❌ DO NOT create new epic or story issues
- ❌ DO NOT recreate issues that already exist
- ❌ DO NOT use GitHub issue creation commands or APIs

**What You WILL Do:**
- ✅ Retrieve and read the EXISTING epic issue from GitHub
- ✅ Retrieve and read all EXISTING story issues from the epic
- ✅ Create all class files with empty classes (CODE FILES)
- ✅ Define all interfaces with method signatures (CODE FILES)
- ✅ Declare all public methods with complete signatures (CODE FILES)
- ✅ Write comprehensive XML documentation for everything
- ✅ Create test class files with test method stubs (CODE FILES)
- ✅ Ensure the project compiles

**What You WILL NOT Do:**
- ❌ Create or recreate any GitHub issues (epic or stories)
- ❌ Write any implementation code in method bodies
- ❌ Create private helper methods (add during implementation)
- ❌ Write actual test assertions or test logic
- ❌ Implement any business logic
- ❌ Add error handling code

**The Outline's Purpose:**
This outline serves as a contract between the design and implementation phases. During the next implementation phase, developers will:
1. Review the XML documentation to understand intent
2. Run existing test stubs (which will fail)
3. Implement method bodies to make tests pass (TDD)
4. Add additional private methods as needed

This assignment is typically invoked by the `design-app-outline` dynamic workflow, which orchestrates the creation of outlines for all epics in a plan.

**Always follow instructions given here and as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Epic Hierarchy Context

This assignment creates **Implementation Outlines** for an entire Epic including all its Stories:

```
┌─────────────────────────────────────┐
│     Main Application Plan Issue     │  ← Top level: Overall application plan
└─────────────────────────────────────┘
                 │
        ┌────────┼────────┐
        │        │        │
┌───────▼──┐ ┌──▼──────┐ ┌▼────────┐
│ Phase 1  │ │ Phase 2 │ │ Phase 3 │
│  EPIC    │ │  EPIC   │ │  EPIC   │  ← **THIS LEVEL**: Outlines created for Epic + Stories
└──────────┘ └─────────┘ └─────────┘     (This assignment outlines ONE Epic)
     │            │           │
  ┌──┼──┐      ┌─┼─┐      ┌──┼──┐
  │  │  │      │ │ │      │  │  │
  ▼  ▼  ▼      ▼ ▼ ▼      ▼  ▼  ▼
Story1 2 3   Story4 5 6  Story7 8 9   ← All stories are outlined together
```

**Your Role:** You are outlining ONE Epic including ALL of its Stories in a single pass.

### References

* Example of well-documented code outline:
  * Classes with XML documentation
  * Methods with parameter and return documentation
  * Test stubs with proper structure

### Detailed Steps

1. **Retrieve and Review EXISTING Epic and Stories (NO ISSUE CREATION)**
   - **IMPORTANT:** The epic and stories ALREADY EXIST in GitHub as issues
   - Extract the epic issue number/URL from the `$epic` input object
   - Retrieve the EXISTING epic issue from GitHub (use GitHub API or gh CLI)
   - Read the epic's name, description, and requirements
   - Retrieve all EXISTING story issues that are sub-issues of this epic
   - Read each story's requirements, tasks, and acceptance criteria
   - **DO NOT CREATE ANY NEW ISSUES** - only read existing ones
   - Identify all features and functionality to be implemented across all stories
   - Understand the component architecture and technology stack from the plan
   - Review the parent plan's project structure
   - Note any dependencies or prerequisites
   - Create a mental model of the class hierarchy and relationships needed

2. **Design Class Structure (CODE ARCHITECTURE)**
   - Based on the EXISTING story requirements, design the code architecture
   - Identify all main classes needed across all stories
   - Determine which classes should implement interfaces
   - Design interface hierarchies and contracts
   - Plan class relationships (inheritance, composition, dependencies)
   - Map classes to the project structure directories
   - Consider separation of concerns (models, services, controllers, etc.)
   - Identify DTOs, entities, view models, and other data structures
   - Plan for dependency injection and IoC patterns

3. **Create Classes and Interfaces (CODE FILES ONLY)**
   - **REMINDER:** You are creating CODE FILES, not GitHub issues
   - Create all interface files first
     - Define interface method signatures
     - Add comprehensive XML documentation to interfaces
     - Include parameter and return value documentation
   - Create all class files
     - Add class declarations with inheritance/interface implementations
     - Add comprehensive XML documentation to classes
     - Document the class purpose and responsibilities
   - Ensure proper namespace organization
   - Add necessary `using`/`import` statements
   - Follow project naming conventions

4. **Declare Methods and Functions**
   - For each class, declare all public methods and functions
   - Include complete method signatures:
     - Return type
     - Method name (following naming conventions)
     - All parameters with types and names
     - Visibility modifiers (public, protected)
     - Virtual/override/abstract keywords as appropriate
   - Add placeholder implementation:
     - `throw new NotImplementedException();` (C#)
     - `throw new Error("Not implemented");` (TypeScript)
     - `raise NotImplementedError()` (Python)
     - Language-appropriate equivalent
   - DO NOT add private helper methods (those come during implementation)
   - DO NOT add any actual logic or business rules

5. **Write Comprehensive XML Documentation**
   - For every class, write XML documentation including:
     - `<summary>`: Clear description of the class purpose
     - `<remarks>`: Important usage notes or design decisions
     - Example usage if complex
   - For every method/function, write XML documentation including:
     - `<summary>`: What the method does (not how)
     - `<param name="paramName">`: Description of each parameter's purpose
     - `<returns>`: Description of what is returned
     - `<exception cref="ExceptionType">`: When and why exceptions are thrown
     - `<remarks>`: Special behavior, side effects, or important notes
   - Use clear, concise language
   - Focus on WHAT and WHY, not HOW (implementation comes later)
   - Include examples in documentation for complex APIs
   - Document any assumptions or preconditions

6. **Create Test Case Stubs**
   - Create a test class for every production class
     - Name: `<ClassName>Tests` or `<ClassName>Test`
     - Place in test project parallel structure
   - For every public method, create test method stubs:
     - Follow naming: `MethodName_Scenario_ExpectedBehavior`
     - Example: `GetUser_WithValidId_ReturnsUser`
     - Example: `GetUser_WithInvalidId_ThrowsNotFoundException`
   - Structure each test method:
     ```csharp
     [Test] // or [Fact], [TestMethod], etc.
     public void MethodName_Scenario_ExpectedBehavior()
     {
         // Arrange
         // TODO: Set up test data and dependencies
         
         // Act
         // TODO: Call the method under test
         
         // Assert
         // TODO: Verify expected behavior
         
         Assert.Fail("Test not implemented");
     }
     ```
   - Create test stubs for:
     - Happy path scenarios
     - Edge cases
     - Error conditions
     - Boundary conditions
   - Add test class-level documentation
   - Include necessary test framework attributes/decorators

7. **Verify Project Structure**
   - Ensure all files are in correct directories per project structure
   - Verify namespace/package hierarchy is correct
   - Check that file names match class names
   - Confirm folder structure follows architectural patterns
   - Validate separation of production and test code
   - Ensure proper project references are in place

8. **Build and Validate**
   - Build the entire project
   - Verify zero compilation errors
   - Fix any syntax errors or missing references
   - Ensure all interfaces are properly implemented
   - Verify method signatures match interface contracts
   - Confirm XML documentation has no warnings (if enabled)
   - Run static analysis tools if available
   - Verify code style compliance

9. **Create Feature Branch and Commit**
   - Create a feature branch: `feature/outline-<epic-name>`
   - Stage all new files
   - Commit with descriptive message:
     ```
     feat: Add outline for <Epic Name>
     
     - Created classes: <list main classes>
     - Created interfaces: <list interfaces>
     - Added comprehensive XML documentation
     - Created test stubs for TDD
     
     Relates to #<epic-issue-number>
     ```
   - Push feature branch to remote
   - DO NOT merge yet (implementation comes next)

10. **Quality Validation**
    - Review checklist:
      - [ ] **VERIFIED: Read EXISTING epic issue from GitHub (did not create new issue)**
      - [ ] **VERIFIED: Read EXISTING story issues from GitHub (did not create new issues)**
      - [ ] All classes from all stories are created (CODE FILES)
      - [ ] All interfaces are defined (CODE FILES)
      - [ ] All public methods have signatures only (no implementation)
      - [ ] Every class has XML documentation
      - [ ] Every method has complete XML documentation
      - [ ] Every parameter is documented
      - [ ] Every return value is documented
      - [ ] Test classes exist for all production classes (CODE FILES)
      - [ ] Test methods exist for all public methods
      - [ ] Test methods follow naming conventions
      - [ ] Project builds successfully
      - [ ] Code committed to feature branch
      - [ ] **NO NEW GITHUB ISSUES WERE CREATED**
    - Run through manual review of 2-3 sample classes
    - Verify documentation is comprehensive and clear
    - Ensure consistency across all files
    - **Final check:** Confirm you only created code files, not GitHub issues

### Completion

1. **Finalize Outline:**
   - Confirm all classes, interfaces, and tests are created (CODE FILES)
   - Verify project builds without errors
   - Ensure all code is committed to feature branch
   - Validate XML documentation is comprehensive
   - **VERIFY: NO GITHUB ISSUES WERE CREATED** - you only read existing issues and created code files
   - **DO NOT IMPLEMENT METHOD BODIES.** Implementation comes in the next phase.
   - **DO NOT MERGE TO MAIN.** Feature branch stays open for implementation.

2. **Generate Outline Summary:**
   - Create a summary document or comment including:
     - Number of classes created
     - Number of interfaces created
     - Number of test stubs created
     - Number of public methods declared
     - Feature branch name
     - Build status (successful/failed)
     - Any notes or considerations for implementation phase

3. **Return Epic Outline Object:**
   - Return the outlined epic object to the calling workflow
   - The object should include:
     - Epic issue reference
     - Feature branch name
     - List of created files
     - Build status
     - Summary statistics
   - This enables the workflow to:
     - Track outline completion
     - Prepare for implementation phase
     - Generate progress reports

4. **Prepare for Implementation Phase:**
   - Document any design decisions made during outlining
   - Note any potential challenges discovered
   - Flag any areas that may need architectural review
   - Create a checklist for the implementation phase
   - The feature branch is now ready for TDD implementation

**Note:** This outline phase is complete when the structure compiles and all documentation is in place. The next phase (implementation) will fill in method bodies using Test-Driven Development.

## Language-Specific Guidance

### C# / .NET
- Use XML documentation comments (`///`)
- Implement interfaces explicitly
- Use `NotImplementedException` for method bodies
- Create xUnit/NUnit/MSTest test classes
- Follow PascalCase for classes/methods, camelCase for parameters

### TypeScript / JavaScript
- Use JSDoc comments (`/** */`)
- Define interfaces with TypeScript
- Use `throw new Error("Not implemented")` for method bodies
- Create Jest/Mocha test suites
- Follow PascalCase for classes, camelCase for methods

### Python
- Use docstrings (`"""..."""`)
- Define protocols or abstract base classes
- Use `raise NotImplementedError()` for method bodies
- Create pytest test classes
- Follow PascalCase for classes, snake_case for methods

### Java
- Use JavaDoc comments (`/** */`)
- Define interfaces and abstract classes
- Use `throw new UnsupportedOperationException()` for method bodies
- Create JUnit test classes
- Follow PascalCase for classes, camelCase for methods

## Epic Outline Template

The outline should follow this structure for each class:

```csharp
/// <summary>
/// [Clear description of the class purpose and responsibilities]
/// </summary>
/// <remarks>
/// [Important usage notes, design decisions, or context]
/// </remarks>
public class ClassName : IInterface
{
    /// <summary>
    /// [What this method does - the business purpose]
    /// </summary>
    /// <param name="paramName">[Purpose and expected values for this parameter]</param>
    /// <returns>[Description of what is returned and when]</returns>
    /// <exception cref="ExceptionType">[When and why this exception is thrown]</exception>
    /// <remarks>
    /// [Special behavior, side effects, or important implementation notes]
    /// </remarks>
    public ReturnType MethodName(ParamType paramName)
    {
        throw new NotImplementedException();
    }
}
```

Test stub structure:

```csharp
/// <summary>
/// Tests for <see cref="ClassName"/>
/// </summary>
public class ClassNameTests
{
    [Test]
    public void MethodName_HappyPath_ReturnsExpectedResult()
    {
        // Arrange
        // TODO: Set up test data and dependencies
        
        // Act
        // TODO: Call the method under test
        
        // Assert
        // TODO: Verify expected behavior
        
        Assert.Fail("Test not implemented");
    }
}
```
