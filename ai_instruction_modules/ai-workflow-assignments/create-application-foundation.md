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
