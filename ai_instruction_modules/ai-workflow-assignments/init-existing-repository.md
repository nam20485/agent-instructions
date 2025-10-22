# Assignment: Initiate Existing Repository

## (init-existing-repository)

### Goal

Your goal is to initiate a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the initial administrative structure.

### Inputs

### Acceptance Criteria

0. PR and new branch created
1. Git Project created for issue tracking
2. Git Project linked to repository
3. Project columns created: Not Started, In Progress, In Review, Done
4. Milestones created based on application plan phases
5. Labels imported for issue management
6. Filenames changed to match project name

### Assignment
 
Your assignment is to set up an existing repository for a project. This involves configuring the necessary settings. You will create a new issue-tracking project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name.

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
  - Git and GitHub CLI
  - PowerShell (for scripts)
  - Development tools
- Verify previous assignments completed
  - Check acceptance criteria were met
  - Verify outputs are available
  - Confirm no blockers exist
- Ensure dependencies are met
  - GitHub access configured
  - Repository permissions granted
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
  - GitHub API access
  - Script execution permissions
  - File renaming conflicts
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
  - Baseline: 10-15 minutes
  - Consider assignment complexity
- Consider your specific context
  - Your familiarity with GitHub
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
  - GitHub documentation links
  - Repository access credentials
  - Script documentation
- Create backup if needed
  - Commit current state
  - Tag important points
  - Document starting point

**Only proceed once all preparation steps are complete.**

### Detailed Steps

1. **Create PR and New Branch**
   - Create a new branch named after the invoking dynamic workflow assignment which called this workflow assignment, with the prefix `dynamic-workflow-`.
   - For example, if the dynamic workflow assignment is `project-setup`, the branch should be named `dynamic-workflow-project-setup`.
   - Create a pull request (PR) for the new branch to merge into `main`
   - Changes will most likely not be made until subsequent workflow assignmments invoked after this one, so it will be left open until all subsequent assignments are complete and approved.
   - Later workflow assignments will commit and push changes to this branch.

2. **Create GitHub Project for Issue Tracking**
   - Create a new GitHub Project for issue tracking
   - Name the project the same as the repository
   - Set the project to `Board` template
   - Link project to the repository
   - Create the following columns in the project:
     - Not Started
     - In Progress
     - In Review
     - Done

3. **Import Labels**
   - Import the labels from the `.labels.json` file in the root of the repository
   - Use the `import-labels.ps1` script to import the labels

4.  **Rename Workspace and Devcontainer Files**
   - Inside the `.devcontainer/devcontainer.json` file rename the `name` property to use the repository name as the prefix, preserving the "devcontainer" suffix. Template: `<repo-name>-devcontainer`
   - Rename the `ai-new-app-template.code-workspace` file to use the repository name as the prefix, preserving the ".code-workspace" extension. Template: `<repo-name>.code-workspace`

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: GitHub CLI Not Authenticated
- **Symptoms**: "authentication required" errors, "gh auth login" prompts
- **Possible Causes**: 
  - GitHub CLI not logged in
  - Expired authentication token
  - Missing required scopes/permissions
- **Solutions**:
  1. Run `gh auth login` and follow prompts
  2. Verify authentication with `gh auth status`
  3. Ensure required scopes are granted (repo, project, admin:org)
  4. Re-authenticate if token expired

#### Error: Branch Already Exists
- **Symptoms**: "branch already exists" error when creating branch
- **Possible Causes**:
  - Branch from previous run not cleaned up
  - Name collision with existing branch
- **Solutions**:
  1. Check existing branches with `git branch -a`
  2. Delete old branch if safe: `git branch -D dynamic-workflow-<name>`
  3. Use alternative branch name if needed
  4. Verify remote branch status with `gh pr list`

#### Error: GitHub Project Creation Fails
- **Symptoms**: API errors, permission denied, project not created
- **Possible Causes**:
  - Insufficient GitHub permissions
  - Organization vs personal repo confusion
  - API rate limiting
  - Network connectivity issues
- **Solutions**:
  1. Verify you have admin/write access to repository
  2. Check if repository is in organization (may need org permissions)
  3. Use GitHub web UI to create project manually if CLI fails
  4. Wait and retry if rate limited
  5. Check GitHub status page for service issues

#### Error: Script Execution Fails (PowerShell)
- **Symptoms**: "script cannot be loaded", execution policy errors
- **Possible Causes**:
  - PowerShell execution policy restriction
  - Script path incorrect
  - Missing dependencies in script
  - Cross-platform path issues
