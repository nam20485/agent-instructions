# Assignment: Create Project Structure

## (create-project-structure)

### Goal

Create the actual project structure and scaffolding for a new application based on a comprehensive application plan. This involves creating the solution structure, configuring initial project files, and establishing the development environment foundation.

### Inputs

* Complete and thorough application plan documented in issue and/or .md file.
  * This can be found in the masi planning issue
  * Sometimes also documented in `APP_PLAN.md` file in the root of the repository.
* Application template and linked supporting documents.
  * This can be found in the `docs/ai-new-app-template.md` file in the root of the repository.
  * Supporting documents are linked from the app template and are also included in the `docs/` directory.  

### Acceptance Criteria

1. Solution structure created following established guidelines
3. All required project files and directories established
4. Initial configuration files created (global.json, Docker, etc.)
5. Basic CI/CD pipeline structure established
6. Documentation structure created (README, docs folder, etc.)
7. Development environment properly configured and validated
8. Initial commit made with complete project scaffolding
9. Stakeholder approval obtained for the project structure
10. Repository summary document is created.

### Assignment

You will create the actual project structure and scaffolding for a new application based on the provided application plan. This involves systematic setup of all infrastructure components, following established guidelines, and delivering a ready-to-develop project foundation.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

1. **Create Solution Structure**
   1. Create .NET solution file with appropriate name
   2. Set up global.json with specified .NET version
   3. Create project directories following established naming conventions
   4. Generate initial project files for each component
   5. Configure project references and dependencies

2. **Establish Infrastructure Foundation**
   1. Create Dockerfile for each service/component
   2. Create docker-compose.yml for local development
   3. Set up configuration files (appsettings.json templates)
   4. Create environment variable templates
   <!-- 5. Set up logging and monitoring configuration -->

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

6. **Quality Validation**
   1. Verify solution builds successfully
   2. Validate Docker configurations
   3. Test development environment setup
   4. Verify all documentation is accessible
   5. Ensure project follows established guidelines

7. **Respository Summary Document**
   1. Respository summary document is committed to the repository.
   2. Respository summary document is linked to from the README.md file.
   3. The repository summary is located at the root of the repository in a file called `.ai-repository-summary.md`.
   4. The repository summary is created by following the instructions in the [ai-creating-repository-summary.md](https://github.com/nam20485/agent-instructions/blob/main/ai_instruction_modules/ai-workflow-assignments/ai-creating-repository-summary.md) file.

8. **Initial Commit and Documentation**
   1. Make initial commit with complete structure
   2. Create project status documentation
   3. Document setup and development procedures
   4. Create issue templates for future work
   5. Set up project management structure

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
   - Ask the stakeholder for your next assignment 
