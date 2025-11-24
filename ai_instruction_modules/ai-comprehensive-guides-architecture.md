---
description: Visual architecture of the comprehensive guides and their relationship to canonical instruction modules.
scope: architecture
prerequisites: ai-core-instructions.md
---
# AI Instruction Modules: Comprehensive Guides Architecture

<xml>
<instructions role="architect" scope="architecture">

<overview>
## Overview
This document visualizes the hybrid architecture connecting comprehensive guides to canonical instruction modules, balancing discoverability with authoritative specifications.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                    AI Instruction Modules System                    │
│                                                                     │
│  Core Entry Point: ai-core-instructions.md                         │
│  └─ Meta-Guide directs to 3 comprehensive guides                   │
└────────────────────────┬────────────────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ▼               ▼               ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│   Workflow      │ │  Application    │ │  Environment    │
│  Development    │ │  Development    │ │   & Tools       │
│     Guide       │ │     Guide       │ │     Guide       │
│                 │ │                 │ │                 │
│ 451 lines       │ │ 450 lines       │ │ 600 lines       │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

## Detailed Architecture: Three-Guide System

### 1. Workflow Development Guide

```
┌───────────────────────────────────────────────────────────────────────┐
│                  ai-workflow-development-guide.md                     │
│                                                                       │
│  📑 Purpose & When to Use                                            │
│  ⚡ Quick Reference                                                   │
│     - DSL Syntax Summary                                             │
│     - Event System (6 types)                                         │
│     - Orchestrator Responsibilities                                  │
│  📖 Canonical Reference Files (with links)                           │
│  🔄 Common Workflows                                                 │
│     - Creating workflow assignments                                  │
│     - Adding dynamic workflows                                       │
│     - Orchestrating execution                                        │
│     - Validating scripts                                             │
│  🔧 Troubleshooting                                                  │
│  💡 Examples                                                         │
│  📝 Summary                                                          │
└───────────────────────────┬───────────────────────────────────────────┘
                            │
                ┌───────────┼───────────┬───────────────┐
                ▼           ▼           ▼               ▼
      ┌─────────────────────────────────────────────────────────┐
      │              Canonical Files (Authoritative)            │
      │                                                         │
      │  ai-workflow-assignments.md                            │
      │  └─ Workflow assignment structure                      │
      │  └─ Assignment execution rules                         │
      │  └─ 25+ assignment definitions                         │
      │                                                         │
      │  orchestrate-dynamic-workflow.md                       │
      │  └─ Orchestrator role assignment                       │
      │  └─ Execution procedures                               │
      │  └─ Error handling patterns                            │
      │                                                         │
      │  dynamic-workflow-syntax.md                            │
      │  └─ Complete DSL reference                             │
      │  └─ Event system specification                         │
      │  └─ Step types and parameters                          │
      │                                                         │
      │  validate-dynamic-workflow-script.md                   │
      │  └─ Validation assignment                              │
      │  └─ Syntax checking procedures                         │
      │  └─ Common validation errors                           │
      └─────────────────────────────────────────────────────────┘
```

### 2. Application Development Guide

```
┌───────────────────────────────────────────────────────────────────────┐
│                 ai-application-development-guide.md                   │
│                                                                       │
│  📑 Purpose & When to Use                                            │
│  ⚡ Quick Reference                                                   │
│     - Technology Stack (.NET 9.0+, ASP.NET Core, Blazor)            │
│     - Design Principles (12-Factor, SOLID, DDD)                      │
│     - ASP.NET Patterns (naming, routing, security)                   │
│     - Code Quality Standards                                         │
│  📖 Canonical Reference Files (with links)                           │
│  🔄 Common Workflows                                                 │
│     - Creating new applications                                      │
│     - Implementing features                                          │
│     - Refactoring code                                               │
│     - Code review process                                            │
│     - Testing strategies                                             │
│  🔧 Troubleshooting                                                  │
│     - Build errors                                                   │
│     - Runtime errors                                                 │
│     - Performance issues                                             │
│  💡 Examples                                                         │
│     - REST API                                                       │
│     - Blazor component                                               │
│     - Console app                                                    │
│     - Background service                                             │
│  📝 Summary                                                          │
└───────────────────────────┬───────────────────────────────────────────┘
                            │
                ┌───────────┼───────────┐
                ▼           ▼           ▼
      ┌─────────────────────────────────────────────────────────┐
      │              Canonical Files (Authoritative)            │
      │                                                         │
      │  ai-application-guidelines.md                          │
      │  └─ Complete technology stack                          │
      │  └─ Framework selection guidance                       │
      │  └─ Database and ORM patterns                          │
      │  └─ UI framework recommendations                       │
      │  └─ Global.json configuration                          │
      │                                                         │
      │  ai-design-principles.md                               │
      │  └─ Complete 12-Factor App methodology                 │
      │  └─ Detailed SOLID principles with examples            │
      │  └─ Gang of Four (GoF) design patterns                 │
      │  └─ Domain-Driven Design (DDD) concepts                │
      │  └─ Semantic versioning (SemVer)                       │
      │  └─ Code standards checklist                           │
      │                                                         │
      │  ai-instructions-aspnet-guidelines.md                  │
      │  └─ Comprehensive ASP.NET Core style guide             │
      │  └─ C# 10+ feature usage patterns                      │
      │  └─ Error handling and logging strategies              │
      │  └─ Performance optimization techniques                │
      │  └─ Repository pattern and EF Core best practices      │
      │  └─ Testing strategies (unit, integration, mocking)    │
      │  └─ Security implementation details                    │
      │  └─ Complete API design guidelines                     │
      └─────────────────────────────────────────────────────────┘
```

