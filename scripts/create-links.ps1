# run from directory where you want links made in

$agentInstructionsDir = "$PSScriptRoot/.."

# File: .github/copilot-instructions.md
New-Item -ItemType SymbolicLink -Path ./.github/copilot-instructions.md -Target $agentInstructionsDir/.github/copilot-instructions.md
# Directory: ./ai_instructions_modules
New-Item -ItemType SymbolicLink -Path ./ai_instructions_modules -Target $agentInstructionsDir/ai_instructions_modules
