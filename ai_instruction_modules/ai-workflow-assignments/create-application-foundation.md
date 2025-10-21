# Assignment: Create Application Foundation

## (create-application-foundation)

### Goal

Set up the foundational project files, dependency management, and build configuration for any application type. This establishes the base layer that all applications need regardless of technology stack or architecture.

### Prerequisites

* Complete and thorough application plan documented in issue and/or .md file
  * This can be found in the main planning issue
  * Sometimes also documented in `APP_PLAN.md` file in the root of the repository
* Application template and linked supporting documents
  * This can be found in the `plan_docs/ai-new-app-template.md` file in the root of the repository
  * Supporting documents are linked from the app template and are also included in the `plan_docs/` directory

### Acceptance Criteria

1. Project initialized with version control (git)
2. Dependency manifest created and dependencies installable
3. Build system configured and builds successfully
4. Code quality tools configured and pass on empty project
5. Directory structure created following established conventions
6. Environment configuration documented
7. All configuration files are valid and functional

### Assignment

You will create the foundational layer for a new application based on the provided application plan. This involves setting up dependency management, build tools, code quality tools, and the basic directory structure that all applications need.

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

#### 1. Initialize Project

1. Create project root directory with appropriate name
2. Initialize version control (git)
   - Run `git init` (if not already initialized)
   - Create `.gitignore` appropriate for the tech stack
   - Make initial commit with .gitignore
3. Create README.md with project overview
   - Project name and description
   - Technology stack
   - Basic setup instructions (to be expanded later)

#### 2. Configure Dependency Management

1. Create dependency manifest based on tech stack:
   - **Node.js/TypeScript**: `package.json` with npm/yarn/pnpm
   - **Python**: `requirements.txt`, `pyproject.toml`, or `Pipfile`
   - **Rust**: `Cargo.toml`
   - **Java**: `pom.xml` or `build.gradle`
   - **C#/.NET**: `.csproj` files and `global.json`
   - **Go**: `go.mod`
   - **Ruby**: `Gemfile`
   - **PHP**: `composer.json`

2. Define core dependencies based on application plan
3. Define development dependencies (linters, formatters, test tools)
4. Lock dependency versions (package-lock.json, poetry.lock, Cargo.lock, etc.)
5. Run dependency installation to verify it works

#### 3. Configure Build System

1. Set up build tool configuration based on tech stack:
   - **JavaScript/TypeScript**: vite.config.ts, webpack.config.js, tsconfig.json
   - **Python**: setup.py, pyproject.toml
   - **Rust**: Cargo.toml build configuration
   - **Java**: pom.xml or build.gradle
   - **C#/.NET**: .csproj files with build settings
   - **Go**: go.mod and build tags
   - **Ruby**: Rakefile
   - **PHP**: composer.json scripts

2. Configure compilation/transpilation settings
   - Set language version/target
   - Configure strict mode/warnings
   - Set up source maps (if applicable)

3. Set up module resolution
   - Configure import paths
   - Set up path aliases (if needed)
   - Configure module system (ESM, CommonJS, etc.)

4. Configure output directories
   - Build output directory (dist/, build/, target/, bin/, etc.)
   - Temporary files directory
   - Add output directories to .gitignore

5. Test the build
   - Run build command
   - Verify output is created
   - Verify no errors or warnings

#### 4. Configure Code Quality Tools

1. Set up linter configuration based on tech stack:
   - **JavaScript/TypeScript**: .eslintrc.cjs or eslint.config.js
   - **Python**: .pylintrc, .flake8, or pyproject.toml
   - **Rust**: clippy configuration in Cargo.toml
   - **Java**: checkstyle.xml or PMD configuration
   - **C#/.NET**: .editorconfig and analyzers in .csproj
   - **Go**: golangci-lint.yml
   - **Ruby**: .rubocop.yml
   - **PHP**: phpcs.xml

2. Set up formatter configuration:
   - **JavaScript/TypeScript**: .prettierrc
   - **Python**: .black, pyproject.toml
   - **Rust**: rustfmt.toml
   - **Java**: google-java-format or similar
   - **C#/.NET**: .editorconfig
   - **Go**: gofmt (built-in)
   - **Ruby**: .rubocop.yml
   - **PHP**: .php-cs-fixer.php

3. Configure pre-commit hooks (if applicable)
   - Install pre-commit framework
   - Configure hooks for linting and formatting
   - Test hooks work correctly

4. Set up type checking (if applicable)
   - **TypeScript**: tsconfig.json with strict mode
   - **Python**: mypy.ini or pyproject.toml
   - **PHP**: psalm.xml or phpstan.neon

5. Test code quality tools
   - Run linter on empty project
   - Run formatter check
   - Run type checker (if applicable)
   - Verify all pass with 0 errors

#### 5. Create Directory Structure

1. Create source directory based on conventions:
   - **Node.js/TypeScript**: `src/`
   - **Python**: `src/` or package name directory
   - **Rust**: `src/`
   - **Java**: `src/main/java/` and `src/main/resources/`
   - **C#/.NET**: Project-specific directories
   - **Go**: Package directories
   - **Ruby**: `lib/`
   - **PHP**: `src/`

2. Create public/static assets directory (if needed)
   - `public/`, `static/`, `assets/`, `wwwroot/`, etc.

