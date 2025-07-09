# run from directory where you want links made in

function Start-As-Admin {
    # Check if the script is running with elevated privileges
    $isElevated = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    
    if (-not $isElevated) {
        # Relaunch the script with elevated privileges
        Start-Process pwsh -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
        exit
    }
} 

Start-As-Admin 

$agentInstructionsDir = "$PSScriptRoot/.."

# File: .github/copilot-instructions.md
New-Item -ItemType Directory -Path ./.github -Force
New-Item -ItemType SymbolicLink -Path ./.github/copilot-instructions.md -Target $agentInstructionsDir/.github/copilot-instructions.md -Force
# Directory: ./ai_instructions_modules
New-Item -ItemType SymbolicLink -Path ./ai_instructions_modules -Target $agentInstructionsDir/ai_instructions_modules -Force
