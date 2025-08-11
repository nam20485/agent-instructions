<#
.SYNOPSIS
  Windows environment setup replicating the devcontainer Dockerfile toolchain.
.DESCRIPTION
  Installs / validates core tooling: Node 22, npm latest, Google Cloud CLI, Terraform,
  Firebase CLI, Angular CLI, create-react-app, TypeScript, ESLint, Prettier, and optional .NET workloads.
  Uses Chocolatey where convenient. Idempotent where possible.
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Host '=== Starting Windows environment setup (Dockerfile -> PowerShell) ==='

# Environment variables
$env:DOTNET_CLI_TELEMETRY_OPTOUT='1'
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE='1'
$env:DOTNET_NOLOGO='1'
$env:ASPNETCORE_ENVIRONMENT='Development'

function Install-ChocoPackage {
    param(
        [Parameter(Mandatory)][string]$Name,
        [string]$Params
    )
    if (-not (choco list --local-only | Select-String -Pattern "^$Name ")) {
        Write-Host "Installing $Name via Chocolatey..."
        if ($Params) { choco install $Name -y --no-progress --params $Params } else { choco install $Name -y --no-progress }
    } else {
        Write-Host "$Name already installed."
    }
}

# Node.js 22.x (Chocolatey package may lag; use official installer if needed)
function Install-Node22 {
    if (Get-Command node -ErrorAction SilentlyContinue) {
        $current = (node -v)
        if ($current -like 'v22*') {
            Write-Host "Node $current present."
            return
        } else {
            Write-Host "Updating Node to v22 (current $current)."
        }
    } else {
        Write-Host 'Installing Node v22.'
    }
    $installer = "$env:TEMP\node-v22-x64.msi"
    Invoke-WebRequest -Uri "https://nodejs.org/dist/latest-v22.x/node-v22.2.0-x64.msi" -OutFile $installer
    Start-Process msiexec.exe -Wait -ArgumentList "/i `"$installer`" /qn /norestart"
    Remove-Item $installer -Force
}

Write-Host '[1/8] Ensuring Node.js 22.x'
Install-Node22
Write-Host 'Upgrading npm to latest'
try { npm install -g npm@latest --no-audit --no-fund | Out-Null } catch { Write-Warning $_ }

Write-Host '[2/8] Installing Google Cloud CLI (gcloud)'
Install-ChocoPackage -Name googlecloudsdk

Write-Host '[3/8] Installing Terraform'
Install-ChocoPackage -Name terraform

Write-Host '[4/8] Installing GitHub CLI (gh)'
Install-ChocoPackage -Name gh

Write-Host '[5/8] Installing PowerShell modules (none required yet)'

Write-Host '[6/8] Global npm CLIs'
$globalTools = @('firebase-tools','@angular/cli','create-react-app','typescript','eslint','prettier')
foreach ($pkg in $globalTools) {
    Write-Host " - $pkg"
    try { npm install -g $pkg --no-audit --no-fund | Out-Null } catch { Write-Warning "Failed installing ${pkg}: $_" }
}

Write-Host '[7/8] Optional .NET workloads'
if (Get-Command dotnet -ErrorAction SilentlyContinue) {
    try { dotnet workload update } catch { Write-Warning $_ }
    foreach ($wl in 'wasm-tools','aspire') {
        try { dotnet workload install $wl } catch { Write-Warning "Workload $wl install warning: $_" }
    }
} else {
    Write-Warning 'dotnet not found; skipping workloads.'
}

Write-Host '[8/8] Environment summary'
Write-Host 'Core Development Stack:'
Write-Host ('- .NET SDK: ' + ($(Get-Command dotnet -ErrorAction SilentlyContinue) ? (dotnet --version) : 'Not Installed'))
Write-Host ('- Node.js: ' + ($(Get-Command node -ErrorAction SilentlyContinue) ? (node -v) : 'Not Installed'))
Write-Host ('- npm: ' + ($(Get-Command npm -ErrorAction SilentlyContinue) ? (npm -v) : 'Not Installed'))
Write-Host ('- Python: ' + ($(Get-Command python -ErrorAction SilentlyContinue) ? (python --version) : 'Not Installed'))
Write-Host ('- PowerShell: ' + $PSVersionTable.PSVersion.ToString())
Write-Host ''
Write-Host 'Cloud & DevOps Tools:'
Write-Host ('- Google Cloud CLI: ' + ($(Get-Command gcloud -ErrorAction SilentlyContinue) ? ((gcloud version 2>$null | Select-String "Google Cloud SDK" ) -replace 'Google Cloud SDK ', '') : 'Not Installed'))
Write-Host ('- Firebase CLI: ' + ($(Get-Command firebase -ErrorAction SilentlyContinue) ? (firebase --version) : 'Not Installed'))
Write-Host ('- GitHub CLI: ' + ($(Get-Command gh -ErrorAction SilentlyContinue) ? ((gh --version | Select-Object -First 1).Trim()) : 'Not Installed'))
Write-Host ('- Terraform: ' + ($(Get-Command terraform -ErrorAction SilentlyContinue) ? ((terraform --version | Select-Object -First 1).Trim()) : 'Not Installed'))
Write-Host ''
Write-Host '=== Windows environment setup complete ==='
