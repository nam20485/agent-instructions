# Development Environment Scripts

This directory contains PowerShell scripts for setting up and validating the local development environment for ASP.NET Core + Blazor + Google Cloud development.

## Scripts Overview

### 🚀 [quick-setup.ps1](quick-setup.ps1)
**One-command setup for fast development environment initialization**

```powershell
# Quick setup and validation
.\quick-setup.ps1

# Validation only
.\quick-setup.ps1 -ValidateOnly

# Force reinstall
.\quick-setup.ps1 -Force
```

### 🔧 [setup-local-environment.ps1](setup-local-environment.ps1)
**Comprehensive development environment setup**

```powershell
# Full setup
.\setup-local-environment.ps1

# Skip validation
.\setup-local-environment.ps1 -SkipValidation

# Force reinstall all tools
.\setup-local-environment.ps1 -Force

# Windows: Skip Chocolatey installation
.\setup-local-environment.ps1 -SkipChocolatey
```

### ✅ [validate-local-environment.ps1](validate-local-environment.ps1)
**Environment validation and tool verification**

```powershell
# Basic validation
.\validate-local-environment.ps1

# Detailed version information
.\validate-local-environment.ps1 -Detailed

# Output formats
.\validate-local-environment.ps1 -OutputFormat Json
.\validate-local-environment.ps1 -OutputFormat Markdown
```

## Tools Installed & Validated

### Core Development Stack
- **.NET SDK 9.0.102** with WebAssembly workloads
- **Node.js 22.x** for frontend tooling
- **PowerShell Core 7.x** for scripting

### Cloud & DevOps Tools
- **Google Cloud CLI** for GCP deployment
- **Firebase CLI** for frontend hosting
- **GitHub CLI** for workflow management

### Container & Infrastructure
- **Docker** for containerization
- **Terraform** for infrastructure as code

## Platform Support

| Platform | Support Level | Package Manager |
|----------|---------------|-----------------|
| Windows  | ✅ Full       | Chocolatey, winget |
| Linux    | ✅ Full       | apt, curl |
| macOS    | ✅ Full       | Homebrew |

## Quick Start

1. **For new environments:**
   ```powershell
   .\quick-setup.ps1
   ```

2. **For existing environments:**
   ```powershell
   .\validate-local-environment.ps1
   ```

3. **For CI/CD validation:**
   ```powershell
   .\validate-local-environment.ps1 -OutputFormat Json
   ```

## Integration with GitHub Actions

These scripts mirror the [copilot-setup-steps.yml](../.github/workflows/copilot-setup-steps.yml) workflow to ensure consistency between local development and CI/CD environments.

## Requirements

- **PowerShell Core 7.0+** (the scripts will install this if missing)
- **Internet connection** for downloading installers
- **Administrative privileges** (recommended for system-wide installations)

### Platform-Specific Requirements

#### Windows
- **Chocolatey** (optional, auto-installed)
- **winget** (Windows 10/11 built-in)

#### Linux (Ubuntu/Debian)
- **curl, wget** (usually pre-installed)
- **sudo access**

#### macOS
- **Homebrew** (auto-installed if missing)
- **Xcode Command Line Tools**

## Error Handling

All scripts include comprehensive error handling and validation:

- **Fail-fast behavior** with clear error messages
- **Cross-platform compatibility** checks
- **Tool version validation** against expected versions
- **Detailed logging** for troubleshooting
- **Graceful degradation** for optional components

## Exit Codes

| Code | Meaning |
|------|---------|
| 0    | Success |
| 1    | Validation or installation failure |

## Troubleshooting

### Common Issues

1. **Permission denied errors:**
   ```powershell
   # Run as Administrator (Windows) or with sudo (Linux/macOS)
   ```

2. **PowerShell execution policy:**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. **Tool not found after installation:**
   ```powershell
   # Restart terminal or refresh PATH
   $env:PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [Environment]::GetEnvironmentVariable("PATH", "User")
   ```

### Logs and Debugging

Scripts provide verbose output during execution. For additional debugging:

```powershell
# Enable verbose output
.\setup-local-environment.ps1 -Verbose

# Check individual tool installations
Get-Command dotnet, node, docker, gcloud, firebase, gh, terraform
```

## Alignment with AI Instructions

These scripts implement the requirements from:
- [ai-application-guidelines.md](../ai_instruction_modules/ai-application-guidelines.md)
- [ai-tools-config.md](../ai_instruction_modules/ai-tools-config.md)
- [ai-testing-validation.md](../ai_instruction_modules/ai-testing-validation.md)
- [copilot-instructions.md](../.github/copilot-instructions.md)

## Contributing

When modifying scripts:
1. **Test on all supported platforms**
2. **Update version requirements** in script headers
3. **Maintain consistency** with GitHub Actions workflow
4. **Add comprehensive error handling**
5. **Update this documentation**

---

*These scripts ensure your local development environment matches the production GitHub Actions environment for consistent development experience.*
