---
description: Validated, copy-pasteable command examples for PowerShell, GitHub CLI, and Git.
scope: working-commands
prerequisites: none
---
# AI API and CLI Examples (Working Commands)

<xml>
<instructions role="assistant" scope="working-commands">

<overview>
## Overview
Use these exact, known‑working command forms to avoid repeated syntax and command errors across PowerShell, GitHub CLI, Git, and Python. They come from a successful end‑to‑end run of the “initiate-new-repo” workflow and have been validated on Windows with PowerShell.

**Context:**
- **Shell:** Windows, PowerShell (pwsh)
- **Prerequisites:** GitHub CLI authenticated and installed
- **Usage:** Copy‑pasteable building blocks; prefer them over ad‑hoc variations
</overview>

<github_cli>
## GitHub CLI: Authentication

**GitHub Authentication:**
* For GitHub authentication, reference the official documentation:
  * [ai-gh-authentication](./ai-gh-authentication.md)

```pwsh
# Verify GitHub CLI auth status
gh auth status
```

If you need additional scopes for GitHub Projects:

```pwsh
# Add required scopes for Projects APIs (device flow)
gh auth refresh -s project,read:project -h github.com
```
</github_cli>

<repo_management>
## Create a Repository from a Template

```pwsh
# Create a public repo from a template under an org/user
gh repo create nam20485/new_repo_test --template nam20485/ai-new-app-template --public
```

Verify repository basics:

```pwsh
# View key repo info (JSON filtering with --jq is supported)
gh repo view nam20485/new_repo_test --json name,sshUrl,defaultBranchRef,description,isPrivate
```

List contents (root and a subfolder):

```pwsh
# List root items
gh api repos/nam20485/new_repo_test/contents --jq '.[].name'

# List .github items
gh api repos/nam20485/new_repo_test/contents/.github --jq '.[].name'
```
</repo_management>

<git_workflow>
## Clone and Branching Workflow

```pwsh
# Clone (quiet)
gh repo clone nam20485/new_repo_test -- -q

# Enter repo
Set-Location -Path .\new_repo_test

# Show status and branch
git status -sb
git branch --show-current

# Create a working branch
git switch -c chore/initiate-repo-setup
```
</git_workflow>

<file_edits>
## PowerShell File Edits and Git Commits

Rename the Dev Container “name” property via PowerShell text replace:

```pwsh
# Update the name field in devcontainer.json
(Get-Content .devcontainer/devcontainer.json -Raw) `
  -replace '"name"\s*:\s*"[^"]+"', '"name": "new_repo_test-devcontainer"' `
  | Set-Content .devcontainer/devcontainer.json

# Commit the change
git add .devcontainer/devcontainer.json
git commit -m "chore: rename devcontainer to new_repo_test-devcontainer"
```

Push and open a PR:

```pwsh
# Push the branch
git push --set-upstream origin chore/initiate-repo-setup

# Create a PR into development branch
gh pr create --repo nam20485/new_repo_test `
  --base development `
  --head chore/initiate-repo-setup `
  --title "chore: initial repo setup (devcontainer name + workspace rename)" `
  --body  "- Renamed devcontainer name to new_repo_test-devcontainer`n- Confirmed workspace file named new_repo_test.code-workspace"

# Optionally enable auto-merge (squash)
gh pr merge 1 --repo nam20485/new_repo_test --squash --auto
```

Inspect PR status (avoid unsupported JSON fields):

```pwsh
# Check PR status with safe fields
gh pr view 1 --repo nam20485/new_repo_test `
  --json state,isDraft,mergeStateStatus,mergeable,headRefName,baseRefName,mergeCommit `
  --jq '{state: .state, mergeable: .mergeable, mergeStateStatus: .mergeStateStatus, head: .headRefName, base: .baseRefName}'
```
</file_edits>

<labels_milestones>
## Labels: Import from JSON via PowerShell Script

```pwsh
# Run the provided import script against labels stored in the repo
./scripts/import-labels.ps1 -Repo 'nam20485/new_repo_test' -LabelsFile '.github/.labels.json'

# Verify labels
gh api repos/nam20485/new_repo_test/labels --jq '.[].name' | sort
```

## Milestones: Create from a List

```pwsh
# Create standard phase milestones
./scripts/create-milestones.ps1 -Repo 'nam20485/new_repo_test' `
  -Titles 'Phase 1: Planning','Phase 2: Build','Phase 3: Test','Phase 4: Launch' `
  -SkipExisting

# Verify milestones
gh api repos/nam20485/new_repo_test/milestones --jq '.[].title'
```
</labels_milestones>

<projects>
## GitHub Projects (Beta): Create a Project

Requires extra scopes; refresh if prompted (see Authentication above).

```pwsh
# Create a Basic Kanban project under the owner
gh project create --owner nam20485 --title new_repo_test --template 'Basic Kanban' --format json

