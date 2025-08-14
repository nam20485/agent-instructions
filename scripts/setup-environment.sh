#!/usr/bin/env bash
# Canonical environment setup (Linux)
# See: .github/workflows/copilot-setup-steps.yml

set -euo pipefail

echo "=== Starting environment setup (Dockerfile -> shell script) ==="

# -----------------------------------------------------------------------------
# Environment variables equivalent to Dockerfile ENV lines
# -----------------------------------------------------------------------------
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_NOLOGO=1
export ASPNETCORE_ENVIRONMENT=Development
export DEBIAN_FRONTEND=noninteractive

# Detect sudo availability (GitHub runners have it by default)
if command -v sudo >/dev/null 2>&1; then
	SUDO="sudo"
else
	SUDO=""
fi

# -----------------------------------------------------------------------------
# Node.js: NVM everywhere with exact version pinning (required)
# - Reads exact version from .nvmrc or NODE_VERSION_PIN (e.g., 22.18.0)
# - Exits with error if no exact version provided to ensure determinism
# - npm stays pinned to the version bundled with Node, unless NPM_VERSION_PIN is set
# -----------------------------------------------------------------------------
install_node_via_nvm() {
	# Install NVM if missing
	export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
	if [ ! -s "$NVM_DIR/nvm.sh" ]; then
		echo "[nvm] Installing NVM to $NVM_DIR"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	fi
	# shellcheck disable=SC1090
	. "$NVM_DIR/nvm.sh"

	# Choose desired version: from NODE_VERSION_PIN, or .nvmrc, else fallback to lts/* (not truly pinned)
	if [ -n "${NODE_VERSION_PIN:-}" ]; then
		DESIRED_NODE_VERSION="$NODE_VERSION_PIN"
	elif [ -f .nvmrc ]; then
		DESIRED_NODE_VERSION="$(cat .nvmrc)"
	else
		echo "ERROR: No exact Node version specified. Set NODE_VERSION_PIN or add .nvmrc. Expected format: e.g., '22.18.0'" >&2
		exit 1
	fi
	echo "[nvm] Ensuring Node $DESIRED_NODE_VERSION"
	nvm install "$DESIRED_NODE_VERSION" --no-progress
	nvm alias default "$DESIRED_NODE_VERSION"
	nvm use default

	# npm pinning: if NPM_VERSION_PIN is set, install that exact version; otherwise keep the bundled one
	if [ -n "${NPM_VERSION_PIN:-}" ]; then
		npm install -g --no-audit --no-fund "npm@${NPM_VERSION_PIN}" || true
	fi
}

echo "[1/12] Installing base system packages"
$SUDO apt-get update -y
$SUDO apt-get install -y --no-install-recommends \
	build-essential \
	apt-transport-https \
	ca-certificates \
	gnupg \
	curl \
	wget \
	unzip \
	git \
	vim \
	nano \
	jq \
	tree \
	htop \
	python3 \
	python3-pip \
	python3-venv \
	software-properties-common \
	lsb-release

echo "[2/12] Ensuring 'python' points to python3"
if [ ! -e /usr/bin/python ]; then
	$SUDO ln -sf /usr/bin/python3 /usr/bin/python
fi

echo "[3/12] Installing Node.js via NVM (exact pin)"
install_node_via_nvm
echo "[4/12] NVM installed and active"

echo "[5/12] Enabling Corepack (pnpm & yarn) deterministically"
if command -v corepack >/dev/null 2>&1; then
    corepack enable || true
    # Determine pnpm version: PNPM_VERSION_PIN > package.json packageManager field > package.json pnpm field
    PNPM_VER=""
    if [ -n "${PNPM_VERSION_PIN:-}" ]; then
        PNPM_VER="$PNPM_VERSION_PIN"
    elif [ -f package.json ]; then
        PM_FIELD=$(grep -o '"packageManager"[^\n]*' package.json || true)
        if echo "$PM_FIELD" | grep -q 'pnpm@'; then
            PNPM_VER=$(echo "$PM_FIELD" | sed -E 's/.*"packageManager" *: *"pnpm@([^"]+)".*/\1/')
        else
            PNPM_VER=$(grep -o '"pnpm" *: *"[^"]*"' package.json | sed -E 's/.*"pnpm" *: *"([^"]+)".*/\1/' || true)
        fi
    fi
    if [ -n "$PNPM_VER" ]; then
        corepack prepare "pnpm@$PNPM_VER" --activate || true
    else
        echo "pnpm version not specified; skipping pnpm activation (set PNPM_VERSION_PIN or packageManager)." >&2
    fi

    # Determine yarn version: YARN_VERSION_PIN > package.json packageManager field
    YARN_VER=""
    if [ -n "${YARN_VERSION_PIN:-}" ]; then
        YARN_VER="$YARN_VERSION_PIN"
    elif [ -f package.json ]; then
        PM_FIELD=$(grep -o '"packageManager"[^\n]*' package.json || true)
        if echo "$PM_FIELD" | grep -q 'yarn@'; then
            YARN_VER=$(echo "$PM_FIELD" | sed -E 's/.*"packageManager" *: *"yarn@([^"]+)".*/\1/')
        fi
    fi
    if [ -n "$YARN_VER" ]; then
        corepack prepare "yarn@$YARN_VER" --activate || true
    else
        echo "yarn version not specified; skipping yarn activation (set YARN_VERSION_PIN or packageManager)." >&2
    fi

    echo "Package managers:"
    (npm -v 2>/dev/null || true) | sed 's/^/ - npm /'
    (pnpm -v 2>/dev/null || true) | sed 's/^/ - pnpm /'
    (yarn -v 2>/dev/null || true) | sed 's/^/ - yarn /'
