# New Application Guidelines

This document describes the technology stack that is used when creating new or updating existing apps.

## Technology Stack

### Programming Language

C#
.NET: latest full release (as of 7/8/25: >= 9.0.0)

### Web

#### Backend

ASP.NET Core Web API (not minimal API)
Aspire

ABP (for larger projects)

#### Frontend

Blazor Web Assembly (Maui Hybrid if approriate)

### Desktop

Avalonia UI (Windows, Linux, and MacOS support)

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

* xUnit
* FluentAssertions
* Moq
* Coverage w/ HTML Report

* Unit Testing
* Integration Testing
* Substabtial Coverage % Expected

### Containerization

Docker
Docker Compose

### Documentation

Swagger/OpenAPI

### Logging

Serilog with structured logging (File, Console)

### CI/CD

#### GitHub Actions Workflows

The following types of workflows should always be included:

* Automated build
* Automated Tests
* Docker build and push to repo's GitHub registry

For larger projects you can add these:

Static analysis/security scanning
Create Release
Deployment

### Infrastructure


#### Terraform

* Terraform definitions should be created
* Include providers for Docker

### Scripting

Powershell Core (>= v7.1.x)

### Packages

These can be used as needed based on situation.

Polly
ABP
Carter
Nancy
CommunityToolkit