- **Solutions**:
  1. Check execution policy: `Get-ExecutionPolicy`
  2. Set policy if needed: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
  3. Run script with bypass: `powershell -ExecutionPolicy Bypass -File script.ps1`
  4. Verify script path is correct
  5. On Linux/Mac, use `pwsh` instead of `powershell`

#### Error: Label Import Fails
- **Symptoms**: Labels not created, duplicate label errors
- **Possible Causes**:
  - `.labels.json` file not found or malformed
  - Labels already exist in repository
  - GitHub API errors
- **Solutions**:
  1. Verify `.labels.json` exists in repository root
  2. Validate JSON syntax
  3. Check for existing labels that might conflict
  4. Use `--force` flag if script supports it to overwrite
  5. Manually create labels via GitHub UI if script fails

#### Error: File Rename Fails
- **Symptoms**: File not found, permission denied, file in use
- **Possible Causes**:
  - File open in editor or IDE
  - Incorrect file path
  - Permission issues
  - File doesn't exist (already renamed)
- **Solutions**:
  1. Close all editors and IDEs
  2. Verify file exists before renaming
  3. Check file permissions
  4. Use git to track rename: `git mv old-name new-name`
  5. Manually rename via file explorer if command fails

#### Error: JSON File Update Fails (devcontainer.json)
- **Symptoms**: Syntax errors after edit, file corrupted, build fails
- **Possible Causes**:
  - Invalid JSON syntax introduced
  - Incorrect property path
  - Missing commas or brackets
- **Solutions**:
  1. Validate JSON with online validator or `jq`
  2. Use proper JSON editing tools
  3. Revert changes and try again
  4. Compare with backup/previous version
  5. Manually edit with care for JSON syntax

### Escalation Procedure

If errors persist after troubleshooting:

1. **Document the Error**:
   - Full error message and output
   - GitHub CLI version: `gh --version`
   - Git version: `git --version`
   - PowerShell version: `$PSVersionTable` (if applicable)
   - Repository details (name, owner, visibility)
   - What solutions were attempted

2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug", "setup", "needs-investigation"
   - Link to this assignment
   - Include reproduction steps

3. **Notify User**:
   - Report the error to the user
   - Provide error details and context
   - Request manual intervention
   - Suggest manual setup via GitHub UI as fallback

4. **Do Not Proceed**:
   - Do not mark assignment as complete
   - Do not proceed to next assignment
   - Wait for error resolution
   - Document the blocker

### Rollback Procedure

If changes need to be reverted:

1. **Assess Impact**:
   - Check what was created (branch, project, labels)
   - Identify what needs to be removed
   - Verify no work has been done on the branch

2. **Perform Rollback**:
   - Delete branch: `git branch -D dynamic-workflow-<name>`
   - Delete remote branch: `git push origin --delete dynamic-workflow-<name>`
   - Close/delete PR if created: `gh pr close <number>`
   - Delete GitHub project via UI (no CLI command)
   - Remove imported labels if needed (via GitHub UI)
   - Revert file renames: `git checkout -- <files>`

3. **Verify Rollback**:
   - Confirm branch deleted: `git branch -a`
   - Confirm PR closed: `gh pr list`
   - Check GitHub UI for project/labels removal
   - Verify files restored to original names

4. **Document Rollback**:
   - Document what was rolled back and why
   - Record lessons learned
   - Update issue with rollback details
   - Plan corrective action before retry

### Prevention Tips

To avoid common errors:

1. **Before Starting**:
   - Verify GitHub CLI is authenticated: `gh auth status`
   - Check Git is configured: `git config user.name` and `git config user.email`
   - Ensure you have write/admin access to repository
   - Verify PowerShell/pwsh is available if running scripts
   - Check all required files exist (`.labels.json`, workspace files)

2. **During Execution**:
   - Test GitHub CLI commands with `--help` first
   - Verify each step completes successfully before proceeding
   - Check GitHub UI to confirm resources were created
   - Keep terminal output for debugging
   - Use `--dry-run` flags where available

3. **After Completion**:
   - Verify branch exists: `git branch -a`
   - Confirm PR created: `gh pr view`
   - Check project created in GitHub UI
   - Verify labels imported via GitHub UI
   - Confirm files renamed correctly
   - Review devcontainer.json syntax

### Completion

After all steps have been completed, notify the orchestrator that this assignment has been completed and obtain approval to move to the next step. The repository has been initiated and is ready for the next step.
