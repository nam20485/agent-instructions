#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Validates local development environment for ASP.NET Core + Blazor + Google Cloud development
    
.DESCRIPTION
    This script validates all the tools needed for development as specified in the AI instruction modules.
    It mirrors the GitHub Actions workflow validation for consistency.
    
.PARAMETER Detailed
    Show detailed version information for all tools
    
.PARAMETER OutputFormat
    Output format: Text, Json, or Markdown (default: Text)
    
.EXAMPLE
    .\validate-local-environment.ps1
    
.EXAMPLE
    .\validate-local-environment.ps1 -Detailed -OutputFormat Markdown
#>

[CmdletBinding()]
param(
    [switch]$Detailed,
    [ValidateSet("Text", "Json", "Markdown")]
    [string]$OutputFormat = "Text"
)

# Set error handling
$ErrorActionPreference = "Continue"
Set-StrictMode -Version Latest

# Expected versions
$EXPECTED_DOTNET = "9.0.102"
$EXPECTED_NODE_MAJOR = "22"
$EXPECTED_PS_MAJOR = "7"

class ValidationResult {
    [string]$Tool
    [bool]$Available
    [string]$Version
    [string]$Status
    [string]$Message
    [string]$ExpectedVersion
}

$results = @()

function Test-Tool {
    param(
        [string]$ToolName,
        [string]$Command,
        [string]$VersionCommand = "--version",
        [string]$ExpectedVersion = "",
        [scriptblock]$VersionParser = { param($output) $output }
    )
    
    $result = [ValidationResult]::new()
    $result.Tool = $ToolName
    $result.ExpectedVersion = $ExpectedVersion
    
    try {
        $null = Get-Command $Command -ErrorAction Stop
        $result.Available = $true
        
        try {
            $versionOutput = & $Command $VersionCommand 2>$null
            if ($versionOutput) {
                $result.Version = & $VersionParser $versionOutput
                
                if ($ExpectedVersion -and $result.Version) {
                    if ($result.Version -match $ExpectedVersion) {
                        $result.Status = "PASS"
                        $result.Message = "✅ Available with expected version"
                    }
                    else {
                        $result.Status = "WARN"
                        $result.Message = "⚠️  Available but version mismatch"
                    }
                }
                else {
                    $result.Status = "PASS"
                    $result.Message = "✅ Available"
                }
            }
            else {
                $result.Status = "WARN"
                $result.Message = "⚠️  Available but version unknown"
            }
        }
        catch {
            $result.Status = "WARN"
            $result.Message = "⚠️  Available but version check failed"
            $result.Version = "Unknown"
        }
    }
    catch {
        $result.Available = $false
        $result.Status = "FAIL"
        $result.Message = "❌ Not found"
        $result.Version = "Not installed"
    }
    
    return $result
}

function Write-ResultText {
    param([ValidationResult]$Result)
    
    Write-Host "$($Result.Tool) ($($Result.Tool.ToLower()))" -ForegroundColor White
    Write-Host "  Status: $($Result.Message)" -ForegroundColor $(
        switch ($Result.Status) {
            "PASS" { "Green" }
            "WARN" { "Yellow" }
            "FAIL" { "Red" }
            default { "White" }
        }
    )
    
    if ($Result.Version -ne "Not installed") {
        Write-Host "  Version: $($Result.Version)" -ForegroundColor Gray
    }
    
    if ($Result.ExpectedVersion -and $Detailed) {
        Write-Host "  Expected: $($Result.ExpectedVersion)" -ForegroundColor Gray
    }
    
    Write-Host ""
}

function Write-ResultsMarkdown {
    param([ValidationResult[]]$Results)
    
    Write-Host "# Development Environment Validation Report"
    Write-Host ""
    Write-Host "| Tool | Status | Version | Expected |"
    Write-Host "|------|--------|---------|----------|"
    
    foreach ($result in $Results) {
        $status = switch ($result.Status) {
            "PASS" { "✅ PASS" }
            "WARN" { "⚠️ WARN" }
            "FAIL" { "❌ FAIL" }
            default { "❓ UNKNOWN" }
        }
        
        Write-Host "| $($result.Tool) | $status | $($result.Version) | $($result.ExpectedVersion) |"
    }
    
    Write-Host ""
    Write-Host "## Summary"
    $passed = ($Results | Where-Object { $_.Status -eq "PASS" }).Count
    $warned = ($Results | Where-Object { $_.Status -eq "WARN" }).Count
    $failed = ($Results | Where-Object { $_.Status -eq "FAIL" }).Count
    
    Write-Host "- ✅ Passed: $passed"
    Write-Host "- ⚠️  Warnings: $warned"
    Write-Host "- ❌ Failed: $failed"
}

