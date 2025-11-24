---
description: Guide for local environment setup, shell detection, and tool installation.
scope: local-environment
prerequisites: ai-development-environment-guide.md
---
# Local Environment

<xml>
<instructions role="dev-environment" scope="local-environment">

<shells>
## Shells
**IMPORTANT:** Detect shell before running commands.

### Detection
- **Check:** `echo $SHELL` or `ps -p $$`.
- **PowerShell:** `if ($PSVersionTable) { "PowerShell" }`.

### Behavior
- **PowerShell (pwsh):** Use cmdlets.
- **Bash/Zsh:** Use POSIX syntax.
- **Cmd:** Use Windows syntax.
</shells>

<setup_script>
## `setup-environment.sh` Script

### Overview
Bootstraps reproducible dev environment (Linux/Windows).
- **Installs:** git, python3, build tools.
- **Node:** Pinned via `NODE_VERSION_PIN` or `.nvmrc` (NVM).
- **Package Managers:** npm, pnpm, yarn (Corepack).
- **CLIs:** Playwright, gcloud, gh, terraform, ansible.
- **.NET:** SDK 10/9 (user-local), workloads (`wasm-tools`).

### Usage

**Linux / WSL / Devcontainer:**
```bash
bash scripts/setup-environment.sh
# Minimal: SETUP_MINIMAL=1 bash scripts/setup-environment.sh
```

**Windows (PowerShell):**
```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
```

### Verification
```bash
node -v; npm -v; python --version; pwsh -v; gh --version; dotnet --version
/tmp/show-env.sh # Linux summary
```

### Configuration
- **Node:** `.nvmrc` or `NODE_VERSION_PIN`.
- **Managers:** `package.json` (`packageManager`) or `PNPM_VERSION_PIN`.
- **.NET:** `global.json` (ignored by script to avoid conflicts).

### Troubleshooting
- **NVM:** Source `$NVM_DIR/nvm.sh`.
- **Corepack:** `corepack enable`.
- **.NET:** Check `~/.dotnet`.
- **Permissions:** Script uses `sudo` where needed.
</setup_script>

</instructions>
</xml>

