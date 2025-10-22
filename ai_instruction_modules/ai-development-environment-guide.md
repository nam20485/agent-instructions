<development_environment_guide>
# AI Development Environment Guide

<purpose>
## Purpose
Use this guide when setting up development environments, managing terminals, working with PowerShell, or executing shell commands. This comprehensive reference consolidates environment setup procedures, terminal best practices, PowerShell development guidelines, and proven command examples.

## When to Use This Guide
- Setting up new development environments (local, devcontainer, codespace)
- Managing terminal sessions and background processes
- Writing PowerShell scripts or cmdlets
- Executing GitHub CLI, Git, or other shell commands
- Troubleshooting environment configuration issues
- Installing and configuring development tools
- Working with package managers and version pinning
</purpose>

<quick_reference>
## Quick Reference

### Environment Types

**Local Development (Windows):**
- Shell: PowerShell Core (pwsh)
- Package Manager: winget, choco
- Terminal: Windows Terminal recommended

**Local Development (Linux/WSL):**
- Shell: bash
- Package Manager: apt, snap
- Terminal: Native Linux terminal or Windows Terminal

**Devcontainer/Codespaces/Agent Environment:**
- Shell: bash (configured via setup-environment.sh)
- Pre-configured tools from setup script
- Reproducible, version-pinned environment

### Core Tools and Versions

**Language Runtimes:**
- Node.js: Pinned via NVM (e.g., 22.18.0 from NODE_VERSION_PIN or .nvmrc)
- .NET SDK: 9.0+ on Windows, 10.0 (preview) on Linux
- Python: 3.x with pip, uv package manager

**Package Managers:**
- npm: Bundled with Node or pinned via NPM_VERSION_PIN
- pnpm/yarn: Managed via Corepack with version pins
- NVM: Node Version Manager for precise Node.js versioning

**DevOps Tools:**
- GitHub CLI (gh): Repository and project management
- Git: Version control
- Terraform: Infrastructure as Code
- Ansible: Configuration management
- Docker: Container runtime
- Playwright: Browser automation and testing

**Cloud CLIs:**
- Google Cloud CLI (gcloud)
- Azure CLI (optional)

### Terminal Management Principles

**Default Behavior (Recommended):**
- `run_in_terminal` with `isBackground=false` (or omitted)
- Reuses same terminal session for sequential commands
- Efficient, maintains context, clean process list

**Background Processes (Use Sparingly):**
- `run_in_terminal` with `isBackground=true`
- Creates new terminal for long-running services
- Use for: servers, watch tasks, Docker containers
- ⚠️ Always stop existing background process before starting new one

**Anti-Patterns to Avoid:**
- Multiple terminals for sequential commands
- Background mode for build/test commands
- Orphaned processes from improper cleanup

### PowerShell Quick Reference

**Naming Conventions:**
- Functions: `Verb-Noun` format (e.g., `Get-UserProfile`)
- Parameters: PascalCase (e.g., `$Username`)
- Variables: PascalCase (public), camelCase (private)
- Use approved verbs (`Get-Verb`)

**Parameter Patterns:**
- `[Parameter(Mandatory)]` for required parameters
- `[ValidateSet(...)]` for limited options
- `[switch]` for boolean flags
- `ValueFromPipeline` for pipeline support

**Output Best Practices:**
- Return PSCustomObject, not formatted text
- Use `-PassThru` pattern for action cmdlets
- `Write-Verbose` for operational details
- `Write-Warning` for warnings
- `Write-Error` for non-terminating errors
- Avoid `Write-Host` for data output

**Safety Features:**
- `[CmdletBinding(SupportsShouldProcess = $true)]`
- `$PSCmdlet.ShouldProcess()` for confirmations
- `ConfirmImpact` levels: Low, Medium, High
- Try/catch blocks for error handling

## Canonical Reference Files

For complete specifications and detailed guidance, refer to these canonical files:

### Environment Setup
**[ai-local-environment.md](./ai-local-environment.md)**
- Shell configuration (Windows, Linux, WSL)
- setup-environment.sh complete specification
- Tool installation procedures and version pinning
- Environment variable configuration
- Verification commands and troubleshooting

