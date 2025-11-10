# Assignment: Create Feature Plan

## (create-feature-plan)

### Goal

Your goal is to create a comprehensive plan for delivering a major new feature within an existing application. Use the feature plan issue template in Appendix A to capture the work, grounding every decision in the current repository's architecture, codebase, and the supplied feature specification materials located under `plan_docs/`.

### Acceptance Criteria

1. Feature specification, supporting documents, and relevant existing architecture docs have been thoroughly analyzed and understood.
2. Dependencies, integration points, data flows, and potential regressions have been identified and documented.
3. Updates required to `plan_docs/tech-stack.md`, `plan_docs/architecture.md`, and any feature-specific planning artifacts have been completed to reflect the new feature.
4. Plan documents a detailed breakdown of all phases (discovery, design, implementation, integration, hardening) required to deliver the feature end-to-end.
5. Each phase lists critical steps, owners (if known), sequencing, and validation checkpoints necessary for completion.
6. All required components (UI, API, services, infrastructure, data, observability, security, compliance) and external dependencies are accounted for.
7. Feature plan aligns with the repository's established technology stack, design principles, coding standards, and non-functional requirements.
8. Regression strategy, testing approach (unit/integration/e2e/perf), documentation updates, rollout plan, and observability considerations are fully addressed.
9. Risk matrix captures feature-specific risks, regression concerns, ecosystem impacts, and their mitigations.
10. Stakeholder sign-offs, operational readiness, and support considerations are documented.
11. Issues, stories, or epics introduced by the plan are linked to the appropriate milestones and project boards.
12. Plan has been documented in a GitHub issue using the template in Appendix A and reflects stakeholder feedback.
13. Created issue has been added to the correct GitHub Project for tracking and assigned to the appropriate milestone (typically the phase that introduces the feature).
14. Appropriate labels (e.g., "planning", "feature", "documentation") have been applied to the issue.
15. All acceptance criteria from Appendix A have been satisfied, and the feature plan is ready for implementation work to proceed.

### Assignment

You are enhancing an existing application by planning a major feature addition. Analyze the feature request and its supporting documents, audit the current solution, and create a detailed, implementation-ready plan. Capture any changes needed across the codebase, shared services, integrations, documentation, testing, and operational tooling. Use the template in Appendix A to create the plan issue, update the necessary planning documents, and ensure stakeholders have a clear path to execution. No application code is written in this assignment.

Feature specification inputs are available in the repository's `plan_docs/` directory (for example, `plan_docs/feature-brief.md`, `plan_docs/tech-stack.md`, `plan_docs/architecture.md`, and any linked diagrams or ADRs). These documents describe the desired feature, constraints, and context required to deliver it.

Specifically, you will:

1. Analyze the feature specification and all supporting documents under `plan_docs/` to understand requirements, existing architecture, dependencies, and constraints.
2. Evaluate the current application implementation to identify affected components, integration points, and any prerequisite refactoring.
3. Produce a comprehensive feature plan issue (using the Appendix A template) that documents phases, deliverables, risks, mitigations, testing strategy, documentation updates, observability, rollout considerations, and stakeholder checkpoints.
4. Update the repository's planning documents (`plan_docs/tech-stack.md`, `plan_docs/architecture.md`, feature-specific docs) so they reflect the planned changes and remain single sources of truth.
5. Create or update milestones aligned with the plan's phases, link planned issues to their milestones, add the plan issue to the appropriate Project board, and apply the proper labels.

**Always follow the instructions given here and as described in the task-based workflow process.**

It is essential to the overall product quality that everyone performs their assignment exactly as specified.

### Important: Planning Only - No Implementation

This assignment is **PLANNING ONLY**. You will:
- ✅ Document the feature plan in an issue
- ✅ Update planning documents (tech-stack.md, architecture.md, feature briefs/specs)
- ✅ Verify integration with existing systems and document necessary changes
- ✅ Create or update milestones and link issues
- ✅ Add the feature plan issue to the relevant GitHub Project(s)
- ❌ NOT write or modify application source code, configuration files, or infrastructure templates
- ❌ NOT perform migrations, deployments, or feature toggles
- ❌ NOT modify project directory structures or solution files

Implementation tasks occur in follow-on assignments (feature implementation, testing, rollout, etc.).

### References

* Review existing application plan issues or feature plans for similar features in this repository or related projects (if available) to align structure and expectations.
* Example planning issues:
    * https://github.com/nam20485/advanced-memory3/issues/12 (full application plan example)
    * https://github.com/nam20485/support-assistant/issues/2 (full application plan example)

### Detailed Steps

1. **Analyze the Feature Specification**
   - Review the feature request, design briefs, ADRs, UX flows, and any linked documents
   - Identify existing components, services, APIs, data models, and integrations impacted by the feature
   - Confirm technology stack alignment and note any new dependencies or upgrades required
   - Engage stakeholders to clarify ambiguities, non-functional requirements, or regulatory constraints
   - Update or create supporting notes in `plan_docs/` for quick reference (e.g., feature glossary, context summary)

2. **Design the Feature Plan**
   - Define the phases/epics required to deliver the feature from discovery to rollout
   - Break phases into major tasks, including refactoring, development, testing, documentation, and operational readiness
   - Document data migration requirements, feature flags, rollout sequencing, and rollback strategies
   - Capture testing strategy (unit, integration, e2e, performance) and regression scope, including automation updates
   - Document observability, alerting, logging changes, and compliance/security considerations
   - Update `plan_docs/tech-stack.md`, `plan_docs/architecture.md`, and any feature-specific documents with planned modifications

3. **Publish and Align**
   - Create the feature plan issue using the Appendix A template, ensuring all sections are fully completed
   - Obtain stakeholder feedback, iterate on the plan if necessary, and record decisions in the issue and supporting docs
   - Create or update milestones corresponding to plan phases and ensure related issues are linked
   - Add the feature plan issue to the appropriate GitHub Project board(s) for visibility and tracking
   - Apply repository-standard labels (e.g., "planning", "feature", "documentation", and team-specific tags)

### Events

#### `pre-assignment-begin`

This event runs before the assignment begins to gather context and prepare for execution.

- assign the agent the `gather-context` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.pre-assignment-begin.gather-context`

#### `on-assignment-failure`

This event runs if the assignment fails to recover from errors systematically.

- assign the agent the `recover-from-error` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.on-assignment-failure.recover-from-error`

#### `post-assignment-complete`

This event runs after the assignment completes to report progress.

- assign the agent the `report-progress` assignment
- wait until the agent finishes the task
- review the work and approve it
- record output as `#events.post-assignment-complete.report-progress`

### Completion

- Ask the stakeholders if they approve the feature plan; if revisions are requested, iterate until approval is granted.
- **DO NOT IMPLEMENT OR MODIFY APPLICATION CODE.** This assignment produces planning artifacts only.
- Upon approval, transition to the next assignment as directed (e.g., feature implementation, epic/story creation).

## Appendix A: Feature Plan Issue Template (Copy-Paste)

Use the template below when you create the GitHub issue documenting the feature plan. It aligns with the acceptance criteria and covers all required considerations (architecture deltas, testing, documentation, rollout, observability, risks, etc.). Copy this into a new GitHub Issue and fill in the placeholders.

**TEMPLATE MOVED**.

The template is located at [feature-plan.md](/.github/ISSUE_TEMPLATE/feature-plan.md) under the [.github/ISSUE_TEMPLATE/](/.github/ISSUE_TEMPLATE/) directory in the root of the repository.
