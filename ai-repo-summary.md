# Repository Summary

## Overview
This repository provides a curated set of AI agent instructions, workflows, and environment provisioning scripts to standardize how coding agents (and humans) work across projects. It includes:
- Core, required instruction modules for agent behavior and workflows.
- Optional instruction modules by role/task.
- Devcontainer prebuild artifacts and CI workflows for consistent environments.
- Cross‑platform scripts to provision and validate local environments.

Use this summary as your primary reference. Prefer these instructions over ad‑hoc searching; only search when information here is incomplete or proven incorrect.

## Instruction system
This repository follows and adheres to the modular `ai_instruction_modules` instruction system. Start with the core instructions and branch out as needed:
- Core (required): `${var:__current_repo_url}/blob/HEAD/ai_instruction_modules/ai-core-instructions.md`
- All modules: `${var:__current_repo_url}/tree/HEAD/ai_instruction_modules`

## High-level details
- Type: Documentation + tooling (Markdown, PowerShell, Bash, Devcontainer, GitHub Actions)
- Primary languages: Markdown, PowerShell (ps1), Shell (sh), JSON/JSONC, YAML (GitHub Actions)
- Runtimes and versions:
  - Node.js: pinned by .nvmrc to 22.18.0 (see `${var:__current_repo_url}/blob/HEAD/.nvmrc`)
  - .NET SDK: 9.0.102 (see `${var:__current_repo_url}/blob/HEAD/global.json`)
- Devcontainer: `.github/.devcontainer` with Dockerfile and settings (prebuilt via GHCR), see `${var:__current_repo_url}/tree/HEAD/.github/.devcontainer`
- Minimal `package.json` present to support caching/tooling; no app build artifacts.

## Build, validate, and run
This repo does not contain an application build; instead, it standardizes environment setup for agent work. Follow these steps to provision/validate locally. Heavy provisioning mirrors CI and may take time.

Preconditions
- Windows: PowerShell 7+, administrative privileges recommended.
- Linux: bash, sudo, curl/wget. Internet access required.

Bootstrap/Provision
- Windows (wrapper, mirrors CI/devcontainer setup):
  - PowerShell
    - pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
- Linux (wrapper, mirrors CI/devcontainer setup):
  - bash scripts/setup-environment.sh

Validate local environment
- PowerShell
  - .\scripts\validate-local-environment.ps1
  - Optional: add -Detailed or -OutputFormat Json|Markdown

Quick start (Windows)
- PowerShell
  - .\scripts\quick-setup.ps1
  - For validation only: .\scripts\quick-setup.ps1 -ValidateOnly

Notes and guarantees
- Always ensure Node is 22.18.0 (via .nvmrc) before running Node-based tools.
- .NET workloads for WebAssembly and Aspire are handled in the devcontainer image and CI; local installation is performed by scripts if needed.
- CI validates the Linux setup script on every push/PR; Windows validation is behind a repo variable flag.

CI/Validation Pipelines
- Prebuild devcontainer image: `${var:__current_repo_url}/blob/HEAD/.github/workflows/prebuild.yml`
- Copilot setup steps (provisions via Linux wrapper): `${var:__current_repo_url}/blob/HEAD/.github/workflows/copilot-setup-steps.yml`
- Validate setup scripts (Linux always; Windows gated): `${var:__current_repo_url}/blob/HEAD/.github/workflows/validate-setup-scripts.yml`

Expected timings
- First-time provisioning can be lengthy due to SDKs/CLIs (Node/.NET/Docker/Terraform/GCloud). Subsequent runs are faster due to caching.

Common failure modes and mitigations
- Permission/ExecutionPolicy (Windows): Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
- PATH not refreshed after tool installs: restart terminal or refresh PATH per scripts/README guidance.
- Determinism gates: workflows (and Windows script) will fail if neither .nvmrc nor NODE_VERSION_PIN is set.

## Project layout and key files
Repo root highlights
- Instruction modules: `ai_instruction_modules/` (required core + optional role/task modules)
- Scripts (env provisioning/validation): `scripts/`
- Devcontainer prebuild: `.github/.devcontainer/` (Dockerfile, devcontainer.json)
- GitHub workflows: `.github/workflows/`
- MCP servers config: `mcp.json`
- Node version pin: `.nvmrc` (22.18.0)
- .NET SDK pin: `global.json` (9.0.102)
- Copilot repo instructions pointer: `.github/copilot-instructions.md`

Key paths and references
- Core instructions (start here): `${var:__current_repo_url}/blob/HEAD/ai_instruction_modules/ai-core-instructions.md`
 - Workflow process types and roles: `${var:__current_repo_url}/tree/HEAD/ai_instruction_modules/ai-workflow-process-types` and `${var:__current_repo_url}/tree/HEAD/ai_instruction_modules/ai-workflow-roles`
- Environment scripts README: `${var:__current_repo_url}/blob/HEAD/scripts/README.md`
- Tasks for common operations: `${var:__current_repo_url}/blob/HEAD/tasks.json`

Devcontainer specifics
- Base image: .NET 9 devcontainer; adds Node 22.x, PowerShell 7, gcloud, gh, terraform, Firebase CLI.
- Default ports exposed include 5000/5001/8080/3000/4200 for common web frameworks.
- VS Code customizations include C#, PowerShell, GitHub extensions, and AI tooling.

## Checks before submitting changes
- If you modify environment scripts, ensure Linux wrapper remains executable and deterministic:
  - chmod +x scripts/setup-environment.sh
  - Ensure .nvmrc is present or export NODE_VERSION_PIN
- CI will execute `validate-linux` on PRs; ensure it passes.
- For Windows validation, set repo var ENABLE_WINDOWS_SETUP_VALIDATION to 'true' to run in CI.

## Agent guidance (trust these instructions)
- Use the wrappers scripts/setup-environment.ps1 or scripts/setup-environment.sh instead of re-implementing setup.
- Assume Node 22.18.0 and .NET 9.0.102 unless an explicit override is provided in the task.
- Prefer the devcontainer for deterministic tooling. The prebuilt image is published to GHCR by prebuild.yml.
- Only search the repo if this summary and linked files lack the needed detail. 

## Appendix: quick links
- Devcontainer folder: `${var:__current_repo_url}/tree/HEAD/.github/.devcontainer`
- Workflows: `${var:__current_repo_url}/tree/HEAD/.github/workflows`
- Scripts: `${var:__current_repo_url}/tree/HEAD/scripts`
- Instruction modules: `${var:__current_repo_url}/tree/HEAD/ai_instruction_modules`