### Terminal Management
**[ai-terminal-management.md](./ai-terminal-management.md)**
- Terminal session reuse best practices
- Background process guidelines
- System resource impact analysis
- Cleanup strategies
- Correct vs incorrect usage examples

### PowerShell Development
**[ai-powershell-instructions.md](./ai-powershell-instructions.md)**
- Complete PowerShell cmdlet development guidelines
- Naming conventions and parameter design
- Pipeline and output patterns
- Error handling and ShouldProcess
- Module development and structure
- Testing with Pester framework
- Full end-to-end examples

### Working Commands
**[ai-working-command-examples.md](./ai-working-command-examples.md)**
- Validated, working command examples
- GitHub CLI patterns (auth, repos, PRs, projects)
- Git workflows (clone, branch, commit, push)
- PowerShell file operations
- Label and milestone management
- Base64 decoding and JSON filtering
- Conflict resolution patterns

## Common Workflows

### Setting Up a New Development Environment

1. **Determine Environment Type**
   - Local Windows: PowerShell + winget/choco
   - Local Linux/WSL: bash + apt
   - Devcontainer/Codespace: setup-environment.sh

2. **Run Environment Setup Script**
   
   Linux/WSL/Devcontainer:
   ```bash
   bash scripts/setup-environment.sh
   ```
   
   Quick minimal setup (skip large optional installs):
   ```bash
   SETUP_MINIMAL=1 bash scripts/setup-environment.sh
   ```
   
   Windows PowerShell:
   ```powershell
   pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
   ```

3. **Verify Installation**
   
   Check core tools:
   ```bash
   node --version
   npm --version
   python --version
   pwsh --version
   gcloud --version
   gh --version
   terraform --version
   dotnet --version
   ```
   
   Run environment summary (Linux):
   ```bash
   /tmp/show-env.sh
   ```

4. **Configure Version Pins**
   - Set `NODE_VERSION_PIN` or create `.nvmrc` for Node.js
   - Set `NPM_VERSION_PIN`, `PNPM_VERSION_PIN`, `YARN_VERSION_PIN` as needed
   - Use `package.json` `packageManager` field for Corepack
   - Set `DOTNET_VERSION_PIN` or use `global.json`

5. **Authenticate Tools**
   
   GitHub CLI:
   ```bash
   gh auth status
   gh auth refresh -s project,read:project -h github.com  # if Projects needed
   ```
   
   Google Cloud (if needed):
   ```bash
   gcloud auth login
   gcloud config set project PROJECT_ID
   ```

### Managing Terminal Sessions

#### Sequential Commands (Default Pattern)

```bash
# Correct: Reuse terminal for build/test/deploy sequence
run_in_terminal: dotnet build (isBackground=false)
run_in_terminal: dotnet test (isBackground=false)
run_in_terminal: git status (isBackground=false)
```

#### Background Services (Special Cases Only)

```bash
# Start a web server that needs to run continuously
run_in_terminal: dotnet run --project WebApp (isBackground=true)

# Start Docker container
run_in_terminal: docker-compose up (isBackground=true)

# Start file watcher
run_in_terminal: npm run watch (isBackground=true)
```

#### Cleanup Process

1. **List Running Processes**
   ```powershell
   # PowerShell
   Get-Process | Where-Object ProcessName -like 'pwsh*' | Select-Object Id, ProcessName, CPU, WorkingSet

   # Linux
   ps aux | grep -E 'node|dotnet|npm'
   ```

2. **Stop Background Process**
   ```powershell
   # PowerShell
   Stop-Process -Id <PID> -Force

   # Linux
   kill <PID>
   # or for graceful shutdown
   kill -TERM <PID>
   ```

3. **Verify Cleanup**
   ```bash
   # Check for orphaned processes
   ps aux | grep -E 'defunct|<defunct>'
   
   # Check port usage
   netstat -ano | findstr :<PORT>  # Windows
   lsof -i :<PORT>                 # Linux
   ```