3. Create documentation directory
   - `docs/` for project documentation
   - Create placeholder files for future docs

4. Create configuration directory (if needed)
   - `config/`, `conf/`, etc.
   - Separate configs for different environments

5. Create test directory structure
   - `tests/`, `test/`, `__tests__/`, `spec/`, etc.
   - Mirror source directory structure

#### 6. Create Environment Configuration

1. Create `.env.example` with required variables
   - List all environment variables needed
   - Provide example values (not real secrets)
   - Document what each variable is for

2. Document environment variables
   - Create ENV_VARS.md or add to README
   - Explain required vs optional variables
   - Provide guidance on obtaining values

3. Set up environment-specific configs
   - Development configuration
   - Staging configuration (if applicable)
   - Production configuration template

4. Create configuration loading mechanism
   - Set up config loader in code
   - Validate required variables are present
   - Provide helpful error messages for missing config

## Progress Reporting

This assignment has multiple steps and may take 45-60 minutes. Report progress at these checkpoints:

### Checkpoint 1: Project Initialization (25% complete)

**Tasks**:
- [ ] Project root directory created
- [ ] Git initialized with .gitignore
- [ ] README.md created
- [ ] Dependency manifest created

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 1 Complete (25%)
- Completed: Project initialized, git setup, package.json created
- Issues: None
- Time remaining: ~40 minutes
- Next: Configure build system
```

---

### Checkpoint 2: Build System Configuration (50% complete)

**Tasks**:
- [ ] Build tool configuration created
- [ ] Compilation/transpilation settings configured
- [ ] Module resolution configured
- [ ] Output directories configured
- [ ] Build tested successfully

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 2 Complete (50%)
- Completed: Build system configured, tsconfig.json created, build passes
- Issues: Had to adjust module resolution settings
- Time remaining: ~25 minutes
- Next: Configure code quality tools
```

---

### Checkpoint 3: Code Quality Tools (75% complete)

**Tasks**:
- [ ] Linter configured
- [ ] Formatter configured
- [ ] Pre-commit hooks configured (if applicable)
- [ ] Type checking configured (if applicable)
- [ ] All tools tested and passing

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 3 Complete (75%)
- Completed: ESLint, Prettier, and TypeScript configured
- Issues: None
- Time remaining: ~15 minutes
- Next: Create directory structure and environment config
```

---

### Final Checkpoint: Complete (100%)

**Tasks**:
- [ ] Directory structure created
- [ ] Environment configuration documented
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
- Completed: Full application foundation with dependencies, build system, code quality tools, and directory structure
- Total time: 55 minutes
- Issues resolved: Module resolution configuration
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

#### Error: Build Configuration Invalid
- **Symptoms**: Build fails with configuration errors, syntax errors in config files
- **Possible Causes**:
  - Syntax errors in configuration files
  - Invalid configuration options
  - Missing required configuration fields
  - Incompatible configuration settings
- **Solutions**:
  1. Validate configuration file syntax (JSON, YAML, etc.)
  2. Check documentation for correct configuration options
  3. Verify all required fields are present
  4. Test with minimal configuration first
  5. Compare with working examples from similar projects

#### Error: Linter/Formatter Configuration Fails
- **Symptoms**: Linter or formatter fails to run, configuration errors
- **Possible Causes**:
  - Invalid configuration syntax
  - Missing plugins or dependencies
  - Incompatible versions
  - Conflicting rules
- **Solutions**:
  1. Validate configuration file syntax
  2. Verify all required plugins are installed
  3. Check version compatibility between tools
  4. Start with minimal configuration and add rules incrementally
  5. Review documentation for correct configuration format

#### Error: Directory Creation Fails
- **Symptoms**: Cannot create directories, permission errors
- **Possible Causes**:
  - Insufficient permissions
  - Directory already exists
  - Invalid directory names
  - File system issues
- **Solutions**:
  1. Check file system permissions
  2. Verify directory doesn't already exist
  3. Ensure directory names are valid for the OS
  4. Try creating directories manually to test permissions
  5. Check available disk space

#### Error: Git Initialization Fails
- **Symptoms**: Git commands fail, repository not initialized
- **Possible Causes**:
  - Git not installed
  - Already a git repository
  - Insufficient permissions
  - Corrupted git configuration
- **Solutions**:
  1. Verify git is installed: `git --version`
  2. Check if already a git repository: `ls -la .git`
  3. Verify permissions in the directory
  4. Try initializing in a different directory
  5. Check global git configuration

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

1. **Verify Foundation is Complete:**
   - All dependencies install successfully
   - Build command runs without errors
   - Linter and formatter pass on empty project
   - Directory structure matches conventions
   - Environment configuration is documented

2. **Present to Stakeholder:**
   - Demonstrate that dependencies install
   - Show that build works
   - Show that code quality tools are configured
   - Present the directory structure

3. **Stakeholder Review Process:**
   - Ask if they approve the foundation setup
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit all foundation files
   - Mark the foundation creation as complete once approved
   - Proceed to next assignment (Application Structure)

### Notes

- This assignment is tech-stack agnostic - adapt file names and tools to your specific technology
- Focus on establishing a solid foundation that follows best practices
- All applications need these foundational elements regardless of their purpose
- The foundation should be complete before moving to application structure
