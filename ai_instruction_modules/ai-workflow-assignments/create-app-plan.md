# Assignment: Create Application Plan

## (create-app-plan)

### Goal

Your goal is to create a plan for application based on a filled-out application template.

### Acceptance Criteria

1. Application template has been thoroughly analyzed and understood
2. Plan's project structure has been created according to established guidelines and plan
3. Template from Appendix A has been used as a template for the plan.
4. Plan contains detailed breakdown of all phases required to achieve complete implementation.
5. All phases list important steps required to achieve completion of that phase.
6. All required components and dependencies have been planned.
7. Application plan follows the specified technology stack and design principles
8. All mandatory application requirements have been addressed in plan. (testing, documentation, containerization, etc.)
9. All acceptance criteria from the template have been addressed in the plan.
10. All risks and mitigations identified.
11. Code quality standards and best practices have been followed
12. Application plan is ready for development and implementation.
   
### Assignment

Your assignment is to create a new application plan based on a filled-out application template. This involves systematic analysis of requirements, careful implementation following established guidelines, and delivery of a application plan that meets all specified criteria. You will use the template in Appendix A as a template for the plan, and then fil in the details for the specific application.

The application template can be found in the `docs/` directory in a file called `ai-new-app-template.md`. The supporting files are linked to in that file and are also included in the same directory. These files contain all the necessary details about the application you need to create the plan for, including features, components, and requirements.

Specifically, you will:

1. Analyze the filled-out application template and linked supporting documents to understand requirements and expectations and then create a comprehensive plan, documented as an issue (use the template in Appendix A), for the development of the application.

**Always follow instructions given here (generally) and specifically as described in the task-based workflow process.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### References:

* Excellent examples of previously-completed plans created for different applications: 
    * https://github.com/nam20485/advanced-memory3/issues/12
    * https://github.com/nam20485/support-assistant/issues/2

### Detailed Steps

1. **Analyze the Application Template**
   - Review the provided application template and any linked documents
   - Identify all requirements, features, and components that need to be implemented
   - Understand the technology stack and design principles to be followed

2. **Design Plan**
   - Create a detailed design plan based on the template
   - Define the project structure, including directories, files, and naming conventions
   - Identify necessary frameworks, tools, and packages to be used
   - Plan for testing, documentation, containerization, and other mandatory requirements
   - Create Issue documenting plan and iterate to gain approval from the orchestrator or stakeholders


### Completion

Ask the stake-holder if they are happy with the plan and can approve it. If not then make the requested changes and iterate asking for approval and making changes until approval is gained.
Ask the stake-holder for your next assignment.

## Appendix: Application Plan Issue Template (Copy-Paste)

Use the template below when you “Create Issue documenting plan” in step 2. It aligns with the Acceptance Criteria and covers all mandatory areas (testing, docs, containerization, CI/CD, security, risks, etc.). Copy this into a new GitHub Issue and fill in the placeholders.

````markdown
Title: [ProjectName] – Complete Implementation (Application Plan)

Labels: plan, design, architecture
Assignees: [owner]

---

# [ProjectName] – Complete Implementation

## Overview
Provide a concise summary of the application, the problem it solves, the desired outcomes, and links to the filled-out template (docs/ai-new-app-template.md) and any supporting docs.

## Goals
- [Goal 1]
- [Goal 2]

