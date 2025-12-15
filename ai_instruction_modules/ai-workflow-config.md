---
description: Configuration for workflow tools, events, and automation triggers
scope: workflow-config
---
# Workflow Configuration

## Core Tools

**Sequential Thinking:** Complex analysis, multi-step planning, architecture decisions, debugging.

**Memory:** Project progress, component relationships, decisions, recurring patterns.

## Automation Triggers

| Trigger    | Use                                                         |
| ---------- | ----------------------------------------------------------- |
| Sequential | "How to", 3+ steps, pros/cons, complex troubleshooting      |
| Memory     | Dev sessions, architecture decisions, patterns, preferences |
| Both       | Major features, system interactions, technology decisions   |

## Workflow Templates

1. **New Feature:** Sequential (breakdown) → Memory check → Implement → Memory update
2. **Debugging:** Sequential (analyze) → Memory search → Investigate → Memory update
3. **Refactoring:** Sequential (plan) → Memory review → Plan → Memory update

## Event System

| Event                      | When                          |
| -------------------------- | ----------------------------- |
| `pre-script-begin`         | Before workflow starts        |
| `pre-assignment-begin`     | Before each loop iteration    |
| `post-assignment-complete` | After each iteration succeeds |
| `post-script-complete`     | After all steps complete      |
| `on-assignment-failure`    | When assignment fails         |
| `on-script-failure`        | When workflow fails           |

**Orchestrator must:** Parse events → Execute at lifecycle point → Record outputs → Gate on success.

## Quality Checklist

- [ ] Sequential breakdown before solutions?
- [ ] Memory context checked?
- [ ] Memory updated with outcomes?

## References

- [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
- [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
