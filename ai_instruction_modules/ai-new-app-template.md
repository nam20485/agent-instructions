---
description: Template for defining a new application project plan.
scope: project-planning
prerequisites: none
---
# New Application Template

<xml>
<template role="project-planner" scope="project-planning">

<meta>
## App Title
[Title]

## Description
[Brief Overview]
</meta>

<requirements>
## Requirements
-   [ ] Requirement 1
-   [ ] Requirement 2
</requirements>

<tech_stack>
## Tech Stack
-   **Language:** C# (.NET 9.0)
-   **Container:** Docker + Compose
-   **Docs:** Swagger/OpenAPI
-   **Logging:** Structured
</tech_stack>

<structure>
## Project Structure
-   `src/`
-   `tests/`
-   `global.json` (SDK 9.0.0)
</structure>

<deliverables>
## Deliverables
-   [ ] Source Code
-   [ ] Tests
-   [ ] Dockerfiles
-   [ ] Documentation
</deliverables>

</template>
</xml>
