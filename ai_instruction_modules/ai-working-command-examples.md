---
description: Validated PowerShell/GitHub CLI command examples
scope: working-commands
context: opt-in
---
# Working Command Examples

Shell: pwsh (Windows). Prereq: `gh` authenticated.

## Auth

```pwsh
gh auth status
gh auth refresh -s project,read:project -h github.com  # For Projects API
```

## Repo Operations

```pwsh
gh repo create owner/repo --template owner/template --public
gh repo view owner/repo --json name,sshUrl,defaultBranchRef
gh api repos/owner/repo/contents --jq '.[].name'
```

## Git Flow

```pwsh
gh repo clone owner/repo -- -q
git switch -c feature/branch-name
git add . && git commit -m "type: message"
git push --set-upstream origin feature/branch-name
```

## PRs

```pwsh
gh pr create --base development --title "title" --body "body"
gh pr merge 1 --squash --auto
gh pr view 1 --json state,mergeable,mergeStateStatus
```

## Labels & Milestones

```pwsh
./scripts/import-labels.ps1 -Repo 'owner/repo' -LabelsFile '.github/.labels.json'
./scripts/create-milestones.ps1 -Repo 'owner/repo' -Titles 'Phase 1','Phase 2' -SkipExisting
```

## Projects

```pwsh
gh project create --owner nam20485 --title project-name --template 'Basic Kanban'
gh project list --owner nam20485 --format json
```

## License

```pwsh
$body = gh api licenses/agpl-3.0 --jq .body
Set-Content -Path LICENSE -Value $body -NoNewline
```

## File Edits

```pwsh
(Get-Content file.json -Raw) -replace 'old', 'new' | Set-Content file.json
```

## Base64 Decode (GitHub API)

```pwsh
gh api repos/owner/repo/contents/file --jq '.content' > tmp.txt
python -c "import base64; print(base64.b64decode(open('tmp.txt').read().replace('\n','')).decode())"
```
