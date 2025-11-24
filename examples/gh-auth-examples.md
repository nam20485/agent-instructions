<examples>
  <example id="gh-auth-pat">
    <description>Setting up PAT authentication in PowerShell.</description>
    <content>
```powershell
# Set the environment variable
$env:GITHUB_AUTH_TOKEN = "<your-pat-token-here>"

# Dot source the script to import the function
. "$PSScriptRoot/gh-auth.ps1"

# Initialize authentication (will use PAT if available, otherwise interactive)
Initialize-GitHubAuth

# Or initialize with a specific token
Initialize-GitHubAuth -Token $env:GITHUB_AUTH_TOKEN
```
    </content>
  </example>

  <example id="gh-permissions-check">
    <description>Verifying GitHub permissions.</description>
    <content>
```powershell
# Basic test with your GitHub username
./scripts/test-github-permissions.ps1 -Owner <your-github-username>

# With auto-fix to attempt to resolve authentication issues
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth

# Non-interactive test using PAT
$env:GITHUB_AUTH_TOKEN = "<your-pat-token>"
./scripts/test-github-permissions.ps1 -Owner <your-github-username> -AutoFixAuth
```
    </content>
  </example>
</examples>
