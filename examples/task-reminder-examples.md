<examples>
  <example id="task-reminder-json">
    <description>JSON structure for the current task reminder.</description>
    <content>
```json
{
  "repo": "advanced-memory2",        
  "branch": "issues/1-implement-advanced-memory2-app",
  "task": "Complete Phase 1: Project Setup and Infrastructure",
  "issue": 1,
  "state": "in progress",
  "description": "Missing Docker/Docker Compose configuration and cross-service project references in ASP.NET Core Aspire application",
  "context": "Phase 1 appeared complete but analysis revealed missing containerization infrastructure. Need to add Dockerfile for each service, docker-compose.yml for local dev, and configure proper project references between ApiService and backend services. Current build succeeds but service integration incomplete.",
  "nextSteps": ["Add Dockerfile to each service project", "Create docker-compose.yml for local development", "Configure project references between services", "Test containerized deployment"],
  "blockers": [],
  "lastUpdated": "2025-07-10T15:30:00Z"
}
```
    </content>
  </example>
</examples>
