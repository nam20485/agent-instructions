#!/usr/bin/env pwsh
<#!
Windows environment setup (canonical)
- NVM for Windows everywhere with exact Node pin (from .nvmrc or NODE_VERSION_PIN)
- Optional npm pin via NPM_VERSION_PIN
- Corepack enable (pnpm/yarn)
- Installs: Git, Python3, Google Cloud CLI, GitHub CLI, Terraform, Ansible (pip), global npm CLIs (firebase, angular, CRA, typescript, eslint, prettier, cdktf)
- .NET 9 SDK workloads (wasm-tools, aspire) & Aspire templates (user-local)
Note: Some installers may require admin rights (winget/choco).
!#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host '=== Starting Windows environment setup (Linux parity) ==='

# -----------------------------------------------------------------------------
# Environment variables
# -----------------------------------------------------------------------------
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE = '1'
$env:DOTNET_NOLOGO = '1'
$env:ASPNETCORE_ENVIRONMENT = 'Development'

function Test-Command {
    param([Parameter(Mandatory)][string]$Name)
    try { Get-Command $Name -ErrorAction Stop | Out-Null; $true } catch { $false }
}

function Get-PackageManager {
    if (Test-Command choco) { return 'choco' }
    if (Test-Command winget) { return 'winget' }
    return $null
}

function Install-Git {
    if (Test-Command git) { return }
        $mgr = Get-PackageManager
    if ($mgr -eq 'choco') { choco install git -y --no-progress }
    elseif ($mgr -eq 'winget') { winget install --id Git.Git --silent --accept-source-agreements --accept-package-agreements }
}

# -----------------------------------------------------------------------------
# NVM for Windows + exact Node pin
# -----------------------------------------------------------------------------
function Install-NvmWindows {
    if (Test-Command nvm) { return }
    $mgr = Get-PackageManager
    if ($mgr -eq 'winget') {
        try { winget install --id CoreyButler.NVMforWindows --silent --accept-source-agreements --accept-package-agreements } catch {}
    } elseif ($mgr -eq 'choco') {
        choco install nvm -y --no-progress
    } else {
        Write-Warning 'No package manager found (winget/choco). Download and install NVM for Windows manually from https://github.com/coreybutler/nvm-windows/releases'
    }
}

function Install-Node-With-Nvm {
    Install-NvmWindows
    if (-not (Test-Command nvm)) { throw 'nvm (Windows) is not available after install.' }

    # Determine desired Node version
    $nodeVersion = $env:NODE_VERSION_PIN
    if ([string]::IsNullOrWhiteSpace($nodeVersion)) {
        $nvmrcPath = Join-Path -Path (Get-Location) -ChildPath '.nvmrc'
        if (Test-Path $nvmrcPath) {
            $nodeVersion = (Get-Content $nvmrcPath -Raw).Trim()
        }
    }
    if ([string]::IsNullOrWhiteSpace($nodeVersion)) {
        throw 'No exact Node version specified. Set NODE_VERSION_PIN or add .nvmrc (e.g., 22.18.0).'
    }

    Write-Host "[nvm] Installing Node $nodeVersion"
    nvm install $nodeVersion | Out-Null
    nvm use $nodeVersion | Out-Null

    # Ensure current session PATH sees node (nvm updates symlink at %ProgramFiles%\nodejs)
    $nodeDir = "$env:ProgramFiles\nodejs"
    if ($env:PATH -notmatch [regex]::Escape($nodeDir)) { $env:PATH = "$nodeDir;$env:PATH" }

    # npm pin (optional). Otherwise keep bundled npm for determinism
    if (-not [string]::IsNullOrWhiteSpace($env:NPM_VERSION_PIN)) {
        Write-Host "[npm] Pinning npm@$($env:NPM_VERSION_PIN)"
        npm install -g --no-audit --no-fund "npm@$($env:NPM_VERSION_PIN)" | Out-Null
    }

    Write-Host '[corepack] Enabling'
    try { corepack enable | Out-Null } catch {}
    try { corepack prepare pnpm@latest --activate | Out-Null } catch {}
    try { corepack prepare yarn@stable --activate | Out-Null } catch {}
}

# -----------------------------------------------------------------------------
# Base tools (Git, Python)
# -----------------------------------------------------------------------------
function Install-Python3 {
    if (Test-Command python3) { return }
        $mgr = Get-PackageManager
    if ($mgr -eq 'choco') { choco install python -y --no-progress }
    elseif ($mgr -eq 'winget') { winget install --id Python.Python.3.12 --silent --accept-source-agreements --accept-package-agreements }
}

# -----------------------------------------------------------------------------
# Cloud & DevOps tools: gcloud, gh, terraform, ansible
# -----------------------------------------------------------------------------
function Install-GCloud {
    if (Test-Command gcloud) { return }
        $mgr = Get-PackageManager
    if ($mgr -eq 'choco') { choco install googlecloudsdk -y --no-progress }
    elseif ($mgr -eq 'winget') { winget install --id Google.CloudSDK --silent --accept-source-agreements --accept-package-agreements }
}