function Write-ResultsJson {
    param([ValidationResult[]]$Results)
    
    $summary = @{
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
        total = $Results.Count
        passed = ($Results | Where-Object { $_.Status -eq "PASS" }).Count
        warned = ($Results | Where-Object { $_.Status -eq "WARN" }).Count
        failed = ($Results | Where-Object { $_.Status -eq "FAIL" }).Count
        tools = $Results
    }
    
    $summary | ConvertTo-Json -Depth 3 | Write-Host
}

# Main validation
Write-Host "=== Development Environment Validation ===" -ForegroundColor Cyan
Write-Host "Validating tools required for ASP.NET Core + Blazor + Google Cloud development" -ForegroundColor Gray
Write-Host ""

# Core Development Stack
$results += Test-Tool "Node.js" "node" "--version" "$EXPECTED_NODE_MAJOR\." { param($output) $output.Trim() }
$results += Test-Tool ".NET SDK" "dotnet" "--version" "$EXPECTED_DOTNET" { param($output) $output.Trim() }

# PowerShell Core
$psResult = [ValidationResult]::new()
$psResult.Tool = "PowerShell Core"
$psResult.Available = $true
$psResult.Version = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Patch)"
$psResult.ExpectedVersion = "$EXPECTED_PS_MAJOR\..*"
if ($PSVersionTable.PSVersion.Major -ge [int]$EXPECTED_PS_MAJOR) {
    $psResult.Status = "PASS"
    $psResult.Message = "✅ Available with expected version"
}
else {
    $psResult.Status = "WARN"
    $psResult.Message = "⚠️  Available but version may be too old"
}
$results += $psResult

# Cloud & DevOps Tools
$results += Test-Tool "Google Cloud CLI" "gcloud" "version --format=value(Google Cloud SDK)" "" { 
    param($output) 
    ($output -split "`n" | Where-Object { $_ -match "Google Cloud SDK" } | Select-Object -First 1) -replace "Google Cloud SDK ", ""
}
$results += Test-Tool "Firebase CLI" "firebase" "--version" "" { param($output) $output.Trim() }
$results += Test-Tool "GitHub CLI" "gh" "--version" "" { 
    param($output) 
    ($output -split "`n" | Select-Object -First 1) -replace "gh version ", ""
}

# Container & Infrastructure Tools
$results += Test-Tool "Docker" "docker" "--version" "" { 
    param($output) 
    ($output -replace "Docker version ", "").Split(",")[0]
}
$results += Test-Tool "Terraform" "terraform" "--version" "" { 
    param($output) 
    ($output -split "`n" | Select-Object -First 1) -replace "Terraform v", ""
}

# Additional .NET workloads check
if ($results | Where-Object { $_.Tool -eq ".NET SDK" -and $_.Status -eq "PASS" }) {
    try {
        $workloads = dotnet workload list 2>$null
        $wasmInstalled = $workloads -match "wasm-tools"
        
        $wasmResult = [ValidationResult]::new()
        $wasmResult.Tool = ".NET WebAssembly Tools"
        $wasmResult.Available = $wasmInstalled.Count -gt 0
        $wasmResult.Version = if ($wasmInstalled) { "Installed" } else { "Not installed" }
        $wasmResult.Status = if ($wasmInstalled) { "PASS" } else { "WARN" }
        $wasmResult.Message = if ($wasmInstalled) { "✅ WebAssembly workload available" } else { "⚠️  WebAssembly workload not installed" }
        $wasmResult.ExpectedVersion = "Required for Blazor WebAssembly"
        
        $results += $wasmResult
    }
    catch {
        # Ignore workload check failure
    }
}

# Output results
switch ($OutputFormat) {
    "Json" { 
        Write-ResultsJson $results 
    }
    "Markdown" { 
        Write-ResultsMarkdown $results 
    }
    default { 
        foreach ($result in $results) {
            Write-ResultText $result
        }
        
        # Summary
        $passed = ($results | Where-Object { $_.Status -eq "PASS" }).Count
        $warned = ($results | Where-Object { $_.Status -eq "WARN" }).Count
        $failed = ($results | Where-Object { $_.Status -eq "FAIL" }).Count
        $total = $results.Count
        
        Write-Host "Tools validated: $passed/$total" -ForegroundColor White
        
        if ($failed -eq 0 -and $warned -eq 0) {
            Write-Host "🎉 All development tools are properly installed and accessible!" -ForegroundColor Green
            exit 0
        }
        elseif ($failed -eq 0) {
            Write-Host "⚠️  Environment is mostly ready, but some warnings were found." -ForegroundColor Yellow
            Write-Host "Consider running setup-local-environment.ps1 to resolve warnings." -ForegroundColor Yellow
            exit 0
        }
        else {
            Write-Host "❌ Some required tools are missing or misconfigured." -ForegroundColor Red
            Write-Host "Please run setup-local-environment.ps1 to install missing tools." -ForegroundColor Red
            exit 1
        }
    }
}