### Writing PowerShell Cmdlets

#### Basic Cmdlet Structure

```powershell
function Get-UserProfile {
    <#
    .SYNOPSIS
    Retrieves user profile information.
    
    .DESCRIPTION
    Fetches detailed user profile data including name, email, and preferences.
    
    .PARAMETER Username
    The username to retrieve profile for.
    
    .PARAMETER ProfileType
    Type of profile information to return (Basic or Detailed).
    
    .EXAMPLE
    Get-UserProfile -Username "john.doe"
    
    .EXAMPLE
    Get-UserProfile -Username "jane.doe" -ProfileType Detailed
    
    .OUTPUTS
    PSCustomObject with user profile data
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Username,

        [Parameter()]
        [ValidateSet('Basic', 'Detailed')]
        [string]$ProfileType = 'Basic'
    )

    begin {
        Write-Verbose "Starting profile retrieval for $Username"
    }

    process {
        try {
            # Business logic here
            $profile = [PSCustomObject]@{
                Username = $Username
                ProfileType = $ProfileType
                Retrieved = Get-Date
            }

            Write-Output $profile
        }
        catch {
            Write-Error "Failed to retrieve profile: $_"
        }
    }

    end {
        Write-Verbose "Completed profile retrieval"
    }
}
```

#### Pipeline-Enabled Cmdlet

```powershell
function Update-ResourceStatus {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('Active', 'Inactive', 'Maintenance')]
        [string]$Status,

        [Parameter()]
        [switch]$PassThru
    )

    begin {
        Write-Verbose "Starting resource status update"
    }

    process {
        if ($PSCmdlet.ShouldProcess($Name, "Update status to $Status")) {
            # Update logic
            $resource = [PSCustomObject]@{
                Name = $Name
                Status = $Status
                Updated = Get-Date
            }

            if ($PassThru) {
                Write-Output $resource
            }
        }
    }

    end {
        Write-Verbose "Completed resource status update"
    }
}

# Usage:
Get-Resources | Update-ResourceStatus -Status Active -PassThru
```

#### Creating a PowerShell Module

```powershell
# Directory structure:
# MyTools/
#   MyTools.psd1          # Manifest
#   MyTools.psm1          # Root module
#   Public/               # Exported functions
#     Get-Thing.ps1
#     New-Thing.ps1
#   Private/              # Internal helpers
#     Convert-Internal.ps1

# MyTools.psm1 content:
$public  = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter *.ps1 -ErrorAction SilentlyContinue
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') -Filter *.ps1 -ErrorAction SilentlyContinue

foreach ($file in @($public + $private)) { . $file.FullName }

Export-ModuleMember -Function ($public | ForEach-Object { $_.BaseName })

# Create manifest:
$manifestParams = @{
    Path                  = '.\MyTools\MyTools.psd1'
    RootModule            = 'MyTools.psm1'
    ModuleVersion         = '1.0.0'
    Author                = 'Your Name'
    Description           = 'Utilities for working with Things'
    PowerShellVersion     = '7.2'
    CompatiblePSEditions  = @('Core')
}
New-ModuleManifest @manifestParams

# Import module:
Import-Module -Name (Resolve-Path './MyTools/MyTools.psd1') -Force
```

### Working with GitHub CLI

#### Repository Operations

```powershell
# Check auth status
gh auth status

# Create repo from template
gh repo create owner/new-repo --template owner/template-repo --public

# View repo details
gh repo view owner/repo --json name,sshUrl,defaultBranchRef,description

# Clone repo
gh repo clone owner/repo -- -q

# List repo contents
gh api repos/owner/repo/contents --jq '.[].name'
gh api repos/owner/repo/contents/.github --jq '.[].name'
```

#### Pull Request Workflow

```powershell
# Create feature branch
git switch -c feature/new-feature

# Make changes and commit
git add .
git commit -m "feat: add new feature"

# Push and create PR
git push --set-upstream origin feature/new-feature

gh pr create --repo owner/repo \
  --base development \
  --head feature/new-feature \
  --title "feat: add new feature" \
  --body "Description of changes"

# Enable auto-merge
gh pr merge 1 --repo owner/repo --squash --auto

# Check PR status
gh pr view 1 --repo owner/repo \
  --json state,isDraft,mergeStateStatus,mergeable \
  --jq '{state: .state, mergeable: .mergeable}'
```

