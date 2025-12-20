# opencode-instructions.md

Guidance for OpenCode CLI agent.

## Configuration

**Branch:** MUST be read from [`.github/copilot-instructions.md`](.github/copilot-instructions.md) → `<configuration><branch>`. MUST NOT be hardcoded elsewhere.

## Instructions

**Read:** [ai-shared-agent-context.md](ai_instruction_modules/ai-shared-agent-context.md) for full context.

**Then:** [ai-core-instructions.md](ai_instruction_modules/ai-core-instructions.md) for core behaviors.

## OpenCode-Specific

- Prefer terminal-based file operations
- Use git commands directly when available
- Minimize interactive prompts
