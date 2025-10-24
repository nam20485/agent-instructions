# Assignment: Initiate Existing Repository

## (init-existing-repository)

### Goal

Your goal is to initiate a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the initial administrative structure.

### Prerequisites

- GitHub authentication with appropriate scopes: `repo`, `project`, `read:project`, `read:user`, `user:email`
- Access to create GitHub Projects and link them to repositories (requires `project` and `read:project` scopes)
- Permissions to create repositories, manage labels, create milestones, and create branches/PRs
- GitHub CLI (gh) installed and authenticated

### Verification Steps

Before starting this assignment, verify that your environment has the necessary permissions by running the automated test script:

```powershell
# Run the permissions verification script
./scripts/test-github-permissions.ps1 -Owner <your-github-username>

# Or run with auto-fix to attempt to resolve authentication issues automatically
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth

# Or run with PAT authentication (non-interactive) - set GITHUB_AUTH_TOKEN environment variable first
$env:GITHUB_AUTH_TOKEN = "<your-pat-token>"
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth
```

The script will test all required permissions and can automatically attempt to fix authentication issues when the `-AutoFixAuth` parameter is used. This includes:
- Checking if GitHub CLI is installed and authenticated
- Using the `scripts/gh-auth.ps1` helper script for authentication (supports both interactive OAuth and non-interactive PAT via `$env:GITHUB_TOKEN`)
- Verifying required authentication scopes (`repo`, `project`, `read:project`, `read:user`, `user:email`)
- Attempting to refresh authentication with missing scopes using `gh auth refresh` if needed
- Testing repository creation/deletion
- Testing project creation
- Testing label management
- Testing milestone creation
- Testing branch/PR creation workflow


### Inputs

### Acceptance Criteria

0. PR and new branch created
1. Git Project created for issue tracking
2. Git Project linked to repository
3. Project columns created: Not Started, In Progress, In Review, Done
4. Labels imported for issue management
5. Filenames changed to match project name

### Assignment
 
Your assignment is to set up an existing repository for a project. This involves configuring the necessary settings. You will create a new issue-tracking project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

1. **Create PR and New Branch**
   - Create a new branch named after the invoking dynamic workflow assignment which called this workflow assignment, with the prefix `dynamic-workflow-`.
   - For example, if the dynamic workflow assignment is `project-setup`, the branch should be named `dynamic-workflow-project-setup`.
   
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

5. **Final Steps**
   - Create a pull request (PR) for the new branch to merge into `main`

## Completion

After all steps have been completed, notify the orchestrator that this assignment has been completed and obtain approval to move to the next step. The repository has been initiated and is ready for the next step.
