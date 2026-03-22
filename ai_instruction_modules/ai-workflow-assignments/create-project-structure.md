# Assignment: Create Project Structure

## (create-project-structure)

### Goal

Create the actual project structure and scaffolding for a new application based on a comprehensive application plan. This involves creating the solution structure, configuring initial project files, and establishing the development environment foundation.

* Complete and thorough application plan documented in issue and/or .md file.
  * This can be found in the masi planning issue
  * Sometimes also documented in `APP_PLAN.md` file in the root of the repository.
* Application template and linked supporting documents.
  * This can be found in the `plan_docs/ai-new-app-template.md` file in the root of the repository.
  * Supporting documents are linked from the app template and are also included in the `plan_docs/` directory.  

### Acceptance Criteria

1. Solution/project structure created following the application plan's tech stack
2. All required project files and directories established
3. Initial configuration files created (version pinning, Docker, etc.)
4. Basic CI/CD pipeline structure established
5. Documentation structure created (README, docs folder, etc.)
6. Development environment properly configured and validated
7. Initial commit made with complete project scaffolding
8. Stakeholder/Delegating Agent approval obtained for the project structure
9. Repository summary document is created.
10. All GitHub Actions workflows have their actions pinned to the specific commit SHA of their latest release.

### Assignment

You will create the actual project structure and scaffolding for a new application based on the provided application plan. This involves systematic setup of all infrastructure components, following established guidelines, and delivering a ready-to-develop project foundation.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

> **Tech-stack selection:** Read the application plan (`plan_docs/`, `APP_PLAN.md`, or the
> planning issue) to determine the target tech stack. The steps below use generic terms.
> Adapt solution files, package managers, and project conventions to the actual stack
> (e.g. `.sln`/`.csproj` for .NET, `pyproject.toml`/`uv` for Python, `package.json` for Node, etc.).

1. **Create Solution / Project Structure**
   1. Create the appropriate solution or workspace file for the chosen tech stack
   2. Set up version pinning (e.g. `global.json` for .NET, `.python-version` for Python, `.nvmrc` for Node)
   3. Create project directories following established naming conventions
   4. Generate initial project files for each component
   5. Configure project references and dependencies
   6. Configure project-specific quality settings as appropriate for the tech stack (e.g. treat-warnings-as-errors, linting rules, type checking)

2. **Establish Infrastructure Foundation**
   1. Create Dockerfile for each service/component
      - **IMPORTANT:** When using `uv pip install -e .` or similar editable installs, ensure `COPY src/ ./src/` (or the equivalent source directory) appears **before** the install command. Copying only `pyproject.toml` first and then running the install will fail because the source tree is missing at install time.
   2. Create docker-compose.yml for local development
      - **IMPORTANT:** Do NOT use `curl` in healthcheck commands — the base image may not have curl installed. Use Python's stdlib instead:
        ```yaml
        healthcheck:
          test: ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"]
        ```
   3. Set up configuration files (appsettings.json templates)
   4. Create environment variable templates

3. **Create Development Environment**
   1. Create scripts for environment setup
   2. Set up development database configurations
   3. Create initial test project structure
   4. Configure build and development tools
   5. Set up debugging configurations

4. **Establish Documentation Structure**
   1. Create comprehensive README.md
   2. Set up docs/ directory with template files
   3. Create API documentation structure
   4. Set up architecture decision records (ADRs)
   5. Create deployment and setup guides

5. **Initialize CI/CD Foundation**
   1. Create .github/workflows directory
   2. Set up basic build workflow template
   3. Configure quality gates templates
   4. Set up deployment workflow structure
   5. Create security scanning configurations
   6. **IMPORTANT:** All actions in created/modified workflows MUST be pinned to their specific commit SHA for their latest release (e.g., `uses: actions/checkout@<full-commit-sha>`). Do not use major/minor version tags.

6. **Quality Validation**
   1. Verify solution builds successfully
   2. Validate Docker configurations
   3. Test development environment setup
   4. Verify all documentation is accessible
   5. Ensure project follows established guidelines

7. **Respository Summary Document**
   1. Repository summary document is committed to the repository.
   2. Repository summary document is linked to from the README.md file.
   3. The repository summary is located at the root of the repository in a file called `.ai-repository-summary.md`.
   4. The repository summary is created by following the instructions in the [create-repository-summary.md](https://github.com/nam20485/agent-instructions/blob/main/ai_instruction_modules/create-repository-summary.md) file.

8. **Initial Commit and Documentation**
   1. Make initial commit with complete structure
   2. Create project status documentation
   3. Document setup and development procedures
   4. Create issue templates for future work
   5. Set up project management structure

### Validation

1. Present the structure to the stakeholder
2. Verify build and configuration
3. Obtain approval

### Example Project Structures

Adapt the structure to the tech stack specified in the application plan. Below are reference examples — adjust as needed.

#### .NET

```text
/
   SolutionName/
      ProjectName.API/
         Controllers/
         Models/
         Services/
         ProjectName.API.csproj
      ProjectName.Application/
         Interfaces/
      ...
      Tests/
         TestProjectName/
            TestClasses.cs
            TestProjectName.csproj
      SolutionName.slnx
```

#### Python (uv)

```text
/
   src/
      package_name/
         __init__.py
         main.py
         api/
         models/
         services/
   tests/
      test_main.py
   pyproject.toml
   Dockerfile
   docker-compose.yml
```

#### Node.js / TypeScript

```text
/
   src/
      index.ts
      routes/
      models/
      services/
   tests/
      index.test.ts
   package.json
   tsconfig.json
   Dockerfile
   docker-compose.yml
```

### Completion

1. **Present project structure to stakeholder:**
   - Demonstrate that the solution builds successfully
   - Show that all infrastructure components are configured
   - Present the documentation and development environment

2. **Stakeholder review process:**
   - Ask if they approve the project structure and setup
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

3. **Finalization:**
   - Mark the project structure creation as complete once approved
   - Ensure all team members have access to the repository
   <!-- - After approval, assign a copilot the breakdown-issue.md assignment to each -->
   - Ask the delegating agent or stakeholder for your next assignment 
