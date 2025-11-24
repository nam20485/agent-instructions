# Development Environment Examples

## Example 1: Complete Environment Setup for New Project

```bash
#!/bin/bash
# setup-new-project.sh

set -e

echo "Setting up development environment..."

# 1. Clone repository
gh repo clone owner/my-project
cd my-project

# 2. Set version pins
cat > .nvmrc << EOF
22.18.0
EOF

cat > package.json << EOF
{
  "name": "my-project",
  "packageManager": "pnpm@8.15.0"
}
EOF

cat > global.json << EOF
{
  "sdk": {
    "version": "9.0.102"
  }
}
EOF

# 3. Run environment setup
bash scripts/setup-environment.sh

# 4. Verify installation
node --version
pnpm --version
dotnet --version

# 5. Install project dependencies
pnpm install

# 6. Build project
dotnet build
pnpm run build

echo "✓ Environment setup complete!"
```

## Example 2: PowerShell Module with Pester Tests

```powershell
# MyTools/Public/Get-Thing.ps1
function Get-Thing {
    <#
    .SYNOPSIS
    Retrieves things from the database.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Name
    )

    process {
        [PSCustomObject]@{
            Name = $Name
            Type = 'Thing'
            Retrieved = Get-Date
        }
    }
}

# MyTools/Tests/Get-Thing.Tests.ps1
Describe 'Get-Thing' {
    Context 'when called with valid name' {
        It 'returns a Thing object' {
            $result = Get-Thing -Name 'foo'

            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Be 'foo'
            $result.Type | Should -Be 'Thing'
        }
    }

    Context 'when called via pipeline' {
        It 'processes multiple names' {
            $results = 'foo', 'bar' | Get-Thing

            $results.Count | Should -Be 2
            $results[0].Name | Should -Be 'foo'
            $results[1].Name | Should -Be 'bar'
        }
    }
}

# Run tests
Invoke-Pester -Path ./MyTools/Tests -Output Detailed
```

## Example 3: GitHub Workflow Automation

```powershell
# create-feature-pr.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$FeatureName,

    [Parameter()]
    [string]$Repo = "owner/repo",

    [Parameter()]
    [string]$BaseBranch = "development"
)

$ErrorActionPreference = 'Stop'

try {
    # Create branch name
    $branchName = "feature/$FeatureName"

    Write-Verbose "Creating branch: $branchName"
    git switch -c $branchName

    Write-Verbose "Making initial commit"
    git commit --allow-empty -m "feat: initialize $FeatureName"

    Write-Verbose "Pushing branch"
    git push --set-upstream origin $branchName

    Write-Verbose "Creating pull request"
    gh pr create --repo $Repo `
        --base $BaseBranch `
        --head $branchName `
        --title "feat: $FeatureName" `
        --body "Implementation of $FeatureName feature" `
        --draft

    Write-Host "✓ Draft PR created successfully" -ForegroundColor Green
}
catch {
    Write-Error "Failed to create PR: $_"
    throw
}
```

## Example 4: Terminal Session Manager

```powershell
# Manage-BackgroundServices.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Start', 'Stop', 'Restart', 'Status')]
    [string]$Action,

    [Parameter()]
    [ValidateSet('WebApp', 'API', 'Worker', 'All')]
    [string]$Service = 'All'
)

$services = @{
    WebApp = @{ Path = './src/WebApp'; Command = 'dotnet run'; Port = 5000 }
    API    = @{ Path = './src/API'; Command = 'dotnet run'; Port = 5001 }
    Worker = @{ Path = './src/Worker'; Command = 'dotnet run'; Port = 5002 }
}

function Stop-Service {
    param([string]$ServiceName)
    
    $port = $services[$ServiceName].Port
    $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue |
        Get-Process -ErrorAction SilentlyContinue
    
    if ($process) {
        Write-Host "Stopping $ServiceName (PID: $($process.Id))" -ForegroundColor Yellow
        Stop-Process -Id $process.Id -Force
    }
}

function Start-Service {
    param([string]$ServiceName)
    
    $svc = $services[$ServiceName]
    Write-Host "Starting $ServiceName on port $($svc.Port)" -ForegroundColor Green
    
    Push-Location $svc.Path
    Start-Process -FilePath 'pwsh' -ArgumentList '-Command', $svc.Command -NoNewWindow
    Pop-Location
}

# Execute action
$targetServices = if ($Service -eq 'All') { $services.Keys } else { @($Service) }

foreach ($svc in $targetServices) {
    switch ($Action) {
        'Start'   { Start-Service $svc }
        'Stop'    { Stop-Service $svc }
        'Restart' { Stop-Service $svc; Start-Sleep -Seconds 2; Start-Service $svc }
        'Status'  {
            $port = $services[$svc].Port
            $running = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
            $status = if ($running) { "Running" } else { "Stopped" }
            Write-Host "$svc : $status" -ForegroundColor $(if ($running) { 'Green' } else { 'Red' })
        }
    }
}
```