# List projects to confirm
gh project list --owner nam20485 --format json
```
</projects>

<license_management>
## Add or Replace LICENSE (AGPL-3.0)

Create a branch, add LICENSE, and open a PR:

```pwsh
# New branch for license work
git switch -c chore/add-license-agpl-3.0

# Create a simple placeholder LICENSE (use full text replacement below)
ni -ItemType File -Path LICENSE -Value "GNU AFFERO GENERAL PUBLIC LICENSE`nVersion 3, 19 November 2007`n`n<placeholder>`n" -Force

git add LICENSE

git commit -m "chore: add AGPL-3.0 license file"

git push --set-upstream origin chore/add-license-agpl-3.0

gh pr create --repo nam20485/new_repo_test `
  --base development `
  --head chore/add-license-agpl-3.0 `
  --title "chore: add AGPL-3.0 license file" `
  --body  "Template-based creation didn’t include license; adding AGPL-3.0 per instructions."

# Optionally auto-merge
gh pr merge 2 --repo nam20485/new_repo_test --squash --auto
```

Replace with the official full AGPL-3.0 text (clean, working form):

```pwsh
# Fetch full AGPL-3.0 license text via GitHub API and update the file
$body = gh api licenses/agpl-3.0 --jq .body
Set-Content -Path LICENSE -Value $body -NoNewline

git add LICENSE

git commit -m "chore: replace LICENSE with full AGPL-3.0 text"

git push
```
</license_management>

<docs_management>
## docs/ Folder: Add a Placeholder README

```pwsh
# Create a docs folder and placeholder README on a dedicated branch
git switch -c chore/add-docs-folder

ni -ItemType Directory -Path docs -Force | Out-Null
ni -ItemType File -Path docs/README.md -Value "# Docs`n`nThis folder will contain application plan documents." -Force

git add docs

git commit -m "chore(docs): add docs folder with placeholder README"

git push --set-upstream origin chore/add-docs-folder

gh pr create --repo nam20485/new_repo_test `
  --base development `
  --head chore/add-docs-folder `
  --title "chore(docs): add docs folder placeholder" `
  --body  "Add docs/ with README since no app plan docs were provided in context."
```

If the PR is conflicting, a clean, repeatable resolution:

```pwsh
# Recreate a clean branch from latest development and cherry-pick your change
# 1) Sync local with remote development
git fetch origin development

git reset --hard origin/development

# 2) Create a new branch and cherry-pick the docs commit (replace <commit> with yours)
git checkout -b chore/add-docs-folder-v2

git cherry-pick <commit> -X theirs

# 3) Push and create PR
git push --set-upstream origin chore/add-docs-folder-v2

gh pr create --repo nam20485/new_repo_test `
  --base development `
  --head chore/add-docs-folder-v2 `
  --title "chore(docs): add docs folder placeholder" `
  --body  "Add docs/ with README since no app plan docs were provided in context."

# Optionally auto-merge
gh pr merge 4 --repo nam20485/new_repo_test --squash --auto
```
</docs_management>

<utilities>
## Decoding base64 GitHub Contents Safely (Windows)

Some GitHub Contents API responses include base64-encoded file content. This two‑step approach works reliably in PowerShell on Windows:

```pwsh
# 1) Save base64 content to a temporary file
# Example: devcontainer.json content
gh api repos/nam20485/new_repo_test/contents/.devcontainer/devcontainer.json --jq '.content' > tmp_b64.txt

# 2) Decode and print with Python (avoid fragile inline PowerShell pipelines)
python -c "import base64,sys; b=open('tmp_b64.txt','rb').read().decode().replace('\\n',''); print(base64.b64decode(b).decode())"
```
</utilities>

<pr_queries>
## PR and Repo Queries

```pwsh
# Verify repo settings
gh repo view nam20485/new_repo_test --json name,defaultBranchRef,mergeCommitAllowed,squashMergeAllowed,deleteBranchOnMerge,hasIssuesEnabled

# Check PR diff to inspect conflicts
gh pr diff 3 --repo nam20485/new_repo_test > pr3.diff
Get-Content pr3.diff -TotalCount 120 | ForEach-Object { $_ }
```
</pr_queries>

<rationale>
## Why these forms?
- **Cross‑shell reliability:** Avoids UNIX‑only tools (e.g., sed); prefers PowerShell‑native.
- **Safe JSON filtering:** Leverages `gh`’s built‑in JSON output with `--json`/`--jq`.
- **Scope handling:** Includes exact auth refresh for Projects APIs.
- **Minimal quoting pitfalls:** Separate steps for output redirection/decoding.
- **Conflict‑safe Git flows:** Predictable rebase/cherry‑pick approach.
</rationale>

</instructions>
</xml>
