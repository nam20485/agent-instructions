#!/usr/bin/env bash
# Converted from .github/.devcontainer/Dockerfile
# Purpose: Reproduce the devcontainer tooling environment directly on a GitHub Actions Ubuntu runner.
# Notes:
#  - Uses sudo where root privileges are required.
#  - Idempotent where practical (skips reinstall if tools already present).
#  - Safe flags: -e (exit on error), -u (undefined var), -o pipefail.

set -euo pipefail

echo "=== Starting environment setup (Dockerfile -> shell script) ==="

# -----------------------------------------------------------------------------
# Environment variables equivalent to Dockerfile ENV lines
# -----------------------------------------------------------------------------
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_NOLOGO=1
export ASPNETCORE_ENVIRONMENT=Development

# Detect sudo availability (GitHub runners have it by default)
if command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
else
  SUDO=""
fi

echo "[1/9] Installing base system packages"
$SUDO apt-get update -y
$SUDO apt-get install -y \
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
  python3-venv

echo "[2/9] Ensuring 'python' points to python3"
if [ ! -e /usr/bin/python ]; then
  $SUDO ln -sf /usr/bin/python3 /usr/bin/python
fi

echo "[3/9] Installing Node.js 22.x (NodeSource) + updating npm"
if ! command -v node >/dev/null 2>&1 || ! node -v | grep -q 'v22'; then
  curl -fsSL https://deb.nodesource.com/setup_22.x | $SUDO bash -
  $SUDO apt-get install -y nodejs
fi
$SUDO npm install -g npm@latest

echo "[4/9] Installing PowerShell"
if ! command -v pwsh >/dev/null 2>&1; then
  wget -q "https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
  $SUDO dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb
  $SUDO apt-get update -y
  $SUDO apt-get install -y powershell
fi

echo "[5/9] Installing Google Cloud CLI"
if ! command -v gcloud >/dev/null 2>&1; then
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | $SUDO tee /etc/apt/sources.list.d/google-cloud-sdk.list
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor | $SUDO tee /usr/share/keyrings/cloud.google.gpg >/dev/null
  $SUDO apt-get update -y
  $SUDO apt-get install -y google-cloud-cli
fi

echo "[6/9] Installing GitHub CLI (gh)"
if ! command -v gh >/dev/null 2>&1; then
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | $SUDO dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  $SUDO chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | $SUDO tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  $SUDO apt-get update -y
  $SUDO apt-get install -y gh
fi

echo "[7/9] Installing Terraform"
if ! command -v terraform >/dev/null 2>&1; then
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | $SUDO tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
  $SUDO apt-get update -y
  $SUDO apt-get install -y terraform
fi

echo "[8/9] Installing global npm CLI tools"
$SUDO npm install -g firebase-tools @angular/cli create-react-app typescript eslint prettier

echo "[9/9] (Optional) Installing .NET workloads (wasm-tools, aspire)"
if command -v dotnet >/dev/null 2>&1; then
  set +e
  dotnet workload update || true
  dotnet workload install wasm-tools || true
  dotnet workload install aspire || true
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
echo
echo "Ready for ASP.NET Core + Blazor + AI + Google Cloud development!"
EOF
chmod +x /tmp/show-env.sh

echo "Environment setup complete. Summary:"
/tmp/show-env.sh

echo "=== Finished environment setup ==="
