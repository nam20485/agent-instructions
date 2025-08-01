#!/usr/bin/env pwsh

<#
.SYNOPSIS
    AI Agent Instructions Development Environment Setup for GitHub Actions
    
.DESCRIPTION
    This PowerShell script sets up all the development tools for the AI Agent Instructions
    environment on Ubuntu 22.04 in GitHub Actions. It replicates the functionality from
    the Dockerfile for GitHub Copilot agent dev environment setup.
    
.NOTES
    Author: GitHub Copilot AI Agent
    Requires: Ubuntu 22.04, PowerShell Core, sudo privileges
    Usage: pwsh -File copilot-setup-steps-linux.ps1
#>

[CmdletBinding()]
param()

# =============================================================================
# ERROR HANDLING & CONFIGURATION
# =============================================================================

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "=== AI Agent Instructions Development Environment Setup ===" -ForegroundColor Cyan
Write-Host "Setting up GitHub Copilot agent dev environment on Ubuntu 22.04..." -ForegroundColor Green

# Configure environment variables for optimal .NET development
$env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1"
$env:DOTNET_NOLOGO = "1"
$env:ASPNETCORE_ENVIRONMENT = "Development"

Write-Host "✅ Environment variables configured" -ForegroundColor Green

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

function Test-CommandExists {
    param([string]$Command)
    return $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Invoke-BashCommand {
    param([string]$Command)
    Write-Host "Executing: $Command" -ForegroundColor Yellow
    bash -c $Command
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed: $Command"
    }
}

# =============================================================================
# SYSTEM PACKAGES & DEPENDENCIES
# =============================================================================

Write-Host "Installing system packages and dependencies..." -ForegroundColor Cyan

$systemPackages = @(
    "build-essential"
    "apt-transport-https"
    "ca-certificates"
    "gnupg"
    "curl"
    "wget"
    "unzip"
    "git"
    "vim"
    "nano"
    "jq"
    "tree"
    "htop"
    "python3"
    "python3-pip"
    "python3-venv"
)

Invoke-BashCommand "sudo apt-get update"
Invoke-BashCommand "sudo apt-get install -y $($systemPackages -join ' ')"

Write-Host "✅ System packages installed" -ForegroundColor Green

# =============================================================================
# PYTHON DEVELOPMENT
# =============================================================================

Write-Host "Setting up Python development environment..." -ForegroundColor Cyan

# Set up Python 3 as default python and install latest pip
if (-not (Test-CommandExists "python")) {
    Invoke-BashCommand "sudo ln -sf /usr/bin/python3 /usr/bin/python"
}

Invoke-BashCommand "python -m pip install --upgrade pip --break-system-packages"

Write-Host "✅ Python development environment configured" -ForegroundColor Green

# =============================================================================
# NODE.JS & JAVASCRIPT DEVELOPMENT
# =============================================================================

Write-Host "Installing Node.js 22.x..." -ForegroundColor Cyan

# Install Node.js 22.x from NodeSource
Invoke-BashCommand "curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -"
Invoke-BashCommand "sudo apt-get install -y nodejs"
Invoke-BashCommand "sudo npm install -g npm@latest"

Write-Host "✅ Node.js and npm installed" -ForegroundColor Green

# =============================================================================
# POWERSHELL CORE INSTALLATION
# =============================================================================

Write-Host "Installing PowerShell Core..." -ForegroundColor Cyan

if (-not (Test-CommandExists "pwsh")) {
    # Install PowerShell Core from Microsoft repository (Ubuntu 22.04)
    Invoke-BashCommand "wget -q 'https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb'"
    Invoke-BashCommand "sudo dpkg -i packages-microsoft-prod.deb"
    Invoke-BashCommand "sudo apt-get update"
    Invoke-BashCommand "sudo apt-get install -y powershell"
    Invoke-BashCommand "rm packages-microsoft-prod.deb"
    Write-Host "✅ PowerShell Core installed" -ForegroundColor Green
} else {
    Write-Host "✅ PowerShell Core already available" -ForegroundColor Green
}

# =============================================================================
# CLOUD DEVELOPMENT TOOLS
# =============================================================================

Write-Host "Installing cloud development tools..." -ForegroundColor Cyan

# Install Google Cloud CLI
if (-not (Test-CommandExists "gcloud")) {
    Invoke-BashCommand "echo 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main' | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list"
    Invoke-BashCommand "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg"
    Invoke-BashCommand "sudo apt-get update"
    Invoke-BashCommand "sudo apt-get install -y google-cloud-cli"
    Write-Host "✅ Google Cloud CLI installed" -ForegroundColor Green
} else {
    Write-Host "✅ Google Cloud CLI already available" -ForegroundColor Green
}

# Install GitHub CLI
if (-not (Test-CommandExists "gh")) {
    Invoke-BashCommand "curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    Invoke-BashCommand "sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg"
    Invoke-BashCommand "echo 'deb [arch=`$(dpkg --print-architecture)` signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    Invoke-BashCommand "sudo apt-get update"
    Invoke-BashCommand "sudo apt-get install -y gh"
    Write-Host "✅ GitHub CLI installed" -ForegroundColor Green
} else {
    Write-Host "✅ GitHub CLI already available" -ForegroundColor Green
}

# =============================================================================
# INFRASTRUCTURE TOOLS
# =============================================================================

Write-Host "Installing infrastructure tools..." -ForegroundColor Cyan

