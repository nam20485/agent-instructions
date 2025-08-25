# AI Workflow Configuration

## Core Tools - Default Usage

### Sequential Thinking Tool
**Use for**: Complex analysis, multi-step planning, debugging, architecture decisions, refactoring strategies, performance/security planning

**Triggers**: Multi-step tasks, decision trees, deep reasoning, planning with revisions, complex problem-solving

### Memory Tools  
**Use for**: Project progress, component relationships, user preferences, decisions, recurring issues, workspace knowledge

**Pattern**: Check existing memory → update with new insights → create entities for components → link related information

## Technology-Specific Patterns
- **ASP.NET Core**: Sequential thinking for API design, memory for component relationships/DI patterns
- **Docker**: Sequential thinking for multi-stage builds, memory for container dependencies
- **GCP**: Sequential thinking for service architecture, memory for resource configurations

## Workflow Templates
1. **New Feature**: Sequential thinking (breakdown) → Memory check → Implementation → Memory update
2. **Debugging**: Sequential thinking (analyze/hypothesize) → Memory search → Investigation → Memory update  
3. **Refactoring**: Sequential thinking (analyze/plan) → Memory review → Planning → Memory update

## Automation Triggers
- **Sequential Thinking**: "How to" questions, multiple approaches, 3+ step tasks, planning needed, pros/cons analysis, complex troubleshooting
- **Memory**: Development sessions, project component mentions, architectural decisions, pattern implementation, user preferences/feedback
- **Both Tools**: Major features/refactoring, complex system interactions, new components, cross-cutting concerns, technology decisions

## Quality Checklist
**Before Solutions**: Sequential thinking breakdown? Memory context check? ASP.NET+GCP context considered? Memory update planned?  
**After Tasks**: Update memory with outcomes/lessons, record new patterns/practices, document preferences/feedback, link to existing context

## Success Metrics
Consistency, context awareness, learning from accumulated knowledge, systematic thinking, knowledge retention

## Additional Steps
- Before Plan: Resolve and print the assignment chain (orchestrator → dynamic-workflow → assignment files).
- During Execute: Enforce template/source-of-truth and environment preflight checks where specified by the assignment.
- After Execute: Gate completion on the assignment’s Acceptance Criteria.
- Report: Produce a Run Report mapped to Acceptance Criteria (with evidence links) and include the resolution trace.

## References
- Orchestrator: [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