## Technology Stack
- Language: [e.g., C# .NET 9.0]
- UI Framework: [e.g., Avalonia/Blazor/etc.]
- AI/Runtime: [e.g., ONNX Runtime / Azure OpenAI / etc.]
- Architecture: [e.g., RAG / MCP / Microservices]
- Databases/Storage: [e.g., Neo4j / SQLite / Postgres / Vector DB]
- Logging/Observability: [e.g., Serilog, OpenTelemetry]
- Containerization/Infra: [e.g., Docker, Compose, Terraform]

## Application Features
- [Feature 1]
- [Feature 2]
- [Feature 3]

## System Architecture
### Core Services (if applicable)
1. [ServiceName] — responsibility summary
2. [ServiceName] — responsibility summary

### Key Features (system-level)
- [Key feature/capability]

## Project Structure
```
[ProjectName]/
├─ src/
│  ├─ [Project].Core/
│  ├─ [Project].Api/
│  ├─ [Project].Frontend/
│  └─ [Project].Shared/
├─ tests/
├─ docs/
├─ scripts/
├─ docker/
├─ assets/
└─ global.json
```

---

## Implementation Plan

### Phase 1: Foundation & Setup
- [ ] 1.1. Repository and solution bootstrap
- [ ] 1.2. Core dependencies and configuration
- [ ] 1.3. Runtime/Model initialization (if AI)
- [ ] 1.4. Data/Knowledge base foundation (if RAG)
- [ ] 1.5. Basic content processing/indexing (if applicable)

### Phase 2: Core Services / Core Engine
- [ ] 2.1. Implement core module/service A
   - [ ] 2.1.1. Sub-task A
   - [ ] 2.1.2. Sub-task B
- [ ] 2.2. Implement core module/service B

### Phase 3: UI/UX & Integration
- [ ] 3.1. UI foundation and navigation
- [ ] 3.2. ViewModels/State management
- [ ] 3.3. Primary user flows (chat/task/…)
- [ ] 3.4. Async ops, cancellation, error handling
- [ ] 3.5. Settings/configuration

### Phase 4: Advanced Capabilities & Security
- [ ] 4.1. Tooling/Function calling/Agentic features (if applicable)
- [ ] 4.2. Human-in-the-loop approval and auditing
- [ ] 4.3. Performance optimizations and caching
- [ ] 4.4. Observability and dashboards

### Phase 5: Testing, Docs, Packaging & Deployment
- [ ] 5.1. Test suites (unit/integration/e2e/perf)
- [ ] 5.2. API/Developer documentation
- [ ] 5.3. Containerization/installer packaging
- [ ] 5.4. IaC/Environments/CI-CD pipelines
- [ ] 5.5. Final hardening and release checklist

---

## Mandatory Requirements Implementation

### Testing & Quality Assurance
- [ ] Unit tests — coverage target: [e.g., 80%+]
- [ ] Integration tests
- [ ] E2E tests
- [ ] Performance/load tests
- [ ] Automated tests in CI

### Documentation & UX
- [ ] Comprehensive README
- [ ] User manual and feature docs
- [ ] XML/API docs (public APIs)
- [ ] Troubleshooting/FAQ
- [ ] In-app help (if applicable)

### Build & Distribution
- [ ] Build scripts
- [ ] Containerization support (if relevant)
- [ ] Installer packaging (if desktop)
- [ ] Release pipeline

### Infrastructure & DevOps
- [ ] CI/CD workflows (build/test/scan/publish)
- [ ] Static analysis and security scanning
- [ ] Performance benchmarking/monitoring

---

## Acceptance Criteria
- [ ] Core architecture implemented and components communicate as designed
- [ ] Key features/functionality work end-to-end
- [ ] Observability/logging in place with actionable signals
- [ ] Security model and controls validated
- [ ] Test coverage target met and CI green
- [ ] Containerization/packaging works for target environment(s)
- [ ] Documentation complete and accurate

## Risk Mitigation Strategies
| Risk | Mitigation |
|------|------------|
| [Risk 1] | [Mitigation 1] |
| [Risk 2] | [Mitigation 2] |

## Timeline Estimate
- Phase 1: [x–y] weeks
- Phase 2: [x–y] weeks
- Phase 3: [x–y] weeks
- Phase 4: [x–y] weeks
- Phase 5: [x–y] weeks
- Total: [x–y] weeks

## Success Metrics
- [Metric 1]
- [Metric 2]
- [Metric 3]

## Repository Branch
Target branch for implementation: [e.g., copilot/[project-slug]]

## Implementation Notes
Key assumptions, adaptations, and references to technical docs or ADRs.
````
