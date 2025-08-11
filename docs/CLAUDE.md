# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is an AI instruction modules repository containing comprehensive guidance for AI agents working with ASP.NET Core, Blazor WebAssembly, and Google Cloud Platform applications. The repository serves as a modular instruction system for AI development workflows.

## Technology Stack & Architecture


### Core Technologies
- **.NET 9.0.102** (specified in global.json) with WebAssembly workloads
- **ASP.NET Core Web API** (full controllers, not minimal API)
- **Blazor WebAssembly** for frontend applications
- **Docker** for containerization
- **Google Cloud Platform** for deployment and cloud services
- **PowerShell Core 7.x** for scripting and automation

### Development Tools
- **MCP (Model Context Protocol)** servers for extended AI capabilities
- **GitHub CLI** (`gh`) for repository management
- **Google Cloud CLI** (`gcloud`) for GCP operations
- **Firebase CLI** for frontend hosting
- **Docker CLI** for container operations
- **Terraform** for infrastructure as code

## Development Environment Setup

### Quick Setup Commands
```powershell
# One-command environment setup
.\scripts\quick-setup.ps1

# Validation only
.\scripts\quick-setup.ps1 -ValidateOnly

# Full setup with force reinstall
.\scripts\setup-local-environment.ps1 -Force
```

### Environment Validation
```powershell
# Basic validation
.\scripts\validate-local-environment.ps1

# Detailed validation with version info
.\scripts\validate-local-environment.ps1 -Detailed

# JSON output for CI/CD
.\scripts\validate-local-environment.ps1 -OutputFormat Json
```

## Development Commands

### .NET Development
```bash
# Build applications
dotnet build

# Run tests
dotnet test

# Restore packages
dotnet restore

# Publish applications
dotnet publish
```

### Container Operations
```bash
# Build Docker images
docker build

# Run with Docker Compose
docker-compose up
```

### Cloud Deployment
```bash
# Deploy to Google Cloud
gcloud deploy

# Firebase deployment
firebase deploy
```

## Project Structure

### Core Directory Layout
- `ai_instruction_modules/` - Modular AI instruction files covering different aspects of development
- `scripts/` - PowerShell scripts for environment setup and validation
- `.github/` - GitHub Actions workflows and Copilot instructions
- `global.json` - .NET SDK version specification
- `mcp.json` - MCP server configurations

### AI Instruction Modules
The repository contains comprehensive instruction modules covering:
- Application guidelines and technology stack
- Workflow configuration and role assignments
- Testing and validation practices
- Deployment environments (local and cloud)
- Design principles and architectural patterns

## Testing & Validation Approach

### Test-Driven Development
- Use TDD approach for all code changes
- Write unit tests before implementing features
- Aim for 80%+ test coverage
- Always run `dotnet build` before marking tasks complete
- Use `dotnet test` for validation

### Testing Stack
- **xUnit** for unit testing framework
- **FluentAssertions** for readable test assertions
- **Moq** for mocking dependencies
- **Coverage reports** with HTML output

## MCP Server Configuration

The repository includes extensive MCP server configurations in `mcp.json`:
- Sequential thinking and memory servers
- File system access
- PowerShell, GitHub, Google Cloud, Firebase, Git, .NET, and Docker CLI integration
- Custom .NET MCP servers in adjacent MCPServers solution

## AI Workflow Integration

### Core AI Tools Usage
- **Sequential Thinking**: Use for complex problem analysis, multi-step planning, and debugging
- **Memory Tools**: Track project progress, component relationships, and decisions
- Both tools should be used together for major features, refactoring, and architectural decisions

### Quality Assurance Pattern
1. Use sequential thinking to break down problems
2. Check memory for relevant context and patterns
3. Consider ASP.NET Core + Google Cloud context
4. Update memory with new insights and decisions

## Architecture Principles

### Backend Development
- ASP.NET Core Web API with full controllers
- Dependency injection patterns
- Middleware pipeline configuration
- Structured logging with Serilog

### Frontend Development
- Blazor WebAssembly applications
- Component-based architecture
- State management patterns

### Cloud Integration
- Google Cloud services deployment
- Infrastructure as code with Terraform
- Container-first deployment strategy

## Documentation Standards

When making recommendations or implementing solutions:
- Provide links to Microsoft Learn documentation
- Reference Google Cloud documentation
- Include ASP.NET Core specific guides
- Validate implementations through compilation and testing
- Break changes into logical chunks with explanations

This repository serves as a comprehensive foundation for AI-assisted development of modern .NET applications deployed to Google Cloud Platform.
