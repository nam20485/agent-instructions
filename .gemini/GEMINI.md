# GEMINI.md

This file provides guidance to Gemini agents when working with code in this repository.

## Configuration

**Branch:** MUST be read from [`../.github/copilot-instructions.md`](../.github/copilot-instructions.md) → `<configuration><branch>`. MUST NOT be hardcoded elsewhere.

All remote URLs in this document use the branch configured in `../.github/copilot-instructions.md`. Replace `{branch}` placeholders with that value.

## Repository Overview

This repository contains a comprehensive AI instruction framework designed for orchestrating AI agents (Claude, Copilot, Gemini, etc.) through complex software development workflows. The framework provides modular instructions, dynamic workflows, and role-based execution patterns.

**Key Capabilities:**
- Modular AI instruction system for reusable agent behaviors
- Dynamic workflow orchestration using a custom DSL (Domain Specific Language)
- Role-based agent execution (Orchestrator/Collaborator patterns)
- Assignment-based workflow definitions with acceptance criteria
- Integration with GitHub Copilot instructions

## Development Commands

### PowerShell Scripts (Windows)
Located in `scripts/` directory:
- `setup-environment.ps1` - Environment setup
- `init-repo.ps1` - Repository initialization
- `import-labels.ps1` - Import GitHub labels
- `create-milestones.ps1` - Create project milestones
- `query.ps1` - Query utilities

## Architecture

### 1. AI Instruction Modules System

The repository uses a hierarchical instruction system located in `ai_instruction_modules/`:

**Core Instructions (REQUIRED - always read):**
- `ai-core-instructions.md` - Base behaviors, validation, change flow
- `ai-executive-summary.md` - High-level development processes
- `ai-personal-preferences.md` - User preferences
- `ai-workflow-config.md` - Workflow configuration
- `ai-local-environment.md` - Local environment setup

**Optional Instructions (context-dependent):**
- `ai-terminal-management.md` - Terminal command handling
- `ai-testing-validation.md` - Test and validation processes
- `ai-application-guidelines.md` - Application development patterns
- `ai-instructions-aspnet-guidelines.md` - ASP.NET Core specifics
- `ai-design-principles.md` - SOLID, 12-Factor, DDD principles
- `ai-powershell-instructions.md` - PowerShell scripting

### 2. Workflow Architecture

#### Workflow Roles (`ai_instruction_modules/ai-workflow-roles/`)
- **Orchestrator** - Directs and coordinates team of collaborator agents
- **Collaborator** - Executes assigned tasks under orchestrator direction

Role definitions: `ai_instruction_modules/ai-workflow-roles/<role_name>/ai-workflow-role.md`

#### Workflow Assignments (`ai_instruction_modules/ai-workflow-assignments/`)
Structured task definitions with:
- **Title & Short ID** - Unique identifier (kebab-case)
- **Goal** - What to achieve
- **Acceptance Criteria** - Definition of Done
- **Detailed Steps** - Step-by-step execution guide

**Available Assignments:**
- `orchestrate-new-project.md` - End-to-end project initialization
- `create-app-plan.md` - Application planning
- `create-application.md` - App creation from template
- `create-project-structure.md` - Scaffolding setup
- `perform-task.md` - Task execution
- `pr-approval-and-merge.md` - PR approval workflow
- `pr-review-comments.md` - PR comment resolution
- `analyze-plan-issue.md` - Plan analysis and validation
- `orchestrate-dynamic-workflow.md` - Dynamic workflow orchestration

### 3. Dynamic Workflow System

**Location:** `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/`

#### Dynamic Workflow DSL
Custom scripting language for defining agent workflows:

**Core Syntax:**
```markdown
### step-name (kebab-case)
$variable = value
const $CONSTANT: value
$assignments = [assignment-id-1, assignment-id-2]

For each $item in $list, you will:
  - assign the agent the '$assignment-id' assignment with input $variable
  - wait until the agent finishes the task
  - review the work and approve it
  - record output as #step.substep

if $variable is true:
  - conditional actions
```

**Key Features:**
- Variable definitions: `$variable` or `${variable}`
- Constants: `const $CONSTANT: value`
- Step references: `#step` or `#step.substep`
- Lists: `[item1, item2]`
- Object properties: `$object->property`
- Control flow: `For each`, `if`/`is true`/`is false`

**Documentation:** `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md`

### 4. Agent Script Engine

**Purpose:** Extends AI agent capabilities through declarative scripting without implementation

**Structure:**
```markdown
## Inputs
- parameter: type - description

## Declarations
function functionName(param: type): returnType

## Script
result = functionName(param)
```

**Execution Modes:**
- **JIT (Just-In-Time)** - Line-by-line interpretation
- **AOT (Ahead-Of-Time)** - Pre-compilation with optimization

**Documentation:** `ai_instruction_modules/ai-agent-script-engine.md`

### 5. Remote Repository Integration

**Canonical Source:** `nam20485/agent-instructions` repository on GitHub

**URL Translation Pattern:**
```
GitHub UI: https://github.com/nam20485/agent-instructions/blob/{branch}/<file-path>
Raw URL:   https://raw.githubusercontent.com/nam20485/agent-instructions/{branch}/<file-path>
```

Replace `{branch}` with the branch configured in [`../.github/copilot-instructions.md`](../.github/copilot-instructions.md) → `<configuration><branch>` (fallback: `main` only if unavailable).

**Single Source of Truth:**
- Dynamic workflows and assignments MUST be fetched from remote canonical repository
- Local mirrors/caches must not be used for deriving steps or acceptance criteria
- Changes take effect immediately on fetch

## Key Workflows

### Orchestrator Pattern
1. Read assignment file from canonical source
2. Compile context for delegation
3. Extract and enforce Acceptance Criteria as Definition of Done
4. Print resolution trace
5. Produce Run Report mapped to Acceptance Criteria

### Assignment Execution
1. Resolution trace (print files + URLs/SHAs)
2. Execute steps from resolved assignment file only
3. Gate on Acceptance Criteria (Definition of Done)
4. Respect branch protection (feature branch + PR for protected branches)
5. Produce Run Report with evidence

### Change Flow (from core instructions)
1. **Context gather** - Search/read relevant files
2. **Plan** - Bullet-point implementation plan
3. **Diff proposals** - Present changes
4. **Confirm** - Get approval
5. **Apply & validate** - Build/test validation
6. **Report** - Status (PASS/FAIL) + next steps

## Validation Requirements

**Minimum Validation:**
- `dotnet build` (clean build)
- `dotnet test` (affected/new tests)
- Docker build (if container artifacts changed)
- Lint/static analysis (if configured)

## Branch Strategy

- **Branch:** MUST be read from [`../.github/copilot-instructions.md`](../.github/copilot-instructions.md) → `<configuration><branch>`.
- **MUST NOT:** Do not hardcode branch values in entrypoints.
- **Common conventions:** `main` and `development` may exist, but agents must follow the configured branch.

## Important Constraints

**Do NOT:**
- Make large refactors or add major dependencies without approval
- Add speculative features outside scope
- Skip validation steps
- Change more code than strictly necessary
- Use local mirrors for dynamic workflows or assignments

**Always:**
- Fetch dynamic workflows/assignments from remote canonical repository
- Make smallest, least risky code changes
- Provide resolution trace before executing workflows
- Map Run Reports 1:1 to Acceptance Criteria
- Use sequential-thinking and memory tools for every request
