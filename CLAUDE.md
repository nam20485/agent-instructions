# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains AI instruction modules for agents (Copilot, Claude, MCP) and cross-platform environment provisioning scripts. No application source code or tests are present - this is a tooling and instruction repository.

## Common Commands

### Environment Setup
```bash
# Quick setup/validation (Windows)
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/quick-setup.ps1

# Full environment provisioning (Windows)
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1

# Full environment provisioning (Linux/macOS)
bash scripts/setup-environment.sh

# Minimal setup (skip large optional installs)
SETUP_MINIMAL=1 bash scripts/setup-environment.sh
```

### Workflow Orchestration
```bash
# Test orchestration (dry run)
npm run orchestrate:dry

# Test orchestration with file input  
npm run orchestrate:dry:file

# Environment validation
npm run env:summary
```

### Version Verification
```bash
node --version    # Should be 22.18.0 (pinned in .nvmrc)
dotnet --version  # Should be 9.0.102 (pinned in global.json)
```

## High-Level Architecture

### Core Purpose
Modular instruction system for AI agents with deterministic cross-platform toolchain provisioning for .NET 9, ASP.NET Core, Blazor WASM, Docker, and GCP development contexts.

### Key Directories
- **ai_instruction_modules/**: Core instruction modules with hierarchical conflict resolution
  - Core instructions in `ai-core-instructions.md` (always required)
  - Workflow assignments under `ai-workflow-assignments/`
  - Dynamic workflows under `ai-workflow-assignments/dynamic-workflows/`
  - Role-based instructions for orchestrator/collaborator patterns
- **scripts/**: Cross-platform provisioning utilities with exact version pinning
- **.github/**: Devcontainer definition, workflows, and Copilot instruction entry point

### Technology Stack Pins
- .NET SDK: 9.0.102 with WebAssembly workloads (global.json)
- Node.js: 22.18.0 (.nvmrc)
- Package manager: pnpm@8.11.0 (package.json)
- Target stack: ASP.NET Core, Blazor WASM, Docker, GCP

### AI Instruction Hierarchy
Per `.github/copilot-instructions.md`, agents must:
1. Start with `ai_instruction_modules/ai-core-instructions.md` (REQUIRED)
2. Follow links to additional modules based on workflow assignments and roles
3. Resolve conflicts using: User request → Executive Summary → Tech guidelines → Design principles → Workflow assignments

### Dynamic Workflow System
- Workflows defined in markdown under `dynamic-workflows/`
- Orchestration via Node.js scripts with dry-run capabilities
- VS Code tasks provide orchestration entry points with parameterized inputs
- Remote canonical repository pattern for workflow definitions

### Environment Provisioning Flow
1. Scripts detect platform and use appropriate package managers (winget/choco/apt)
2. Install NVM and pin Node.js version from .nvmrc
3. Enable Corepack for deterministic pnpm/yarn versions  
4. Install .NET SDK with WebAssembly workloads
5. Install development tools: GitHub CLI, Google Cloud CLI, Terraform, Playwright

This repository serves as a foundation for AI-assisted development with reproducible tooling across local, CI, and devcontainer environments.