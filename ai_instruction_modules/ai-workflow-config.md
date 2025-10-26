# AI Workflow Configuration

<core_tools>
## Core Tools - Default Usage

### Sequential Thinking Tool
**Use for**: Complex analysis, multi-step planning, debugging, architecture decisions, refactoring strategies, performance/security planning

**Triggers**: Multi-step tasks, decision trees, deep reasoning, planning with revisions, complex problem-solving

### Memory Tools  
**Use for**: Project progress, component relationships, user preferences, decisions, recurring issues, workspace knowledge

**Pattern**: Check existing memory → update with new insights → create entities for components → link related information
</core_tools>

<technology_patterns>
## Technology-Specific Patterns
- **ASP.NET Core**: Sequential thinking for API design, memory for component relationships/DI patterns
- **Docker**: Sequential thinking for multi-stage builds, memory for container dependencies
- **GCP**: Sequential thinking for service architecture, memory for resource configurations
</technology_patterns>

<workflow_templates>
## Workflow Templates
1. **New Feature**: Sequential thinking (breakdown) → Memory check → Implementation → Memory update
2. **Debugging**: Sequential thinking (analyze/hypothesize) → Memory search → Investigation → Memory update  
3. **Refactoring**: Sequential thinking (analyze/plan) → Memory review → Planning → Memory update
</workflow_templates>

<automation_triggers>
## Automation Triggers
- **Sequential Thinking**: "How to" questions, multiple approaches, 3+ step tasks, planning needed, pros/cons analysis, complex troubleshooting
- **Memory**: Development sessions, project component mentions, architectural decisions, pattern implementation, user preferences/feedback
- **Both Tools**: Major features/refactoring, complex system interactions, new components, cross-cutting concerns, technology decisions
</automation_triggers>

<quality_checklist>
## Quality Checklist
**Before Solutions**: Sequential thinking breakdown? Memory context check? ASP.NET+GCP context considered? Memory update planned?  
**After Tasks**: Update memory with outcomes/lessons, record new patterns/practices, document preferences/feedback, link to existing context
</quality_checklist>

<success_metrics>
## Success Metrics
Consistency, context awareness, learning from accumulated knowledge, systematic thinking, knowledge retention
</success_metrics>

<additional_steps>
## Additional Steps
- Before Plan: Resolve and print the assignment chain (orchestrator → dynamic-workflow → assignment files).
- During Execute: Enforce template/source-of-truth and environment preflight checks where specified by the assignment.
- **Event Execution**: Check for and execute event scripts at their designated lifecycle points (pre-script-begin, pre-assignment-begin, post-assignment-completion, post-script-complete, on-assignment-failure, on-script-failure).
- After Execute: Gate completion on the assignment's Acceptance Criteria.
- Report: Produce a Run Report mapped to Acceptance Criteria (with evidence links), include the resolution trace, and document all event executions.
</additional_steps>

<event_system>
## Dynamic Workflow Event System

Dynamic workflows support lifecycle events that execute at specific points during workflow execution. When orchestrating a dynamic workflow:

### Event Lifecycle Points

1. **pre-script-begin**: Before any workflow steps execute
   - Use for: Environment validation, prerequisite checks, initialization
2. **pre-assignment-begin**: Before each assignment in a loop
   - Use for: Per-assignment setup, context preparation
3. **post-assignment-completion**: After each assignment completes successfully
   - Use for: Cleanup, summaries, documentation updates (as shown in the project-setup.md example)
4. **post-script-complete**: After all workflow steps complete
   - Use for: Final reporting, notifications, metrics
5. **on-assignment-failure**: When an assignment fails
   - Use for: Error logging, diagnostics
6. **on-script-failure**: When the entire workflow fails
   - Use for: Rollback, cleanup, failure notification

### Orchestrator Requirements for Events

When you encounter a dynamic workflow with an "Events" section:
1. **Parse** event definitions during workflow intake
2. **Execute** events at their exact lifecycle point—timing is mandatory
3. **Record** event execution and outputs in the Run Report
4. **Gate** on event success (except for failure-handling events)

Example from project-setup.md:
```markdown
### Events

#### `post-assignment-completion`

`$assignments` = [`create-repository-summary`]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`
```

This event executes after EACH assignment in the main workflow completes, running the `create-repository-summary` assignment to document progress.

For complete event documentation, see:
- [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md#events)
- [ai-workflow-assignments.md](./ai-workflow-assignments.md#dynamic-workflow-event-system)
</event_system>

<references>
## References
- Orchestrator: [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
- GitHub Authentication: [ai-gh-authentication.md](./ai-gh-authentication.md)
</references>
