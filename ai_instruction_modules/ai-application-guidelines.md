# New Application Guidelines

This document describes the technology stack that is used when creating new or updating exiting apps.

## Technology Stack

### Programming Language

C#
.NET: latest full release (as of 7/8/25: >= 9.0)

### Web

#### Backend

ASP.NET Core Web API (not minimal API)
Aspire

ABP (for larger projects)

#### Frontend

Blazor Web Assembly (Maui Hybrid if approriate)

### Desktop

Avalonia UI (So Windows, Linux, and Mac support is created)

#### No UI

Consolonia w/ Spectre

### Database

Depends on DB type required:

Redis
Memcache
Neo4J
MS SQL
PostgreSql

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

### Logging

Serilog with structured logging (File, Console)

### CI/CD

GitHub Actions Workflows for medium to larger projects. The following types of workflows can be included as appropritae:

Automated build
Automated Tests
Docker build and push to registry
Package build and push to registry
Static analysis/security scanning
Create Release
Deployment

### Infrastructure

Terraform

### Scripting

Powershell Core (>= v7.1.x)

### Packages

These can be used as needed based on situation.

Polly
ABP
Carter
Nancy
CommunityToolkit
