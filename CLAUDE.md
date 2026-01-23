# CLAUDE.md

Guidance for Claude Code (claude.ai/code).

## Configuration

**Branch:** MUST be read from [`.github/copilot-instructions.md`](.github/copilot-instructions.md) → `<configuration><branch>`. MUST NOT be hardcoded elsewhere.

## Instructions

**Read:** [ai-shared-agent-context.md](ai_instruction_modules/ai-shared-agent-context.md) for full context.

**Then:** [ai-core-instructions.md](ai_instruction_modules/ai-core-instructions.md) for core behaviors.

## Claude-Specific

- Use sequential-thinking and memory tools for every request
- Prefer structured XML output when presenting options
- For complex tasks, break down using thinking tool before acting
