ECHO ON

mkdir .\.github
del /F /Q .\.github\copilot-instructions.md
mklink .\.github\copilot-instructions.md ..\agent-instructions\.github\copilot-instructions.md
REM rmdir /S /Q .\ai_instruction_modules
del /F /Q .\ai_instruction_modules
mklink /D .\ai_instruction_modules ..\agent-instructions\ai_instruction_modules