# Assignment: Initiate Existing Repository

## (init-existing-repository)

### Goal

Your goal is to initiate a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the initial administrative structure.

### Prerequisites

- GitHub authentication with appropriate scopes: `repo`, `project`, `read:project`, `read:user`, `user:email`
- Access to create GitHub Projects and link them to repositories (requires `project` and `read:project` scopes)
- Permissions to create repositories, manage labels, create milestones, and create branches/PRs
- `administration: write` scope on the target repository (required to create branch protection rulesets via the GitHub API)
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
- Using the `scripts/gh-auth.ps1` helper script for authentication (supports both interactive OAuth and non-interactive PAT via `$env:GITHUB_AUTH_TOKEN`)
- Verifying required authentication scopes (`repo`, `project`, `read:project`, `read:user`, `user:email`)
- Attempting to refresh authentication with missing scopes using `gh auth refresh` if needed
- Testing repository creation/deletion
- Testing project creation
- Testing label management
- Testing milestone creation
- Testing branch/PR creation workflow

### Inputs

### Acceptance Criteria

0. New branch created (must be first — all other work commits here)
1. Branch protection ruleset imported from `.github/protected branches - main - ruleset.json`
2. GitHub Project created for issue tracking
3. Git Project linked to repository
4. Project columns created: Not Started, In Progress, In Review, Done
5. Labels imported from `.github/.labels.json` for issue management
6. Filenames changed to match project name
7. PR created from the branch to `main` (after at least one commit is pushed)

### Assignment

Your assignment is to set up an existing repository for a project. This involves configuring the necessary settings. You will create a new issue-tracking project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

1. **Create New Branch**
   - **This must be done first** — all subsequent steps commit to this branch.
   - Create a new branch named after the invoking dynamic workflow assignment which called this workflow assignment, with the prefix `dynamic-workflow-`.
   - For example, if the dynamic workflow assignment is `project-setup`, the branch should be named `dynamic-workflow-project-setup`.
   - **Do NOT create a PR yet.** A PR requires at least one commit ahead of `main`. The PR will be created in step 5 after the first commits are pushed.
   - If branch creation fails, stop and report the error immediately — do not proceed with other steps.

2. **Import Branch Protection Ruleset**
   - Import the branch protection ruleset from `.github/protected branches - main - ruleset.json`.
   - This file is bundled in the template and defines the `main` branch ruleset (required PR, linear history, no force-push, Copilot code review, etc.).
   - Before importing, check whether a ruleset with the same `name` already exists to make this step idempotent:

     ```bash
     RULESET_NAME=$(gh api /repos/{owner}/{repo}/rulesets --jq '.[] | select(.name == "protected branches") | .id')
     ```

   - If it already exists, skip and proceed.
   - If it does not exist, strip the non-importable fields and POST via the GitHub API:

     ```bash
     jq 'del(.id, .source, .source_type)' ".github/protected branches - main - ruleset.json" \
       | gh api --method POST /repos/{owner}/{repo}/rulesets --input -
     ```

   - Use `GH_ORCHESTRATION_AGENT_TOKEN` (not `GITHUB_TOKEN`) — the PAT must have `administration: write` scope.
   - If the import fails with a permissions error, report the exact error and stop — do not silently skip.

3. **Create GitHub Project for Issue Tracking**
   - Create a new GitHub Project for issue tracking
   - Name the project the same as the repository
   - Set the project to `Board` template
   - Link project to the repository
   - Create the following columns in the project:
     - Not Started
     - In Progress
     - In Review
     - Done

4. **Import Labels**
   - Import the labels from the `.github/.labels.json` file (note: inside the `.github/` directory, not the repo root)
   - This file is the single source of truth for the repository label set
   - Use the `scripts/import-labels.ps1` script to import the labels

5. **Rename Workspace and Devcontainer Files**
   - Inside the `.devcontainer/devcontainer.json` file rename the `name` property to use the repository name as the prefix, preserving the "devcontainer" suffix. Template: `<repo-name>-devcontainer`
   - Rename the `ai-new-app-template.code-workspace` file to use the repository name as the prefix, preserving the ".code-workspace" extension. Template: `<repo-name>.code-workspace`

6. **Create PR**
   - Now that commits have been pushed to the branch (from steps 4 and 5), create a PR from this branch to `main`.
   - The PR will be left open until all subsequent assignments are complete and approved.
   - If `gh pr create` fails, capture and display the exact error message. Common causes:
     - "No commits between main and \<branch\>" → verify that at least one commit was pushed in the preceding steps.
   - If PR creation fails, stop and report the error immediately — do not proceed.

7. **Final Steps**
   - Nothing to do here, just proceed to the completion section below.

## Completion

After all steps have been completed, notify the orchestrator that this assignment has been completed and obtain approval to move to the next step. The repository has been initiated and is ready for the next step.
