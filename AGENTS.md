# AGENTS.md

Guidance for AI agents working in this repository.

## Configuration

**Active Branch:** `optimization` <!-- Change for: main, optimization, feature/* -->

## Quick Start

**Read:** [ai-shared-agent-context.md](ai_instruction_modules/ai-shared-agent-context.md) for full context.

**Then:** [ai-core-instructions.md](ai_instruction_modules/ai-core-instructions.md) for core behaviors.

## Repository Overview

AI instruction framework for orchestrating agents through software development workflows.

**Capabilities:** Modular instructions | Dynamic workflows (DSL) | Role-based execution | Assignment definitions

## Key Paths

| Path | Purpose |
|------|---------|
| `ai_instruction_modules/` | Core + optional instruction modules |
| `ai_instruction_modules/ai-workflow-assignments/` | Task definitions with acceptance criteria |
| `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/` | Dynamic workflow DSL files |
| `scripts/` | PowerShell automation scripts |

## Remote Integration

**Canonical Source:** `nam20485/agent-instructions` on GitHub

**URL Pattern:**
- UI: `https://github.com/nam20485/agent-instructions/blob/{branch}/<path>`
- Raw: `https://raw.githubusercontent.com/nam20485/agent-instructions/{branch}/<path>`

**Single Source of Truth:** Fetch workflows/assignments from remote. No local caches.

## Execution Patterns

**Change Flow:** Context gather → Plan → Diff → Confirm → Apply/validate → Report

**Assignment Execution:** Resolution trace → Execute steps → Gate on acceptance criteria → Run report

For dynamic workflows, follow the orchestration rules in `ai-workflow-development-guide.md` and `ai-workflow-assignments/orchestrate-dynamic-workflow.md`.
Resolve each assignment file before execution. Do not synthesize steps outside resolved assignment files.

## Constraints

**Do NOT:** Large refactors without approval | Skip validation | Use local workflow caches

**Always:** Use sequential-thinking + memory tools | Smallest changes | Resolution traces