### 3. Development Environment Guide

```
┌───────────────────────────────────────────────────────────────────────┐
│               ai-development-environment-guide.md                     │
│                                                                       │
│  📑 Purpose & When to Use                                            │
│  ⚡ Quick Reference                                                   │
│     - Environment Types (Windows, Linux, devcontainer)               │
│     - Core Tools & Versions (Node.js, .NET, Python, CLIs)           │
│     - Terminal Management Principles                                 │
│     - PowerShell Patterns (naming, parameters, pipeline)             │
│     - GitHub CLI Command Patterns                                    │
│  📖 Canonical Reference Files (with links)                           │
│  🔄 Common Workflows                                                 │
│     - Setting up development environments                            │
│     - Managing terminal sessions                                     │
│     - Writing PowerShell cmdlets                                     │
│     - Working with GitHub CLI                                        │
│     - Version pinning strategies                                     │
│  🔧 Troubleshooting                                                  │
│     - Environment setup issues                                       │
│     - Terminal management issues                                     │
│     - PowerShell development issues                                  │
│     - GitHub CLI issues                                              │
│  💡 Examples                                                         │
│     - Complete environment setup                                     │
│     - PowerShell module with tests                                   │
│     - GitHub workflow automation                                     │
│     - Terminal session manager                                       │
│  📝 Summary                                                          │
└───────────────────────────┬───────────────────────────────────────────┘
                            │
                ┌───────────┼───────────┬──────────────┐
                ▼           ▼           ▼              ▼
      ┌─────────────────────────────────────────────────────────┐
      │              Canonical Files (Authoritative)            │
      │                                                         │
      │  ai-local-environment.md                               │
      │  └─ Shell configuration (Windows, Linux, WSL)          │
      │  └─ setup-environment.sh complete specification        │
      │  └─ Tool installation procedures                       │
      │  └─ Version pinning strategies                         │
      │  └─ Environment variable configuration                 │
      │  └─ Verification commands                              │
      │                                                         │
      │  ai-terminal-management.md                             │
      │  └─ Terminal session reuse best practices              │
      │  └─ Background process guidelines                      │
      │  └─ System resource impact analysis                    │
      │  └─ Cleanup strategies                                 │
      │  └─ Correct vs incorrect usage examples                │
      │                                                         │
      │  ai-powershell-instructions.md                         │
      │  └─ Complete PowerShell cmdlet development guidelines  │
      │  └─ Naming conventions and parameter design            │
      │  └─ Pipeline and output patterns                       │
      │  └─ Error handling and ShouldProcess                   │
      │  └─ Module development and structure                   │
      │  └─ Testing with Pester framework                      │
      │  └─ Full end-to-end examples                           │
      │                                                         │
      │  ai-working-command-examples.md                        │
      │  └─ Validated, working command examples                │
      │  └─ GitHub CLI patterns (auth, repos, PRs, projects)   │
      │  └─ Git workflows (clone, branch, commit, push)        │
      │  └─ PowerShell file operations                         │
      │  └─ Label and milestone management                     │
      │  └─ Base64 decoding and JSON filtering                 │
      │  └─ Conflict resolution patterns                       │
      └─────────────────────────────────────────────────────────┘
```

## Information Flow

### Pattern 1: Quick Reference Lookup
User Question -> `ai-core-instructions.md` -> Guide -> Quick Reference -> Answer.

### Pattern 2: Workflow Execution
User Task -> `ai-core-instructions.md` -> Guide -> Common Workflows -> Canonical Files.

### Pattern 3: Troubleshooting
User Problem -> `ai-core-instructions.md` -> Guide -> Troubleshooting -> Canonical Files.

### Pattern 4: Deep Dive
User Need -> `ai-core-instructions.md` -> Guide -> Quick Reference/Examples -> Canonical Files.

## Benefits
- **Discoverability:** Clear entry points and focused guides.
- **Authority:** Canonical files remain the single source of truth.
- **Maintainability:** Updates happen in one place; guides reference them.

</overview>
</instructions>
</xml>
</overview>
