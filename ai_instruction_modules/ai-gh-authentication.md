---
description: GitHub CLI authentication for unattended agents
scope: authentication
---
# GitHub Authentication

## Methods

**1. PAT (Recommended)**
- Set `GITHUB_AUTH_TOKEN` env var
- Scopes: `repo`, `project`, `read:project`, `read:user`, `user:email`

**2. Interactive**
- `gh auth login` for initial setup

## Helper Scripts
- `scripts/gh-auth.ps1` - `Initialize-GitHubAuth`
- `scripts/test-github-permissions.ps1` - Verify permissions

## Workflow
1. Set `GITHUB_AUTH_TOKEN` and `GITHUB_USERNAME`
2. Call `Initialize-GitHubAuth`
3. Verify with `test-github-permissions.ps1`

## Troubleshooting
- **Auth failed:** Check PAT validity and scopes
- **Missing scope:** `gh auth refresh -s <scope>`
- **Verify:** `gh auth status`, `gh api user`
