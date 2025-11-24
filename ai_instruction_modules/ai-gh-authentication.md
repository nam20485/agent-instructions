---
description: Instructions for authenticating GitHub CLI in unattended environments (AI agents).
scope: authentication
prerequisites: none
---
# GitHub Authentication for Unattended Agents

<xml>
<instructions role="auth-manager" scope="authentication">

<overview>
## Overview
Reliable authentication for unattended agents to perform GitHub operations (repos, issues, PRs). Supports PAT (recommended) and interactive OAuth.
</overview>

<prerequisites>
## Prerequisites
-   **Tool:** GitHub CLI (`gh`) in PATH.
-   **Shell:** PowerShell (Windows) or Bash (Linux).
</prerequisites>

<methods>
## Authentication Methods

### 1. PAT (Recommended)
-   **Env Var:** `GITHUB_AUTH_TOKEN`
-   **Scopes:** `repo`, `project`, `read:project`, `read:user`, `user:email`.
-   **Usage:** Scripts auto-detect this variable.

### 2. Interactive
-   **Command:** `gh auth login`
-   **Use Case:** Initial setup or fallback.
</methods>

<scripts>
## Helper Scripts
-   `scripts/gh-auth.ps1`: `Initialize-GitHubAuth` function.
-   `scripts/test-github-permissions.ps1`: Verifies permissions and scopes.
</scripts>

<integration>
## Workflow Integration
1.  **Set Env:** `$env:GITHUB_AUTH_TOKEN` and `$env:GITHUB_USERNAME`.
2.  **Init:** Call `Initialize-GitHubAuth`.
3.  **Verify:** Run `test-github-permissions.ps1`.
</integration>

<troubleshooting>
## Troubleshooting
-   **Missing Tool:** Install `gh`.
-   **Auth Failed:** Check PAT validity and scopes.
-   **Missing Scope:** `gh auth refresh -s <scope>` or regenerate PAT.
-   **Verify:** `gh auth status`, `gh api user`.
</troubleshooting>

<security>
## Security
-   **Storage:** Env vars only (never in code).
-   **Scopes:** Least privilege.
-   **Rotation:** Rotate tokens regularly.
</security>

<examples>
## Examples
<see example="examples/gh-auth-examples.md" />
</examples>

</instructions>
</xml>
