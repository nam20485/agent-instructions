---
description: Shared context for all AI agents - included by agent-specific entry points
scope: shared-context
---
# Shared Agent Context

## Repository Overview

AI instruction framework for orchestrating agents through software development workflows.

**Capabilities:** Modular instructions, dynamic workflow DSL, orchestrator/collaborator patterns, assignment-based definitions.

## Scripts

`scripts/`: `setup-environment.ps1`, `import-labels.ps1`, `create-milestones.ps1`, `query.ps1`

## Instruction Modules (`ai_instruction_modules/`)

**Core (Required):** `ai-core-instructions.md`, `ai-executive-summary.md`, `ai-personal-preferences.md`, `ai-workflow-config.md`, `ai-local-environment.md`

**Optional:** `ai-terminal-management.md`, `ai-testing-validation.md`, `ai-application-guidelines.md`, `ai-design-principles.md`, `ai-powershell-instructions.md`

## Workflow System

**Roles:** Orchestrator (coordinates), Collaborator (executes)

**Assignments:** `ai-workflow-assignments/<short-id>.md` — Goal, Acceptance Criteria, Steps

**Dynamic Workflows:** `ai-workflow-assignments/dynamic-workflows/` — DSL scripts with events

## DSL Quick Reference

```markdown
$variable = value
$list = [item1, item2]
For each $item in $list, you will:
  - assign the agent the '$assignment' assignment
  - record output as #step.$item
if $condition is true:
  - action
```

## Remote Repository

**Canonical:** `nam20485/agent-instructions`

### Branch configuration authority

- **MUST:** All agent-specific entrypoints MUST read `{branch}` from [`../.github/copilot-instructions.md`](../.github/copilot-instructions.md) → `<configuration><branch>`.
- **Fallback:** If the bootstrap config cannot be read, default to `main`.
- **MUST NOT:** Do not hardcode branch values in entrypoints.

**URL Translation:**
- UI: `https://github.com/.../blob/{branch}/...`
- Raw: `https://raw.githubusercontent.com/.../{branch}/...`

**Single Source of Truth:** Fetch workflows/assignments from remote. No local mirrors.

## Key Workflows

**Orchestrator:** Resolve → Compile context → Extract criteria → Execute → Run Report

**Change Flow:** Context → Plan → Diff → Confirm → Apply/validate → Report

## Validation

`dotnet build` → `dotnet test` → Docker build (if changed) → Lint

## Constraints

**Do NOT:** Large refactors without approval, speculative features, skip validation, use local mirrors

**Always:** Fetch from remote, smallest changes, resolution trace, map reports to criteria
