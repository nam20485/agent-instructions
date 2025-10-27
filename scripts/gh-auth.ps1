#!/usr/bin/env pwsh

# Common authentication helpers for GitHub CLI
# Dot-source this file from scripts that need to ensure authentication.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Initialize-GitHubAuth {
    [CmdletBinding()]
    param(
        [switch]$DryRun,
        [string]$Token = $env:GITHUB_AUTH_TOKEN
    )
    
    # Verify gh is available
    if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
        throw 'Required tool not found on PATH: gh'
    }
    
    # Check auth status
    & gh auth status 2>$null | Out-Null
    $authStatusExitCode = $LASTEXITCODE
    
    # Check if a PAT token is available either as parameter or environment variable
    if ($Token) {
        if ($DryRun) {
            Write-Host '[dry-run] Would authenticate using PAT token (non-interactive)' -ForegroundColor Yellow
        }
        else {
            Write-Host 'Authenticating using PAT token (non-interactive)' -ForegroundColor Green
            # Authenticate using the PAT token via stdin
            $result = $Token | & gh auth login --with-token --hostname github.com 2>&1
            if ($LASTEXITCODE -ne 0) {
                throw "Failed to authenticate using PAT token: $result"
            }
            Write-Host 'Successfully authenticated with PAT token' -ForegroundColor Green
        }
    }
    else {
        # If not authenticated and no token provided, initiate interactive login
        if ($authStatusExitCode -ne 0) {
            Write-Warning 'GitHub CLI not authenticated and no PAT token provided. Initiating gh auth login so the user can complete prompts...'
            if ($DryRun) {
                Write-Host '[dry-run] Would run: gh auth login' -ForegroundColor Yellow
            }
            else {
                & gh auth login | Out-Null
            }
        }
        else {
            Write-Host 'GitHub CLI is already authenticated' -ForegroundColor Green
        }
    }
}
