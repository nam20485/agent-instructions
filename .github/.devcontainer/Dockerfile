# AI Agent Instructions Development Environment
# This Dockerfile replicates all the tools from the GitHub Actions workflow
# for a consistent development environment

# Use the official .NET devcontainer base image
FROM mcr.microsoft.com/devcontainers/dotnet:1.3.7-9.0-bookworm-slim

# Configure environment for optimal .NET development
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
ENV DOTNET_NOLOGO=1
ENV ASPNETCORE_ENVIRONMENT=Development

# Switch to root for installations
USER root

# =============================================================================
# SYSTEM PACKAGES & DEPENDENCIES
# =============================================================================

RUN apt-get update && apt-get install -y \
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
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# PYTHON DEVELOPMENT
# =============================================================================

# Set up Python 3 as default python and install latest pip
RUN ln -sf /usr/bin/python3 /usr/bin/python \
    && python -m pip install --upgrade pip --break-system-packages

# =============================================================================
# NODE.JS & JAVASCRIPT DEVELOPMENT
# =============================================================================

# Install Node.js 22.x from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# POWERSHELL CORE INSTALLATION
# =============================================================================

# Install PowerShell Core from Microsoft repository
RUN wget -q "https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb" \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell \
    && rm packages-microsoft-prod.deb \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# CLOUD DEVELOPMENT TOOLS
# =============================================================================

# Install Google Cloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && apt-get update \
    && apt-get install -y google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# INFRASTRUCTURE TOOLS
# =============================================================================

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y terraform \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# AI DEVELOPMENT TOOLS
# =============================================================================

# Install Gemini CLI (latest preview)
# RUN curl -o gemini-cli.tar.gz https://ai.google.dev/gemini-api/docs/downloads/cli/gemini-cli-linux-amd64.tar.gz \
#     && tar -xzf gemini-cli.tar.gz \
#     && chmod +x gemini \
#     && mv gemini /usr/local/bin/ \
#     && rm gemini-cli.tar.gz

#RUN npm install -g @google/gemini-cli
# Install nvm for the current user (no sudo required)
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Add nvm to PATH and install Node.js LTS
RUN export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
    && nvm install --lts \
    && nvm use --lts

ENV NVM_DIR=/root/.nvm
ENV PATH="$NVM_DIR/versions/node/$(ls $NVM_DIR/versions/node)/bin/:$PATH"

# =============================================================================
# .NET WORKLOADS & TOOLS
# =============================================================================

# Install .NET WebAssembly workloads for Blazor development as root
RUN dotnet workload update \
    && dotnet workload install wasm-tools

RUN dotnet new install Aspire.ProjectTemplates

# Switch to vscode user for remaining operations
#USER vscode

# =============================================================================
# GLOBAL NPM PACKAGES
# =============================================================================

# Install Firebase CLI
RUN npm install -g firebase-tools
# and other global npm packages
RUN npm install -g \
    @angular/cli \
    create-react-app \
    typescript \
    eslint \
    prettier

# =============================================================================
# DEVELOPMENT ENVIRONMENT SETUP
# =============================================================================

# Switch back to root for final setup
#USER root

# Create development directories
RUN mkdir -p /workspace \
    && chown -R vscode:vscode /workspace

# Set working directory
WORKDIR /workspace

# Switch back to vscode user
#USER vscode

# =============================================================================
# VALIDATION & INFORMATION
# =============================================================================

# Create a script to display environment information
RUN echo '#!/bin/bash' > /home/vscode/show-env.sh \
    && echo 'echo "=== AI Agent Instructions Development Environment ==="' >> /home/vscode/show-env.sh \
    && echo 'echo "Core Development Stack:"' >> /home/vscode/show-env.sh \
    && echo 'echo "- .NET SDK: $(dotnet --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Node.js: $(node --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- npm: $(npm --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Python: $(python --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- PowerShell: $(pwsh --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo ""' >> /home/vscode/show-env.sh \
    && echo 'echo "Cloud & DevOps Tools:"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Google Cloud CLI: $(gcloud version --format=\"value(Google Cloud SDK)\" 2>/dev/null || echo \"Not authenticated\")"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Firebase CLI: $(firebase --version)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- GitHub CLI: $(gh --version | head -1)"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Terraform: $(terraform --version | head -1)"' >> /home/vscode/show-env.sh \
    && echo 'echo ""' >> /home/vscode/show-env.sh \
    && echo 'echo "AI Development Tools:"' >> /home/vscode/show-env.sh \
    && echo 'echo "- Gemini CLI: $(gemini --version 2>/dev/null || echo \"Available\")"' >> /home/vscode/show-env.sh \
    && echo 'echo ""' >> /home/vscode/show-env.sh \
    && echo 'echo "Ready for ASP.NET Core + Blazor + AI + Google Cloud development!"' >> /home/vscode/show-env.sh \
    && chmod +x /home/vscode/show-env.sh

# Set the default shell to PowerShell for the vscode user
RUN echo 'exec pwsh' >> /home/vscode/.bashrc

# Set default working directory
WORKDIR /workspaces/agent-instructions
