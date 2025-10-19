# Local Environment 

## Shells

### Windows
 
 On Windows and/or in VS Code your shell is typicall Powershell Core.

### WSL, Linux

 On Linux and/or in WSL your shell is typically bash.

### Devcontainer, Codespaces, and Copilot Agent Dev Environment

In a devcontainer, codespace, or when running in your agent dev environment, your shell is configured by running the `setup-environment.sh` script.
- You will have access to all of the tools and versions specified in the `setup-environment.sh` script
- See the `setup-environment.sh` Script section below for more information on the tools available there 

## `setup-environment.sh` Script

### Overview
This repository includes canonical environment setup scripts for Linux (bash) and Windows (PowerShell). The primary purpose of the scripts is to bootstrap a reproducible developer environment for working with the samples, templates, and agent instruction documents in this repo.

High-level behavior:
- Performs minimal system package installs required for development (git, python3, build tools, common utilities).
- Installs and pins Node.js via NVM (exact pin required from `NODE_VERSION_PIN` or `.nvmrc`).
- Optionally pins npm, pnpm, and yarn via environment variables or `package.json` metadata.
- Enables Corepack to activate `pnpm`/`yarn` deterministically when possible.
- Installs or prepares developer CLIs: Playwright (and browsers), Google Cloud CLI, GitHub CLI (`gh`), Terraform, Ansible, CDKTF and other useful global npm CLIs.
- Installs/ensures .NET SDK (user-local install via dotnet-install script) and updates/installs workloads such as `wasm-tools`.
- Writes a small environment summary script you can run to verify the main toolchain versions.

The Linux entrypoint is `scripts/setup-environment.sh` and the Windows entrypoint is `scripts/setup-environment.ps1`.

Note: a fast-path environment variable `SETUP_MINIMAL=1` is supported to skip optional/large installs (Playwright browsers, some CLIs) when you want a quicker bootstrap.

### Tools Installed and Versions
The script installs, enables, or verifies the presence of the following tools (where applicable). Many items are installed in user scope (NVM-managed Node, `dotnet` user-local install) so they do not require global admin rights, but some installers may require sudo/administrative privileges.

- Node.js (via NVM) — exact version must be provided with `NODE_VERSION_PIN` or a `.nvmrc` file (example pin: `22.18.0`). The script sets the installed version as the default in NVM.
- npm — default bundled with Node unless `NPM_VERSION_PIN` is supplied, in which case the script installs that exact npm globally for the user.
- Corepack (pnpm & yarn) — enabled when present; `PNPM_VERSION_PIN` and `YARN_VERSION_PIN` are supported or the `package.json` `packageManager` field is used when present.
- uv (astral/uv) — optional Python-based dependency/tool manager installed to the user's local bin when not already present.
- Playwright CLI + browsers (chromium, firefox, webkit) — installed via `npx playwright@latest install --with-deps` unless `SETUP_MINIMAL=1`.
- PowerShell (`pwsh`) — installed on Linux when missing (skipped by `SETUP_MINIMAL`).
- Google Cloud CLI (`gcloud`) — installed via package repositories on Linux or via `winget/choco` on Windows (skipped by `SETUP_MINIMAL`).
- GitHub CLI (`gh`) — installed via package repositories on Linux or via `winget/choco` on Windows (skipped by `SETUP_MINIMAL`).
- Terraform — installed via the HashiCorp repository on Linux or via `winget/choco` on Windows (skipped by `SETUP_MINIMAL`).
- Ansible — installed via apt/pip on Linux, or pip (user) on Windows; the script recommends WSL for full Ansible experience.
- Global npm CLIs — firebase-tools, @angular/cli, create-react-app, typescript, eslint, prettier, cdktf-cli (installed in user global scope via `npm install -g` unless `SETUP_MINIMAL=1`).
- .NET SDK — the script ensures a .NET 10 (preview) SDK is present on Linux (or .NET 9 on Windows script) using the official dotnet-install scripts; workloads such as `wasm-tools` are installed/updated.

Where versions are pinned or configurable
- NODE_VERSION_PIN — exact Node version to install (preferred; e.g., `22.18.0`) or use an `.nvmrc` file.
- NPM_VERSION_PIN — optional exact npm version to install globally.
- PNPM_VERSION_PIN, YARN_VERSION_PIN — pin versions for Corepack activation.
- DOTNET_VERSION_PIN — optional exact dotnet SDK version for dotnet-install script.
- DOTNET_CHANNEL, DOTNET_QUALITY — alternate knobs for the dotnet installer (e.g., channel `10.0`, quality `preview`).

How the script is structured (Linux `setup-environment.sh`):

1. Install base system packages (build-essential, curl, git, python3, pip, jq, tree, htop, etc.).
2. Ensure `python` points to `python3`.
3. Install NVM and the pinned Node.js version.
4. Optionally enable Corepack and prepare `pnpm`/`yarn` based on pins or package.json.
5. Install `uv` (if not present) to the user's local bin.
6. Install Playwright CLI and browsers (unless `SETUP_MINIMAL=1`).
7. Install PowerShell (if missing and not `SETUP_MINIMAL`).
8. Install cloud/devops CLIs (gcloud, gh, terraform) and tools (ansible) where possible.
9. Install global npm CLIs used across the repo.
10. Install .NET SDK (user-local) using `dotnet-install` if the required major version isn't present; then update/install workloads.

Verification / summary
- The Linux script writes `/tmp/show-env.sh` which prints the primary toolchain versions. Run it after setup to get a quick summary.

How to run
- On Linux / WSL / devcontainer:

```bash
bash scripts/setup-environment.sh
```

- On Windows (PowerShell):

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
```

If you want to do a quick, minimal setup (skip large optional installs):

```bash
SETUP_MINIMAL=1 bash scripts/setup-environment.sh
```
or on PowerShell (Windows):

```powershell
#$env:SETUP_MINIMAL = '1'
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
```

Quick verification commands (post-install)

```bash
node --version
npm --version
python --version
pwsh --version
gcloud --version
gh --version
terraform --version
ansible --version
dotnet --version
npx -y playwright@latest --version
/tmp/show-env.sh   # (Linux) prints a compact environment summary
```

Windows users will see a similar environment summary printed by the PowerShell script at the end of `scripts/setup-environment.ps1`.

Pinning and repo-level hints
- Use a `.nvmrc` file checked into the repo to pin Node for all contributors; the script will prefer `NODE_VERSION_PIN` then `.nvmrc`.
- Use `package.json`'s `packageManager` field (or explicit `PNPM_VERSION_PIN`/`YARN_VERSION_PIN`) to ensure reproducible pnpm/yarn activation via Corepack.
- If the repo contains a `global.json` with a .NET SDK pin, the script attempts to avoid being influenced by it by running `dotnet` commands from `/tmp` when updating workloads (the installer uses a user-local location).

Troubleshooting
- nvm not found after install: the script sources `$NVM_DIR/nvm.sh` on Linux and walks candidate locations on Windows. Reopen your shell or manually source NVM (`. $HOME/.nvm/nvm.sh`) and re-run the install step.
- corepack not present: install a newer Node or enable Corepack manually (`corepack enable`).
- dotnet workloads failing: check `~/.dotnet` (or `%USERPROFILE%\\.dotnet`) and ensure the install script completed; rerun `dotnet workload install wasm-tools` if needed.
- Permission errors: run the Linux script with sudo for system-level apt installs (the script auto-uses `sudo` when available). On Windows, prefer running with a package manager (winget/choco) available in the PATH or run an elevated PowerShell session where necessary.

If something in the script doesn't match your platform or environment, open an issue with the exact error output and the OS shell you used.