# Install Terraform
if (-not (Test-CommandExists "terraform")) {
    Invoke-BashCommand "wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg"
    Invoke-BashCommand "echo 'deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com `$(lsb_release -cs)` main' | sudo tee /etc/apt/sources.list.d/hashicorp.list"
    Invoke-BashCommand "sudo apt-get update"
    Invoke-BashCommand "sudo apt-get install -y terraform"
    Write-Host "✅ Terraform installed" -ForegroundColor Green
} else {
    Write-Host "✅ Terraform already available" -ForegroundColor Green
}

# =============================================================================
# NODE.JS DEVELOPMENT TOOLS (NVM & LTS)
# =============================================================================

Write-Host "Setting up Node.js development with NVM..." -ForegroundColor Cyan

$env:NVM_DIR = "$env:HOME/.nvm"

# Install NVM
if (-not (Test-Path "$env:NVM_DIR/nvm.sh")) {
    Invoke-BashCommand "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
    Write-Host "✅ NVM installed" -ForegroundColor Green
} else {
    Write-Host "✅ NVM already available" -ForegroundColor Green
}

# Source NVM and install Node.js LTS
Invoke-BashCommand "source `$HOME/.nvm/nvm.sh && nvm install --lts && nvm use --lts"

Write-Host "✅ Node.js LTS installed via NVM" -ForegroundColor Green

# =============================================================================
# .NET WORKLOADS & TOOLS
# =============================================================================

Write-Host "Installing .NET workloads and tools..." -ForegroundColor Cyan

# Install .NET WebAssembly workloads for Blazor development
if (Test-CommandExists "dotnet") {
    Invoke-BashCommand "dotnet workload update"
    Invoke-BashCommand "dotnet workload install wasm-tools"
    Invoke-BashCommand "dotnet new install Aspire.ProjectTemplates"
    Write-Host "✅ .NET workloads and templates installed" -ForegroundColor Green
} else {
    Write-Host "⚠️  .NET SDK not found - skipping workload installation" -ForegroundColor Yellow
}

# =============================================================================
# GLOBAL NPM PACKAGES
# =============================================================================

Write-Host "Installing global npm packages..." -ForegroundColor Cyan

$globalNpmPackages = @(
    "firebase-tools"
    "@angular/cli"
    "create-react-app"
    "typescript"
    "eslint"
    "prettier"
)

foreach ($package in $globalNpmPackages) {
    try {
        Invoke-BashCommand "npm install -g $package"
        Write-Host "✅ Installed $package" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️  Failed to install $package" -ForegroundColor Yellow
    }
}

# =============================================================================
# DEVELOPMENT ENVIRONMENT SETUP
# =============================================================================

Write-Host "Setting up development environment..." -ForegroundColor Cyan

# Create development directories
$workspaceDir = "/workspace"
if (-not (Test-Path $workspaceDir)) {
    Invoke-BashCommand "sudo mkdir -p $workspaceDir"
    Invoke-BashCommand "sudo chown -R `$(whoami):`$(whoami) $workspaceDir"
    Write-Host "✅ Workspace directory created: $workspaceDir" -ForegroundColor Green
}

# =============================================================================
# VALIDATION & INFORMATION
# =============================================================================

Write-Host "Creating environment validation script..." -ForegroundColor Cyan

$showEnvScript = @"
#!/bin/bash
echo "=== AI Agent Instructions Development Environment ==="
echo "Core Development Stack:"
echo "- .NET SDK: `$(dotnet --version 2>/dev/null || echo 'Not installed')"
echo "- Node.js: `$(node --version 2>/dev/null || echo 'Not installed')"
echo "- npm: `$(npm --version 2>/dev/null || echo 'Not installed')"
echo "- Python: `$(python --version 2>/dev/null || echo 'Not installed')"
echo "- PowerShell: `$(pwsh --version 2>/dev/null || echo 'Not installed')"
echo ""
echo "Cloud & DevOps Tools:"
echo "- Google Cloud CLI: `$(gcloud version --format="value(Google Cloud SDK)" 2>/dev/null || echo "Not authenticated")"
echo "- Firebase CLI: `$(firebase --version 2>/dev/null || echo 'Not installed')"
echo "- GitHub CLI: `$(gh --version 2>/dev/null | head -1 || echo 'Not installed')"
echo "- Terraform: `$(terraform --version 2>/dev/null | head -1 || echo 'Not installed')"
echo ""
echo "AI Development Tools:"
echo "- Gemini CLI: `$(gemini --version 2>/dev/null || echo "Available via npm")"
echo ""
echo "Ready for ASP.NET Core + Blazor + AI + Google Cloud development!"
"@

$showEnvScriptPath = "$env:HOME/show-env.sh"
$showEnvScript | Out-File -FilePath $showEnvScriptPath -Encoding UTF8
Invoke-BashCommand "chmod +x $showEnvScriptPath"

Write-Host "✅ Environment validation script created: $showEnvScriptPath" -ForegroundColor Green

# =============================================================================
# FINAL VALIDATION
# =============================================================================

Write-Host "`n=== Environment Setup Complete ===" -ForegroundColor Cyan
Write-Host "Running environment validation..." -ForegroundColor Green

# Run the validation script
Invoke-BashCommand "bash $showEnvScriptPath"

Write-Host "`n🎉 GitHub Copilot agent development environment setup completed successfully!" -ForegroundColor Green
Write-Host "Environment is ready for ASP.NET Core + Blazor + AI + Google Cloud development." -ForegroundColor Cyan