else
    echo "corepack not found; skipping pnpm/yarn activation" >&2
fi

echo "[6/12] Installing PowerShell"
if ! command -v pwsh >/dev/null 2>&1; then
	wget -q "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
	$SUDO dpkg -i packages-microsoft-prod.deb
	rm -f packages-microsoft-prod.deb
	$SUDO apt-get update -y
	$SUDO apt-get install -y --no-install-recommends powershell
fi

echo "[7/12] Installing Google Cloud CLI"
if ! command -v gcloud >/dev/null 2>&1; then
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | $SUDO tee /etc/apt/sources.list.d/google-cloud-sdk.list >/dev/null
	curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
	$SUDO apt-get update -y
	$SUDO apt-get install -y --no-install-recommends google-cloud-cli
fi

echo "[8/12] Installing GitHub CLI (gh)"
if ! command -v gh >/dev/null 2>&1; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | $SUDO dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	$SUDO chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | $SUDO tee /etc/apt/sources.list.d/github-cli.list >/dev/null
	$SUDO apt-get update -y
	$SUDO apt-get install -y --no-install-recommends gh
fi

echo "[9/12] Installing Terraform"
if ! command -v terraform >/dev/null 2>&1; then
	curl -fsSL https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
	$SUDO apt-get update -y
	$SUDO apt-get install -y --no-install-recommends terraform
fi

echo "[10/12] Installing Ansible"
if ! command -v ansible >/dev/null 2>&1; then
	$SUDO apt-get update -y
	$SUDO add-apt-repository --yes --update ppa:ansible/ansible
	$SUDO apt-get install -y --no-install-recommends ansible
fi

echo "[11/12] Installing global npm CLI tools (firebase-tools, angular, CRA, typescript, eslint, prettier, cdktf)"
# With NVM-managed Node, install globals without sudo to the user scope
npm install -g --no-audit --no-fund firebase-tools @angular/cli create-react-app typescript eslint prettier cdktf-cli

echo "[12/12] Ensuring .NET 9 SDK and workloads (wasm-tools, aspire)"
# If dotnet missing or major version < 9, install via dotnet-install script
if command -v dotnet >/dev/null 2>&1; then
	DOTNET_VER=$(dotnet --version || echo "0")
else
	DOTNET_VER="0"
fi
if ! echo "$DOTNET_VER" | grep -q '^9\.'; then
	echo "Installing .NET 9 SDK locally (dotnet-install script)"
	curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
	bash /tmp/dotnet-install.sh --channel 9.0 --install-dir "$HOME/.dotnet" --no-path
	export PATH="$HOME/.dotnet:$PATH"
fi
if command -v dotnet >/dev/null 2>&1; then
	set +e
	dotnet workload update || true
	dotnet workload install wasm-tools || true
	dotnet workload install aspire || true
	dotnet new install Aspire.ProjectTemplates || true
	set -e
else
	echo "dotnet not found on PATH; skipping workload installation (consider using actions/setup-dotnet)." >&2
fi

echo "Creating environment summary script (/tmp/show-env.sh)"
cat <<'EOF' >/tmp/show-env.sh
#!/usr/bin/env bash
echo "=== AI Agent Instructions Development Environment (Script Install) ==="
echo "Core Development Stack:"
echo "- .NET SDK: $(command -v dotnet >/dev/null 2>&1 && dotnet --version || echo 'Not Installed')"
echo "- Node.js: $(node --version 2>/dev/null || echo 'Not Installed')"
echo "- npm: $(npm --version 2>/dev/null || echo 'Not Installed')"
echo "- Python: $(python --version 2>/dev/null || echo 'Not Installed')"
echo "- PowerShell: $(pwsh --version 2>/dev/null || echo 'Not Installed')"
echo

echo "Cloud & DevOps Tools:"
echo "- Google Cloud CLI: $(gcloud version --format='value(Google Cloud SDK)' 2>/dev/null || echo 'Not Installed')"
echo "- Firebase CLI: $(firebase --version 2>/dev/null || echo 'Not Installed')"
echo "- GitHub CLI: $(gh --version 2>/dev/null | head -1 || echo 'Not Installed')"
echo "- Terraform: $(terraform --version 2>/dev/null | head -1 || echo 'Not Installed')"
echo "- Ansible: $(ansible --version 2>/dev/null | head -1 || echo 'Not Installed')"
echo "- CDKTF: $(cdktf --version 2>/dev/null || echo 'Not Installed')"
echo

echo "Ready for ASP.NET Core + Blazor + AI + Google Cloud development!"
EOF
chmod +x /tmp/show-env.sh

echo "Environment setup complete. Summary:"
/tmp/show-env.sh

echo "=== Finished environment setup ==="
