# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Repository focus: AI instruction modules and reproducible dev environment tooling (no application source code or tests here). Use these commands and notes to provision tools and understand structure quickly.

Commonly used commands
- Quick environment setup/validation
  - Windows (PowerShell):
    - pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/quick-setup.ps1
    - Validation only: pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/quick-setup.ps1 -ValidateOnly
  - Linux/macOS (bash):
    - bash scripts/setup-environment.sh  # mirrors CI/devcontainer provisioning
- Full provisioning wrappers
  - Windows (PowerShell): pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
  - Linux (bash): bash scripts/setup-environment.sh
- Environment validation (see scripts/README.md for details)
  - The quick-setup script calls validate-local-environment.ps1 internally when present. Prefer quick-setup for consistency.
- Deterministic Node toolchain (NVM-based)
  - Pinned Node version: from .nvmrc (22.18.0) or override with env var
    - Windows example: $env:NODE_VERSION_PIN=“22.18.0”; pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
    - Linux example: NODE_VERSION_PIN=22.18.0 bash scripts/setup-environment.sh
  - Optional npm pin: NPM_VERSION_PIN. Corepack is enabled; set PNPM_VERSION_PIN or YARN_VERSION_PIN to activate specific versions.
- .NET SDK and workloads
  - Target SDK: 9.0.102 (global.json). Verify: dotnet --version
  - Workloads installed by setup scripts: wasm-tools, aspire; templates: Aspire.ProjectTemplates
- Devcontainer/CI parity
  - Devcontainer definition: .github/.devcontainer (Dockerfile + devcontainer.json). Prebuilt image published via .github/workflows/prebuild.yml.
  - Forwarded ports (devcontainer): 5000/5001/8080/3000/4200.

High-level architecture and structure
- Purpose: Modular instruction system for AI agents (Copilot, Claude, MCP) plus cross-platform scripts to provision a deterministic toolchain used locally, in CI, and in devcontainers.
- Key areas
  - ai_instruction_modules/: Core instruction set (application guidelines, tools config, workflows, roles). CHAT_INSTRUCTIONS contains provider-specific subsets.
  - scripts/: Cross-platform provisioning utilities
    - quick-setup.ps1: fast path that validates or delegates to full setup
    - setup-environment.ps1: canonical Windows provisioning (NVM with exact pin, cloud CLIs, Terraform, .NET workloads, global npm CLIs)
    - setup-environment.sh: canonical Linux provisioning used in CI; mirrors devcontainer steps
    - scripts/README.md: supported flags, requirements, troubleshooting
  - .github/:
    - .devcontainer/: reproducible development environment (Dockerfile installs Node/NVM, .NET workloads, cloud CLIs, terraform, global npm tools)
    - workflows/prebuild.yml: builds and publishes the devcontainer image on pushes to main/development
    - copilot-instructions.md: points Copilot to required core instructions
  - docs/CLAUDE.md: Claude-specific overview, tech stack and common commands reference
  - global.json: pins .NET SDK (9.0.102) and WebAssembly SDK version
  - .nvmrc: pins Node 22.18.0
  - mcp.json: declares MCP stdio servers (sequential-thinking, memory, filesystem with allowed root, and standard CLIs)
- Flow
  1) Use quick-setup or setup scripts to converge local tools to the pinned versions.
  2) Optional: open the repository in the devcontainer for identical tooling to CI.
  3) AI assistants read ai_instruction_modules/ and provider-specific files to drive development guidance across .NET, Blazor, Docker, and GCP contexts.

Copilot and Claude rules (essentials)
- Copilot: .github/copilot-instructions.md designates ai_instruction_modules/ai-core-instructions.md as REQUIRED and as the entry point to other modules.
- Claude: docs/CLAUDE.md summarizes the stack (.NET 9, ASP.NET Core, Blazor WASM, Docker, GCP), common commands, and MCP integration expectations.
- Cursor/Copilot additional rules: none detected beyond the above; prioritize provider files that are present in this repo.

Build, lint, and test
- This repository contains no .NET solution or application code. For downstream .NET repos, typical commands (from docs/CLAUDE.md) are:
  - dotnet restore
  - dotnet build
  - dotnet test
  - Run a single test class or method: dotnet test --filter FullyQualifiedName~Namespace.ClassName[.Method]
  - Publish: dotnet publish
- JavaScript tooling is provisioned but there are no package scripts beyond a trivial env:summary.

Notes for usage in CI/devcontainers
- The Linux setup script (scripts/setup-environment.sh) mirrors the Dev Container Dockerfile and the prebuild workflow to minimize drift.
- Environment variables allow overrides without editing files: NODE_VERSION_PIN, NPM_VERSION_PIN, PNPM_VERSION_PIN, YARN_VERSION_PIN.

