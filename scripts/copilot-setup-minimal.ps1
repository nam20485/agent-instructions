#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Minimal GitHub Copilot Agent Dev Environment Setup for GitHub Actions
    
.DESCRIPTION
    This is a streamlined version focused on GitHub Actions runners where some tools
    are already available. It adds the specific tools needed for AI agent development.
    
.NOTES
    Author: GitHub Copilot AI Agent
    Requires: Ubuntu 22.04 GitHub Actions runner
    Usage: pwsh -File copilot-setup-minimal.ps1
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "=== Minimal GitHub Copilot Agent Dev Environment Setup ===" -ForegroundColor Cyan

# Configure .NET environment
$env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1"
$env:DOTNET_NOLOGO = "1"
$env:ASPNETCORE_ENVIRONMENT = "Development"

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

# Install Firebase CLI (often not available in GitHub Actions)
if (-not (Test-CommandExists "firebase")) {
    Write-Host "Installing Firebase CLI..." -ForegroundColor Cyan
    Invoke-BashCommand "sudo npm install -g firebase-tools"
    Write-Host "✅ Firebase CLI installed" -ForegroundColor Green
}

# Install Google Cloud CLI if not available
if (-not (Test-CommandExists "gcloud")) {
    Write-Host "Installing Google Cloud CLI..." -ForegroundColor Cyan
    Invoke-BashCommand "echo 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main' | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list"
    Invoke-BashCommand "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg"
    Invoke-BashCommand "sudo apt-get update && sudo apt-get install -y google-cloud-cli"
    Write-Host "✅ Google Cloud CLI installed" -ForegroundColor Green
}

# Install Terraform if not available
if (-not (Test-CommandExists "terraform")) {
    Write-Host "Installing Terraform..." -ForegroundColor Cyan
    Invoke-BashCommand "wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg"
    Invoke-BashCommand "echo 'deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com `$(lsb_release -cs)` main' | sudo tee /etc/apt/sources.list.d/hashicorp.list"
    Invoke-BashCommand "sudo apt-get update && sudo apt-get install -y terraform"
    Write-Host "✅ Terraform installed" -ForegroundColor Green
}

# Install .NET workloads for Blazor
if (Test-CommandExists "dotnet") {
    Write-Host "Installing .NET workloads..." -ForegroundColor Cyan
    Invoke-BashCommand "dotnet workload update"
    Invoke-BashCommand "dotnet workload install wasm-tools"
    Invoke-BashCommand "dotnet new install Aspire.ProjectTemplates"
    Write-Host "✅ .NET workloads installed" -ForegroundColor Green
}

# Install additional global npm packages for development
Write-Host "Installing global npm packages..." -ForegroundColor Cyan
$npmPackages = @("typescript", "eslint", "prettier", "@angular/cli")
foreach ($package in $npmPackages) {
    try {
        Invoke-BashCommand "sudo npm install -g $package"
        Write-Host "✅ Installed $package" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️  Failed to install $package" -ForegroundColor Yellow
    }
}

Write-Host "🎉 Minimal setup complete!" -ForegroundColor Green