#### Label and Milestone Management

```powershell
# Import labels from JSON
./scripts/import-labels.ps1 -Repo 'owner/repo' -LabelsFile '.github/.labels.json'

# Verify labels
gh api repos/owner/repo/labels --jq '.[].name' | sort

# Create milestones
./scripts/create-milestones.ps1 -Repo 'owner/repo' \
  -Titles 'Phase 1: Planning','Phase 2: Build','Phase 3: Test' \
  -SkipExisting

# Verify milestones
gh api repos/owner/repo/milestones --jq '.[].title'
```

### Version Pinning Best Practices

#### Node.js Version Pinning

**Option 1: .nvmrc file (recommended for team consistency)**
```bash
# Create .nvmrc
echo "22.18.0" > .nvmrc

# Install and use
nvm install
nvm use
```

**Option 2: Environment variable**
```bash
export NODE_VERSION_PIN="22.18.0"
bash scripts/setup-environment.sh
```

#### Package Manager Pinning

**Using package.json (Corepack)**
```json
{
  "packageManager": "pnpm@8.15.0"
}
```

**Using environment variables**
```bash
export PNPM_VERSION_PIN="8.15.0"
export YARN_VERSION_PIN="4.1.0"
```

#### .NET SDK Pinning

**Using global.json**
```json
{
  "sdk": {
    "version": "9.0.102",
    "rollForward": "latestPatch"
  }
}
```

**Using environment variable**
```bash
export DOTNET_VERSION_PIN="9.0.102"
```

## Troubleshooting

### Environment Setup Issues

**Problem:** NVM not found after installation
- **Cause**: Shell hasn't sourced NVM initialization script
- **Solution**: 
  ```bash
  # Linux/WSL
  source $HOME/.nvm/nvm.sh
  
  # Or reopen shell
  exec $SHELL
  ```
- **Prevention**: setup-environment.sh should source automatically; verify script completion

**Problem:** Corepack not available
- **Cause**: Node.js version too old or Corepack not enabled
- **Solution**:
  ```bash
  # Enable Corepack
  corepack enable
  
  # Or upgrade Node.js
  nvm install 22.18.0
  nvm use 22.18.0
  corepack enable
  ```
- **Prevention**: Use Node.js 16.9.0+ which includes Corepack

**Problem:** .NET workload installation fails
- **Cause**: Conflicting global.json, insufficient permissions
- **Solution**:
  ```bash
  # Check .NET installation
  dotnet --info
  
  # Manually install workload
  dotnet workload install wasm-tools
  
  # If permission issues, check user-local install
  ls -la ~/.dotnet
  ```
- **Prevention**: Run setup script from directory without global.json

### Terminal Management Issues

**Problem:** Port already in use when starting server
- **Cause**: Previous background process still running
- **Solution**:
  ```powershell
  # Find process using port
  netstat -ano | findstr :5000  # Windows
  lsof -i :5000                 # Linux
  
  # Stop process
  Stop-Process -Id <PID> -Force
  ```
- **Prevention**: Always stop background process before starting new one

**Problem:** Too many terminal sessions consuming resources
- **Cause**: Using isBackground=true for sequential commands
- **Solution**:
  ```powershell
  # Kill unnecessary PowerShell sessions
  Get-Process pwsh | Where-Object StartTime -lt (Get-Date).AddHours(-1) | Stop-Process -Force
  ```
- **Prevention**: Use isBackground=false (default) for build/test/deploy commands

**Problem:** Orphaned processes after terminal close
- **Cause**: Background processes not properly terminated
- **Solution**:
  ```bash
  # Find defunct processes
  ps aux | grep defunct
  
  # Kill parent process group
  kill -9 -<PGID>
  ```
- **Prevention**: Use proper signal handling in scripts, clean up in trap/finally blocks

