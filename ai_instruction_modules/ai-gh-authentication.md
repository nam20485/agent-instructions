# GitHub Authentication for Unattended Agents

This document provides comprehensive instructions for authenticating GitHub CLI in unattended environments, particularly for AI agents executing workflow assignments. It covers both interactive and non-interactive authentication methods with Personal Access Tokens (PAT).

## GitHub CLI Authentication Commands

For detailed information about GitHub CLI authentication commands, see the official documentation:
- [gh auth](https://cli.github.com/manual/gh_auth)
- [gh auth login](https://cli.github.com/manual/gh_auth_login)
- [gh auth refresh](https://cli.github.com/manual/gh_auth_refresh)

## Overview

Unattended agents need reliable authentication to GitHub to perform operations like:
- Creating and managing repositories
- Managing issues, pull requests, and projects
- Creating branches and pushing code
- Managing labels, milestones, and other GitHub resources

The authentication system supports both interactive OAuth flow (for initial setup) and non-interactive PAT-based authentication (for unattended operations).

## Required Tools

- GitHub CLI (`gh`) must be installed and available in PATH
- PowerShell (for Windows environments) or appropriate shell for other platforms

## Authentication Methods

### 1. Personal Access Token (PAT) Authentication (Recommended for Unattended Agents)

The preferred method for unattended agents is using a Personal Access Token (PAT) stored in the `GITHUB_AUTH_TOKEN` environment variable.

#### Setting up PAT Authentication

1. Create a Personal Access Token with the required scopes:
   - `repo` - for repository operations
   - `project` and `read:project` - for project management
   - `read:user` and `user:email` - for user profile access

2. Set the environment variable:
   ```powershell
   $env:GITHUB_AUTH_TOKEN = "<your-pat-token-here>"
   ```

3. The authentication scripts will automatically detect and use this token for non-interactive authentication.

### 2. Interactive Authentication

For initial setup or when a PAT is not available:
```powershell
gh auth login
```

## Using the Authentication Scripts

### Authentication Helper Script

The `scripts/gh-auth.ps1` script provides the `Initialize-GitHubAuth` function:

```powershell
# Dot source the script to import the function
. "$PSScriptRoot/gh-auth.ps1"

# Initialize authentication (will use PAT if available, otherwise interactive)
Initialize-GitHubAuth

# Or initialize with a specific token
Initialize-GitHubAuth -Token $env:GITHUB_AUTH_TOKEN

# Or dry run to see what would happen
Initialize-GitHubAuth -DryRun -Token $env:GITHUB_AUTH_TOKEN
```

### Permissions Verification Script

The `scripts/test-github-permissions.ps1` script verifies all required permissions:

```powershell
# Basic test with your GitHub username
./scripts/test-github-permissions.ps1 -Owner <your-github-username>

# With auto-fix to attempt to resolve authentication issues
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth

# Non-interactive test using PAT
$env:GITHUB_AUTH_TOKEN = "<your-pat-token>"
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth
```

## Required Scopes and Permissions

For full functionality with workflow assignments, the PAT must include:

- `repo` - Full control of private and public repositories
- `project` - All project permissions
- `read:project` - Read project information
- `read:user` - Read user profile data
- `user:email` - Access to email addresses

## Integration with Workflow Assignments

### Pre-Script Authentication Check

When executing dynamic workflows, include an authentication check in the `pre-script-begin` event:

```markdown
### Events

#### `pre-script-begin`
- validate environment prerequisites
- ensure GitHub authentication is configured using Initialize-GitHubAuth
- test required permissions using test-github-permissions.ps1
- record validation results as `#events.pre-script-begin`
```

### Environment Setup for Unattended Agents

1. Set the required environment variables:
   ```powershell
   $env:GITHUB_AUTH_TOKEN = "<your-pat-token>"
   $env:GITHUB_USERNAME = "<your-github-username>"
   ```

2. Verify authentication before starting workflow assignments:
   ```powershell
   . "$PSScriptRoot/gh-auth.ps1"
   Initialize-GitHubAuth -Token $env:GITHUB_AUTH_TOKEN
   ```

3. Run permission verification:
   ```powershell
   ./scripts/test-github-permissions.ps1 -Owner $env:GITHUB_USERNAME -AutoFixAuth
   ```

## Troubleshooting

### Common Issues

1. **"Required tool not found on PATH: gh"**
   - Install GitHub CLI from https://cli.github.com/
   - Ensure it's added to your system PATH

2. **"Authentication check failed"**
   - Verify your PAT token is valid
   - Check that all required scopes are included
   - Ensure the `GITHUB_AUTH_TOKEN` environment variable is set correctly

3. **"Missing scope for..."**
   - Use `gh auth refresh -s <missing-scope>` to add missing scopes
   - Or recreate your PAT with all required scopes

### Verification Commands

- Check authentication status: `gh auth status`
- Test API access: `gh api user`
- List repositories: `gh repo list`

## Security Best Practices

1. Store PATs securely in environment variables, never in code
2. Use the principle of least privilege - only grant required scopes
3. Rotate tokens regularly
4. Use different tokens for different environments when possible
5. Never log or output token values

## Workflow Assignment Integration

For unattended agents executing workflow assignments, authentication should be established before any assignment execution. The `gather-context` assignment includes a step for authentication checks:

- Verify access to required services
- Confirm credentials are valid and working
- Test connectivity to external dependencies
- Authenticate using the instructions in this document

The authentication setup ensures that all subsequent workflow assignments can execute without requiring interactive authentication prompts.