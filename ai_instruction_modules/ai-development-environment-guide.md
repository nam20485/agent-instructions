---
description: Comprehensive guide for setting up development environments, managing terminals, and working with PowerShell.
scope: development-environment
prerequisites: ai-core-instructions.md
---
# AI Development Environment Guide

<xml>
<instructions role="dev-environment" scope="development-environment">

<purpose>
## Purpose
**Use when:** Setting up environments, managing terminals, writing PowerShell, or executing shell commands.
**Role:** DevOps engineers and developers.

## When to Use This Guide
- Setting up new environments (Local, Devcontainer)
- Managing terminal sessions and background processes
- Writing PowerShell scripts/cmdlets
- Executing GitHub CLI, Git, shell commands
- Troubleshooting config issues
</purpose>

<quick_reference>
## Quick Reference

### Environment Types
- **Local (Windows):** PowerShell Core (pwsh), winget/choco, Windows Terminal.
- **Local (Linux/WSL):** bash, apt/snap.
- **Devcontainer:** bash, pre-configured via `setup-environment.sh`.

### Core Tools & Versions
- **Runtimes:** Node.js (Pinned via NVM), .NET SDK 9.0+, Python 3.x.
- **Package Managers:** npm (pinned), pnpm/yarn (Corepack), NVM.
- **DevOps:** GitHub CLI (gh), Git, Terraform, Docker.

### Terminal Management
- **Default:** `run_in_terminal` (isBackground=false). Reuse session.
- **Background:** `isBackground=true` ONLY for servers/watchers.
- **Cleanup:** Always stop background processes before starting new ones.

### PowerShell Standards
- **Naming:** `Verb-Noun` (e.g., `Get-UserProfile`).
- **Params:** `[Parameter(Mandatory)]`, `[ValidateSet]`, `[switch]`.
- **Output:** Return `PSCustomObject`. No `Write-Host` for data.
- **Safety:** `SupportsShouldProcess`, `ConfirmImpact`.

## Canonical Reference Files

**[ai-local-environment.md](./ai-local-environment.md)**
- Shell config, setup script, tool installation, version pinning.

**[ai-terminal-management.md](./ai-terminal-management.md)**
- Session reuse, background processes, cleanup strategies.

**[ai-powershell-instructions.md](./ai-powershell-instructions.md)**
- Cmdlet development, naming, pipeline, error handling, Pester tests.

**[ai-working-command-examples.md](./ai-working-command-examples.md)**
- Validated commands for GitHub CLI, Git, PowerShell.

## Common Workflows

### Setting Up Environment
1. **Type:** Determine Local (Windows/Linux) or Devcontainer.
2. **Run:** `bash scripts/setup-environment.sh` (Linux) or `pwsh scripts/setup-environment.ps1` (Windows).
3. **Verify:** Check versions (`node -v`, `dotnet --version`, `gh --version`).
4. **Pin:** Set `NODE_VERSION_PIN`, `.nvmrc`, `global.json`.
5. **Auth:** `gh auth status`, `gcloud auth login`.

### Managing Terminals
- **Sequential:** Reuse terminal for build -> test -> deploy.
- **Background:** Use for `dotnet run`, `docker-compose up`, `npm run watch`.
- **Cleanup:** Find PID (`Get-Process`, `ps aux`), Kill (`Stop-Process`, `kill`).

### Writing PowerShell
- **Structure:** `CmdletBinding`, `param()`, `begin/process/end`.
- **Pipeline:** `ValueFromPipeline` for input.
- **Module:** `.psd1` manifest, `.psm1` root, `Public/Private` folders.

### GitHub CLI
- **Repo:** `gh repo create`, `gh repo clone`, `gh repo view`.
- **PR:** `git switch -c feature`, `git push`, `gh pr create`, `gh pr merge`.
- **Labels:** Import via script, verify with `gh api`.

### Version Pinning
- **Node:** `.nvmrc` ("22.18.0") or `NODE_VERSION_PIN`.
- **Package Manager:** `package.json` ("packageManager": "pnpm@8.15.0").
- **.NET:** `global.json` ("sdk": { "version": "9.0.102" }).

## Troubleshooting

### Setup Issues
- **NVM Missing:** Source `.nvm/nvm.sh` or reopen shell.
- **Corepack Missing:** `corepack enable` or upgrade Node.
- **.NET Fail:** Check `global.json`, install workload manually.

### Terminal Issues
- **Port In Use:** Find process (`netstat`/`lsof`) and kill it.
- **Resource Hog:** Kill old `pwsh` sessions.
- **Orphans:** Check for `defunct` processes.

### PowerShell Issues
- **No Confirm:** Check `ConfirmImpact` level.
- **No Pipeline:** Add `ValueFromPipeline` attribute.
- **No Export:** Check `Export-ModuleMember` or manifest.

## Examples

<see example="examples/dev-env-examples.md" />

## Summary

**Key Takeaways:**
- **Setup:** Use scripts, pin versions, verify installs.
- **Terminal:** Reuse sessions, manage background procs carefully.
- **PowerShell:** Follow standards, use Pester, support pipeline.
- **Tools:** Master `gh` CLI and Git workflows.

**References:**
- [ai-local-environment.md](./ai-local-environment.md)
- [ai-terminal-management.md](./ai-terminal-management.md)
- [ai-powershell-instructions.md](./ai-powershell-instructions.md)

</quick_reference>
</instructions>
</xml>