function Install-GH {
    if (Test-Command gh) { return }
        $mgr = Get-PackageManager
    if ($mgr -eq 'choco') { choco install gh -y --no-progress }
    elseif ($mgr -eq 'winget') { winget install --id GitHub.cli --silent --accept-source-agreements --accept-package-agreements }
}

function Install-Terraform {
    if (Test-Command terraform) { return }
        $mgr = Get-PackageManager
    if ($mgr -eq 'choco') { choco install terraform -y --no-progress }
    elseif ($mgr -eq 'winget') { winget install --id Hashicorp.Terraform --silent --accept-source-agreements --accept-package-agreements }
}

function Install-Ansible {
    if (Test-Command ansible) { return }
    Write-Warning 'Ansible on Windows is best via WSL. Installing via pip (user scope) as best-effort.'
        Install-Python3
    try { pip3 install --user ansible | Out-Null } catch { Write-Warning "pip3 install ansible failed: $($_.Exception.Message)" }
}

# -----------------------------------------------------------------------------
# .NET 9 SDK (user-local) & workloads
# -----------------------------------------------------------------------------
function Install-DotNet9 {
    $dotnetVersion = $null
    try { $dotnetVersion = (dotnet --version) } catch {}
    if (-not ($dotnetVersion -like '9.*')) {
        Write-Host '[dotnet] Installing .NET 9 SDK (user-local)'
        $installer = Join-Path $env:TEMP 'dotnet-install.ps1'
        Invoke-WebRequest -Uri 'https://dot.net/v1/dotnet-install.ps1' -OutFile $installer
        & powershell -ExecutionPolicy Bypass -File $installer -Channel 9.0 -InstallDir "$env:USERPROFILE\.dotnet" -NoPath | Out-Null
        $env:PATH = "$env:USERPROFILE\.dotnet;$env:PATH"
    }
    if (Test-Command dotnet) {
        try { dotnet workload update | Out-Null } catch {}
        foreach ($wl in 'wasm-tools','aspire') { try { dotnet workload install $wl | Out-Null } catch {} }
        try { dotnet new install Aspire.ProjectTemplates | Out-Null } catch {}
    }
}

# -----------------------------------------------------------------------------
# Global npm CLIs (user scope under NVM-managed Node)
# -----------------------------------------------------------------------------
function Install-GlobalNpmCLIs {
    $pkgs = @('firebase-tools','@angular/cli','create-react-app','typescript','eslint','prettier','cdktf-cli')
    foreach ($p in $pkgs) {
        try { npm install -g --no-audit --no-fund $p | Out-Null } catch { Write-Warning "Failed to install ${p}: $($_.Exception.Message)" }
    }
}

# -----------------------------------------------------------------------------
# Execution
# -----------------------------------------------------------------------------
try {
        Install-Git
        Install-Python3
    Install-Node-With-Nvm
        Install-GCloud
        Install-GH
        Install-Terraform
        Install-Ansible
    Install-GlobalNpmCLIs
        Install-DotNet9

    Write-Host '\nEnvironment summary:' -ForegroundColor Cyan
    Write-Host ('- .NET SDK: ' + ($(Get-Command dotnet -ErrorAction SilentlyContinue) ? (dotnet --version) : 'Not Installed'))
    Write-Host ('- Node.js: ' + ($(Get-Command node -ErrorAction SilentlyContinue) ? (node -v) : 'Not Installed'))
    Write-Host ('- npm: ' + ($(Get-Command npm -ErrorAction SilentlyContinue) ? (npm -v) : 'Not Installed'))
    Write-Host ('- Python: ' + ($(Get-Command python -ErrorAction SilentlyContinue) ? (python --version) : ($(Get-Command python3 -ErrorAction SilentlyContinue) ? (python3 --version) : 'Not Installed')))
    Write-Host ('- PowerShell: ' + $PSVersionTable.PSVersion.ToString())
    Write-Host ''
    Write-Host ('- Google Cloud CLI: ' + ($(Get-Command gcloud -ErrorAction SilentlyContinue) ? ((gcloud version 2>$null | Select-String "Google Cloud SDK" ) -replace 'Google Cloud SDK ', '') : 'Not Installed'))
    Write-Host ('- Firebase CLI: ' + ($(Get-Command firebase -ErrorAction SilentlyContinue) ? (firebase --version) : 'Not Installed'))
    Write-Host ('- GitHub CLI: ' + ($(Get-Command gh -ErrorAction SilentlyContinue) ? ((gh --version | Select-Object -First 1).Trim()) : 'Not Installed'))
    Write-Host ('- Terraform: ' + ($(Get-Command terraform -ErrorAction SilentlyContinue) ? ((terraform --version | Select-Object -First 1).Trim()) : 'Not Installed'))
    Write-Host ('- Ansible: ' + ($(Get-Command ansible -ErrorAction SilentlyContinue) ? ((ansible --version | Select-Object -First 1).Trim()) : 'Not Installed'))
    Write-Host ('- CDKTF: ' + ($(Get-Command cdktf -ErrorAction SilentlyContinue) ? ((cdktf --version).Trim()) : 'Not Installed'))

    Write-Host '\n=== Windows environment setup complete ===' -ForegroundColor Green
}
catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    throw
}
