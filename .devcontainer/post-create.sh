#!/bin/bash

# Post-create script for AI Agent Instructions development environment
# This script runs after the devcontainer is created

echo "🚀 Setting up AI Agent Instructions development environment..."

# Ensure we're in the correct directory
cd /workspaces/agent-instructions

# Display environment information
if [ -f "/home/vscode/show-env.sh" ]; then
    echo ""
    /home/vscode/show-env.sh
fi

# Initialize git configuration if not already set
if [ ! -f "/home/vscode/.gitconfig" ]; then
    echo ""
    echo "Setting up git configuration..."
    git config --global init.defaultBranch main
    git config --global core.autocrlf input
    git config --global pull.rebase false
fi

# Install any project-specific dependencies if package.json exists
if [ -f "package.json" ]; then
    echo ""
    echo "Installing npm dependencies..."
    npm install
fi

# Restore .NET dependencies if solution/project files exist
if ls *.sln 1> /dev/null 2>&1; then
    echo ""
    echo "Restoring .NET solution dependencies..."
    dotnet restore *.sln
elif ls *.csproj 1> /dev/null 2>&1; then
    echo ""
    echo "Restoring .NET project dependencies..."
    find . -name "*.csproj" -exec dotnet restore {} \;
fi

# Make local scripts executable
if [ -d "scripts" ]; then
    echo ""
    echo "Making local scripts executable..."
    chmod +x scripts/*.ps1
    chmod +x scripts/*.sh 2>/dev/null || true
fi

# Validate the environment using local scripts if available
if [ -f "scripts/validate-local-environment.ps1" ]; then
    echo ""
    echo "Validating development environment..."
    pwsh -File scripts/validate-local-environment.ps1
fi

echo ""
echo "✅ Development environment setup complete!"
echo "💡 Use 'show-env.sh' to display environment information anytime."
echo "🔧 All development tools are ready for ASP.NET Core + Blazor + Google Cloud development!"
