# Application Guidelines

## Overview

This document describes the technology stack that is used when creating new or updating exiting apps.

## Technology Stack

### Programming Language

C#
.NET: latest full release (as of 7/8/25: >= 9.0.302)

### Framework

ASP.NET Core Web API (not minimal API)

### Frontend

#### Web

Blazor Web Assembly
Aspire

#### Desktop

Avalonia UI (So Windows, Linux, and Mac support is created)

### Database

### Testing

xUnit
FluentAssertions
Moq
Coverage w/ HTML Report

### Containerization

Docker
Docker Compose

### Documentation

Swagger/OpenAPI

### Infrastructure

Terraform

### Scripting

Powershell Core (>= v7.1.x)

Framework: ASP.NET Core (.NET 9.0)
Database: Neo4j for graph storage
Frontend: Blazor WebAssembly
Communication: Server-Sent Events (SSE) for MCP
Testing: xUnit, FluentAssertions, Moq
Logging: Serilog with structured logging
Containerization: Docker and Docker Compose
Infrastructure: Terraform for deployment
Documentation: Swagger/OpenAPI

Packages:

Polly
Serilog
Serilog.Sinks.Console
Serilog.Sinks.File
Serilog.Sinks.Seq
Serilog.AspNetCore
FluentAssertions
xUnit
Moq
xUnit.runner.visualstudio
xUnit.runner.console


ABP
Carter
Nancy
CommunityToolkit

### Process

SOLID
DRY
OWASP