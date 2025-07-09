ECHO ON

mkdir .\.github
mklink .\.github\copilot-instructions.md ..\agent-instructions\.github\copilot-instructions.md
mklink /D .\ai_instruction_modules ..\agent-instructions\ai_instruction_modules