### PowerShell Development Issues

**Problem:** ShouldProcess not prompting for confirmation
- **Cause**: ConfirmImpact too low or -Confirm not passed
- **Solution**:
  ```powershell
  # Set appropriate ConfirmImpact
  [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
  
  # Or force confirmation
  Remove-Resource -Name "critical" -Confirm
  ```
- **Prevention**: Use High ConfirmImpact for destructive operations

**Problem:** Pipeline not accepting objects
- **Cause**: Missing ValueFromPipeline or ValueFromPipelineByPropertyName
- **Solution**:
  ```powershell
  [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
  [string]$Name
  ```
- **Prevention**: Always include pipeline attributes for pipeline-enabled cmdlets

**Problem:** Module functions not exported
- **Cause**: Missing Export-ModuleMember or incorrect manifest
- **Solution**:
  ```powershell
  # Explicit export in .psm1
  Export-ModuleMember -Function Get-Thing, New-Thing
  
  # Or in manifest (.psd1)
  FunctionsToExport = @('Get-Thing', 'New-Thing')
  ```
- **Prevention**: Use explicit exports, avoid wildcards in published modules

### GitHub CLI Issues

**Problem:** Projects API scope error
- **Cause**: Missing project and read:project scopes
- **Solution**:
  ```bash
  gh auth refresh -s project,read:project -h github.com
  ```
- **Prevention**: Request all needed scopes during initial auth

**Problem:** Base64 decoding fails in PowerShell pipeline
- **Cause**: PowerShell pipeline quoting issues
- **Solution**:
  ```powershell
  # Use two-step approach
  gh api repos/owner/repo/contents/file.json --jq '.content' > tmp_b64.txt
  python -c "import base64,sys; b=open('tmp_b64.txt','rb').read().decode().replace('\\n',''); print(base64.b64decode(b).decode())"
  ```
- **Prevention**: Use intermediate file for complex decoding operations

**Problem:** PR auto-merge fails silently
- **Cause**: Branch protection, required checks pending
- **Solution**:
  ```powershell
  # Check PR status
  gh pr view 1 --repo owner/repo --json mergeStateStatus,statusCheckRollup
  
  # Check branch protection
  gh api repos/owner/repo/branches/main/protection
  ```
- **Prevention**: Verify branch protection rules, ensure checks pass before enabling auto-merge

## Examples

### Example 1: Complete Environment Setup for New Project

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

### Example 2: PowerShell Module with Pester Tests

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

### Example 3: GitHub Workflow Automation

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

### Example 4: Terminal Session Manager

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

## Summary

This guide consolidates development environment best practices across multiple domains:

**Environment Setup:**
- Use setup-environment.sh for reproducible environments
- Pin all tool versions explicitly (Node.js, npm, pnpm, .NET)
- Verify installations with version checks
- Configure authentication for CLIs (gh, gcloud)

**Terminal Management:**
- Default to terminal reuse (isBackground=false)
- Use background mode only for long-running services
- Stop existing processes before starting new ones
- Monitor and clean up orphaned processes

**PowerShell Development:**
- Follow Verb-Noun naming with approved verbs
- Support pipeline with proper attributes
- Implement ShouldProcess for destructive operations
- Create modules for reusable functionality
- Write Pester tests for all non-trivial code

**Command Execution:**
- Use validated command patterns from working examples
- Leverage gh CLI JSON output with --jq filtering
- Handle base64 decoding with intermediate files
- Follow clean Git workflows for PRs

**For Complete Details:**
- **Environment Setup**: See [ai-local-environment.md](./ai-local-environment.md)
- **Terminal Management**: See [ai-terminal-management.md](./ai-terminal-management.md)
- **PowerShell Guidelines**: See [ai-powershell-instructions.md](./ai-powershell-instructions.md)
- **Working Commands**: See [ai-working-command-examples.md](./ai-working-command-examples.md)

Remember: These guides provide navigation and quick reference. Always consult the canonical files for complete specifications and authoritative guidance.
</quick_reference>
</development_environment_guide>
