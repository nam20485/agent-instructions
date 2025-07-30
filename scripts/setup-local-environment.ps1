#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Sets up local development environment for ASP.NET Core + Blazor + Google Cloud development
    
.DESCRIPTION
    This script installs and configures all the tools needed for development as specified
    in the AI instruction modules. It mirrors the GitHub Actions workflow setup for consistency.
    
.PARAMETER SkipValidation
    Skip the environment validation step
    
.PARAMETER SkipChocolatey
    Skip Chocolatey installation (Windows only)
    
.PARAMETER Force
    Force reinstallation of tools even if they exist
    
.EXAMPLE
    .\setup-local-environment.ps1
    
.EXAMPLE
    .\setup-local-environment.ps1 -Force -SkipValidation
#>

[CmdletBinding()]
param(
    [switch]$SkipValidation,
    [switch]$SkipChocolatey,
    [switch]$Force
)

# Set error handling
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Environment variables matching the GitHub workflow
$DOTNET_VERSION = "9.0.102"
$NODE_VERSION = "22"
$POWERSHELL_VERSION = "7.4"

function Write-Section {
    param([string]$Title)
    Write-Host "`n==============================================================================" -ForegroundColor Cyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host "==============================================================================" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

function Install-Chocolatey {
    if ($SkipChocolatey) {
        Write-Warning "Skipping Chocolatey installation as requested"
        return
    }
    
    if (Test-Command "choco") {
        Write-Success "Chocolatey is already installed"
        return
    }
    
    Write-Host "Installing Chocolatey package manager..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Success "Chocolatey installed successfully"
}

function Install-DotNetSDK {
    Write-Section "CORE DEVELOPMENT PLATFORMS & RUNTIMES"
    
    # Check if correct .NET version is installed
    $currentDotNet = $null
    try {
        $currentDotNet = dotnet --version 2>$null
    }
    catch {
        # dotnet not installed
    }
    
    if ($currentDotNet -eq $DOTNET_VERSION -and -not $Force) {
        Write-Success ".NET SDK $DOTNET_VERSION is already installed"
    }
    else {
        Write-Host "Installing .NET SDK $DOTNET_VERSION..."
        
        if ($IsWindows) {
            # Use winget or download installer
            try {
                winget install Microsoft.DotNet.SDK.9 --version $DOTNET_VERSION --silent
                Write-Success ".NET SDK installed via winget"
            }
            catch {
                Write-Warning "winget failed, downloading installer..."
                $url = "https://download.visualstudio.microsoft.com/download/pr/2b2d0c65-244b-4cef-b13a-dd2bdd9fe637/f6027bfec21643b6eb4f87e8e6c2e6bd/dotnet-sdk-9.0.102-win-x64.exe"
                $installer = "$env:TEMP\dotnet-sdk-installer.exe"
                Invoke-WebRequest -Uri $url -OutFile $installer
                Start-Process -FilePath $installer -ArgumentList "/quiet" -Wait
                Remove-Item $installer
                Write-Success ".NET SDK installed via installer"
            }
        }
        elseif ($IsLinux) {
            # Use package manager
            wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
            sudo dpkg -i packages-microsoft-prod.deb
            sudo apt-get update
            sudo apt-get install -y dotnet-sdk-9.0
            Write-Success ".NET SDK installed via apt"
        }
        elseif ($IsMacOS) {
            # Use Homebrew
            brew install dotnet@9
            Write-Success ".NET SDK installed via Homebrew"
        }
    }
    
    # Install WebAssembly workloads
    Write-Host "Installing .NET WebAssembly workloads for Blazor..."
    dotnet workload install wasm-tools
    dotnet workload update
    Write-Success "WebAssembly workloads installed"
}

function Install-NodeJS {
    $currentNode = $null
    try {
        $currentNode = node --version 2>$null
    }
    catch {
        # node not installed
    }
    
    if ($currentNode -like "v$NODE_VERSION.*" -and -not $Force) {
        Write-Success "Node.js $NODE_VERSION is already installed"
    }
    else {
        Write-Host "Installing Node.js $NODE_VERSION..."
        
        if ($IsWindows) {
            if (Test-Command "choco") {
                choco install nodejs --version $NODE_VERSION.* -y
            }
            else {
                winget install OpenJS.NodeJS --version $NODE_VERSION
            }
        }
        elseif ($IsLinux) {
            curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            sudo apt-get install -y nodejs
        }
        elseif ($IsMacOS) {
            brew install node@22
        }
        
        Write-Success "Node.js installed"
    }
}

function Install-PowerShellCore {
    $currentPS = $PSVersionTable.PSVersion
    if ($currentPS.Major -ge 7 -and $currentPS.Minor -ge 1 -and -not $Force) {
        Write-Success "PowerShell Core $($currentPS.Major).$($currentPS.Minor) is already installed"
        return
    }
    
    Write-Host "Installing PowerShell Core $POWERSHELL_VERSION..."
    
    if ($IsWindows) {
        if (Test-Command "choco") {
            choco install powershell-core -y
        }
        else {
            winget install Microsoft.PowerShell
        }
    }
    elseif ($IsLinux) {
        wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
        sudo dpkg -i packages-microsoft-prod.deb
        sudo apt-get update
        sudo apt-get install -y powershell
    }
    elseif ($IsMacOS) {
        brew install powershell
    }
    
    Write-Success "PowerShell Core installed"
}

function Install-CloudTools {
    Write-Section "CLOUD DEVELOPMENT TOOLS"
    
    # Google Cloud CLI
    if (Test-Command "gcloud" -and -not $Force) {
        Write-Success "Google Cloud CLI is already installed"
    }
    else {
        Write-Host "Installing Google Cloud CLI..."
        
        if ($IsWindows) {
            if (Test-Command "choco") {
                choco install gcloudsdk -y
            }
            else {
                $url = "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"
                $installer = "$env:TEMP\GoogleCloudSDKInstaller.exe"
                Invoke-WebRequest -Uri $url -OutFile $installer
                Start-Process -FilePath $installer -ArgumentList "/S" -Wait
                Remove-Item $installer
            }
        }
        elseif ($IsLinux) {
            curl https://sdk.cloud.google.com | bash
            exec -l $SHELL
        }
        elseif ($IsMacOS) {
            brew install google-cloud-sdk
        }
        
        Write-Success "Google Cloud CLI installed"
    }
    
    # Firebase CLI
    if (Test-Command "firebase" -and -not $Force) {
        Write-Success "Firebase CLI is already installed"
    }
    else {
        Write-Host "Installing Firebase CLI..."
        npm install -g firebase-tools
        Write-Success "Firebase CLI installed"
    }
    
    # GitHub CLI
    if (Test-Command "gh" -and -not $Force) {
        Write-Success "GitHub CLI is already installed"
    }
    else {
        Write-Host "Installing GitHub CLI..."
        
        if ($IsWindows) {
            if (Test-Command "choco") {
                choco install gh -y
            }
            else {
                winget install GitHub.cli
            }
        }
        elseif ($IsLinux) {
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            sudo apt update
            sudo apt install gh
        }
        elseif ($IsMacOS) {
            brew install gh
        }
        
        Write-Success "GitHub CLI installed"
    }
}

function Install-AITools {
    Write-Section "AI DEVELOPMENT TOOLS"
    
    # Python 3.x LTS
    if (Test-Command "python3" -and -not $Force) {
        Write-Success "Python 3 is already installed"
    }
    elseif (Test-Command "python" -and -not $Force) {
        # Check if it's Python 3
        $pythonVersion = python --version 2>&1
        if ($pythonVersion -match "Python 3\.") {
            Write-Success "Python 3 is already installed as 'python'"
        }
        else {
            Write-Host "Installing Python 3.x LTS..."
            Install-PythonPackage
        }
    }
    else {
        Write-Host "Installing Python 3.x LTS..."
        Install-PythonPackage
    }
    
    # Gemini CLI (preview)
    if (Test-Command "gemini" -and -not $Force) {
        Write-Success "Gemini CLI is already installed"
    }
    else {
        Write-Host "Installing Gemini CLI (preview)..."
        
        if ($IsWindows) {
            # Download and install Gemini CLI for Windows
            $geminiUrl = "https://ai.google.dev/gemini-api/docs/api-key"
            Write-Host "Please visit $geminiUrl to get your API key after installation"
            
            # Create a temporary directory for Gemini CLI
            $geminiDir = "$env:LOCALAPPDATA\gemini-cli"
            if (-not (Test-Path $geminiDir)) {
                New-Item -ItemType Directory -Path $geminiDir -Force | Out-Null
            }
            
            # Download the latest Gemini CLI
            try {
                $downloadUrl = "https://github.com/google-gemini/gemini-cli/releases/latest/download/gemini-cli-windows-amd64.exe"
                $geminiExe = "$geminiDir\gemini.exe"
                Invoke-WebRequest -Uri $downloadUrl -OutFile $geminiExe -ErrorAction SilentlyContinue
                
                # Add to PATH if not already there
                $currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
                if ($currentPath -notlike "*$geminiDir*") {
                    [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$geminiDir", "User")
                    $env:PATH += ";$geminiDir"
                }
                
                Write-Success "Gemini CLI installed to $geminiDir"
            }
            catch {
                Write-Warning "Could not download Gemini CLI automatically. Please install manually from https://github.com/google-gemini/gemini-cli"
            }
        }
        elseif ($IsLinux -or $IsMacOS) {
            # Download and install Gemini CLI for Linux/macOS
            $arch = if ($IsMacOS) { "darwin" } else { "linux" }
            $downloadUrl = "https://github.com/google-gemini/gemini-cli/releases/latest/download/gemini-cli-$arch-amd64"
            
            try {
                curl -L $downloadUrl -o /tmp/gemini-cli
                chmod +x /tmp/gemini-cli
                sudo mv /tmp/gemini-cli /usr/local/bin/gemini
                Write-Success "Gemini CLI installed to /usr/local/bin/gemini"
            }
            catch {
                Write-Warning "Could not download Gemini CLI automatically. Please install manually from https://github.com/google-gemini/gemini-cli"
            }
        }
    }
}

function Install-PythonPackage {
    if ($IsWindows) {
        if (Test-Command "choco") {
            choco install python -y
        }
        else {
            winget install Python.Python.3.12
        }
    }
    elseif ($IsLinux) {
        sudo apt update
        sudo apt install -y python3 python3-pip python3-venv
    }
    elseif ($IsMacOS) {
        brew install python@3.12
    }
    
    Write-Success "Python 3.x LTS installed"
}

function Install-ContainerTools {
    Write-Section "CONTAINER & INFRASTRUCTURE TOOLS"
    
    # Docker
    if (Test-Command "docker" -and -not $Force) {
        Write-Success "Docker is already installed"
    }
    else {
        Write-Host "Installing Docker..."
        
        if ($IsWindows) {
            Write-Warning "Please install Docker Desktop manually from https://www.docker.com/products/docker-desktop"
        }
        elseif ($IsLinux) {
            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh get-docker.sh
            sudo usermod -aG docker $USER
            rm get-docker.sh
        }
        elseif ($IsMacOS) {
            brew install docker
        }
        
        Write-Success "Docker installation initiated"
    }
    
    # Terraform
    if (Test-Command "terraform" -and -not $Force) {
        Write-Success "Terraform is already installed"
    }
    else {
        Write-Host "Installing Terraform..."
        
        if ($IsWindows) {
            if (Test-Command "choco") {
                choco install terraform -y
            }
            else {
                winget install Hashicorp.Terraform
            }
        }
        elseif ($IsLinux) {
            wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt install terraform
        }
        elseif ($IsMacOS) {
            brew tap hashicorp/tap
            brew install hashicorp/tap/terraform
        }
        
        Write-Success "Terraform installed"
    }
}

function Test-Environment {
    if ($SkipValidation) {
        Write-Warning "Skipping environment validation as requested"
        return
    }
    
    Write-Section "ENVIRONMENT VALIDATION & TOOL VERIFICATION"
    
    $allGood = $true
    
    # Test .NET
    try {
        $dotnetVersion = dotnet --version
        Write-Success ".NET SDK: $dotnetVersion"
        dotnet --list-workloads | Out-Null
        Write-Success ".NET workloads available"
    }
    catch {
        Write-Error ".NET SDK validation failed"
        $allGood = $false
    }
    
    # Test Node.js
    try {
        $nodeVersion = node --version
        $npmVersion = npm --version
        Write-Success "Node.js: $nodeVersion, npm: $npmVersion"
    }
    catch {
        Write-Error "Node.js validation failed"
        $allGood = $false
    }
    
    # Test PowerShell
    Write-Success "PowerShell Core: $($PSVersionTable.PSVersion)"
    
    # Test cloud tools
    try {
        gcloud version --quiet | Out-Null
        Write-Success "Google Cloud CLI available"
    }
    catch {
        Write-Warning "Google Cloud CLI validation failed"
    }
    
    try {
        firebase --version | Out-Null
        Write-Success "Firebase CLI available"
    }
    catch {
        Write-Warning "Firebase CLI validation failed"
    }
    
    try {
        gh --version | Out-Null
        Write-Success "GitHub CLI available"
    }
    catch {
        Write-Warning "GitHub CLI validation failed"
    }
    
    # Test Docker
    try {
        docker --version | Out-Null
        Write-Success "Docker available"
    }
    catch {
        Write-Warning "Docker validation failed"
    }
    
    # Test Terraform
    try {
        terraform --version | Out-Null
        Write-Success "Terraform available"
    }
    catch {
        Write-Warning "Terraform validation failed"
    }
    
    # Test Python
    $pythonCmd = if (Test-Command "python3") { "python3" } elseif (Test-Command "python") { "python" } else { $null }
    if ($pythonCmd) {
        try {
            $pythonVersion = & $pythonCmd --version 2>&1
            if ($pythonVersion -match "Python 3\.") {
                Write-Success "Python 3 available ($pythonVersion)"
            }
            else {
                Write-Warning "Python found but not version 3: $pythonVersion"
            }
        }
        catch {
            Write-Warning "Python validation failed"
        }
    }
    else {
        Write-Warning "Python not found in PATH"
    }
    
    # Test Gemini CLI
    try {
        gemini --version 2>&1 | Out-Null
        Write-Success "Gemini CLI available"
    }
    catch {
        Write-Warning "Gemini CLI validation failed"
    }
    
    if ($allGood) {
        Write-Section "🚀 DEVELOPMENT ENVIRONMENT READY!"
        Write-Host "Ready for:" -ForegroundColor Green
        Write-Host "- 🌐 ASP.NET Core Web API development" -ForegroundColor Green
        Write-Host "- ⚡ Blazor WebAssembly applications" -ForegroundColor Green
        Write-Host "- 🐳 Docker containerization" -ForegroundColor Green
        Write-Host "- ☁️ Google Cloud deployment" -ForegroundColor Green
        Write-Host "- 🔥 Firebase hosting" -ForegroundColor Green
        Write-Host "- 🧪 TDD with xUnit testing" -ForegroundColor Green
        Write-Host "- 🏗️ Terraform infrastructure as code" -ForegroundColor Green
        Write-Host "- 🤖 AI development with Python & Gemini CLI" -ForegroundColor Green
    }
    else {
        Write-Error "Some tools failed validation. Please check the installation."
        exit 1
    }
}

# Main execution
try {
    Write-Host "🚀 Setting up local development environment for ASP.NET Core + Blazor + Google Cloud" -ForegroundColor Cyan
    Write-Host "This script mirrors the GitHub Actions workflow for consistency." -ForegroundColor Gray
    
    if ($IsWindows -and -not $SkipChocolatey) {
        Install-Chocolatey
    }
    
    Install-DotNetSDK
    Install-NodeJS
    Install-PowerShellCore
    Install-CloudTools
    Install-AITools
    Install-ContainerTools
    Test-Environment
    
    Write-Host "`n✅ Local development environment setup complete!" -ForegroundColor Green
}
catch {
    Write-Error "Setup failed: $($_.Exception.Message)"
    Write-Host "Stack trace:" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
