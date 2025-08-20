scripts/setup-environment.sh (Linux / WSL / devcontainer)
------------------------------------------------------

What it does
- Installs minimal system packages used by development and CI (git, python3, build tools, curl, jq, tree, htop, etc.).
- Installs NVM and pins Node.js from `.nvmrc` or `NODE_VERSION_PIN`.
- Enables Corepack and prepares pnpm/yarn when possible (reads `package.json` packageManager field or PNPM/YARN version pins).
- Installs optional developer tooling: Playwright (and browsers), Google Cloud CLI, GitHub CLI, Terraform, Ansible, global npm CLIs and .NET SDK workloads.

Run it
```bash
bash scripts/setup-environment.sh
```

Quick minimal run (skip large optional installs such as Playwright browsers):

```bash
SETUP_MINIMAL=1 bash scripts/setup-environment.sh
```

Verification
```bash
/tmp/show-env.sh
# or check individually
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
```

Notes & troubleshooting
- Node pinning: the script prefers `NODE_VERSION_PIN` then `.nvmrc` in repository root. This repo includes `.nvmrc` pinned to `22.18.0`.
- Corepack/pnpm: The script will try to enable Corepack and prepare pnpm/yarn. If pnpm is not available, set `PNPM_VERSION_PIN` or add `"packageManager": "pnpm@<version>"` to `package.json`.
- If `nvm` isn't found after install, re-open your shell or source it:

```bash
. $HOME/.nvm/nvm.sh
nvm use
```

- For permission errors on Linux run the script with sudo (the script auto-uses `sudo` when available for system package installs).
- On Windows use `scripts/setup-environment.ps1` with an elevated PowerShell session when necessary.

Using `.env.tools` (repo-level pins)
-----------------------------------

The repository supports a canonical `.env.tools` file at the repo root that contains exact, patch-level pins for tools used by the setup scripts. The setup scripts will load this file early and export the variables so installs are deterministic.

Examples of keys the scripts look for:
- `NODE_VERSION_PIN` — exact Node.js version (e.g., `22.18.0`)
- `NPM_VERSION_PIN` — optional exact npm version
- `PNPM_VERSION_PIN`, `YARN_VERSION_PIN` — versions Corepack will prepare
- `DOTNET_VERSION_PIN`, `DOTNET_CHANNEL`, `DOTNET_QUALITY` — for `dotnet-install` behavior

You can either commit a canonical `.env.tools` file (recommended for reproducibility) or commit `.env.tools.example` and have developers copy it to `.env.tools` locally. See the repo root `.env.tools` for the current pinned values.

Why is `uv` marked optional?
--------------------------------
The `uv` tool (https://astral.sh/uv/) is a small Python-based helper/dependency manager the scripts may install into the user's local bin. It's marked optional for a few reasons:

- `uv` is not required for the core language runtimes (Node, .NET, Python) or essential cloud CLIs; it's a convenience tool that some workflows use to manage small package installs.
- `uv` installation can be skipped for minimal or CI-focused setups to save time and avoid adding extra user-local binaries when they are unnecessary. Set `SETUP_MINIMAL=1` to skip it.
- The installer is a single-file script that may fail on very locked-down environments; leaving it optional prevents the whole setup from failing in those cases.

If you want `uv` always installed, remove the `SETUP_MINIMAL` guard or ensure `SETUP_MINIMAL` is not set in your environment. The script installs `uv` into `$HOME/.local/bin` when enabled.

If you'd like I can make `uv` a required install by default (i.e., remove the `SETUP_MINIMAL` guard), but I left it optional to keep quick bootstraps small and predictable.

Windows entrypoint
- Run the PowerShell script for Windows (winget/choco paths are used when available):

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/setup-environment.ps1
```
