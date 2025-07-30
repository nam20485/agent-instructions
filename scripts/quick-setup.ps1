#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Quick development environment setup and validation for AI agent instruction repositories
    
.DESCRIPTION
    This script provides a fast path to set up and validate the development environment
    for working with AI agent instruction repositories. It focuses on the essential tools
    and provides immediate feedback.
    
.PARAMETER ValidateOnly
    Only validate the environment, don't install anything
    
.PARAMETER Force
    Force reinstallation of tools
    
.EXAMPLE
    .\quick-setup.ps1
    
.EXAMPLE
    .\quick-setup.ps1 -ValidateOnly
#>

[CmdletBinding()]
param(
    [switch]$ValidateOnly,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host "🔄 $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

Write-Host "🚀 AI Agent Instructions - Quick Development Setup" -ForegroundColor Magenta
Write-Host "=================================================" -ForegroundColor Magenta

if ($ValidateOnly) {
    Write-Step "Validating development environment..."
    & "$PSScriptRoot\validate-local-environment.ps1"
    exit $LASTEXITCODE
}

Write-Step "Checking if full setup is needed..."

# Quick check for essential tools
$needsSetup = $false
$essentialTools = @("dotnet", "node", "gh", "docker")

foreach ($tool in $essentialTools) {
    try {
        Get-Command $tool -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Warning "$tool not found"
        $needsSetup = $true
    }
}

# Check .NET version specifically
try {
    $dotnetVersion = dotnet --version 2>$null
    if ($dotnetVersion -ne "9.0.102") {
        Write-Warning ".NET SDK version mismatch (found: $dotnetVersion, expected: 9.0.102)"
        $needsSetup = $true
    }
}
catch {
    $needsSetup = $true
}

if (-not $needsSetup -and -not $Force) {
    Write-Success "Essential tools appear to be installed"
    Write-Step "Running validation to confirm..."
    & "$PSScriptRoot\validate-local-environment.ps1"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n🎉 Development environment is ready!" -ForegroundColor Green
        Write-Host "You can now work with AI agent instruction repositories." -ForegroundColor Green
        exit 0
    }
    else {
        Write-Warning "Validation failed, running full setup..."
        $needsSetup = $true
    }
}

if ($needsSetup -or $Force) {
    Write-Step "Running full environment setup..."
    & "$PSScriptRoot\setup-local-environment.ps1" -SkipValidation
    
    if ($LASTEXITCODE -eq 0) {
        Write-Step "Setup completed, running final validation..."
        & "$PSScriptRoot\validate-local-environment.ps1"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "`n🎉 Development environment setup complete!" -ForegroundColor Green
            Write-Host "Ready for ASP.NET Core + Blazor + Google Cloud development!" -ForegroundColor Green
        }
        else {
            Write-Host "`n❌ Setup completed but validation failed" -ForegroundColor Red
            exit 1
        }
    }
    else {
        Write-Host "`n❌ Setup failed" -ForegroundColor Red
        exit 1
    }
}
