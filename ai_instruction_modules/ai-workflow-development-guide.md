---
description: Comprehensive guide for creating, modifying, and troubleshooting AI workflows.
scope: workflow-development
prerequisites: ai-core-instructions.md
---
# AI Workflow Development Guide

<xml>
<instructions role="workflow-developer" scope="workflow-development">

<purpose>
## Purpose & When to Use
**Use when:** Creating, modifying, or troubleshooting workflow assignments and dynamic workflows.

| Task                    | Go To                                                                                                          |
| ----------------------- | -------------------------------------------------------------------------------------------------------------- |
| Create new assignment   | [ai-workflow-assignment-empty-template.md](./ai-workflow-assignments/ai-workflow-assignment-empty-template.md) |
| Create dynamic workflow | [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)           |
| Orchestrate workflow    | [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)                   |
| Validate workflow       | [validate-dynamic-workflow-script.md](./ai-workflow-assignments/validate-dynamic-workflow-script.md)           |
| Browse all assignments  | [ai-workflow-assignments.md](./ai-workflow-assignments.md)                                                     |
| GitHub authentication   | [ai-gh-authentication.md](./ai-gh-authentication.md)                                                           |
| Formatting standards    | [ai-instructions-format.md](./ai-instructions-format.md)                                                       |
</purpose>

<core_files>
## Canonical Reference Files

| File                                                                                                 | Purpose                                       |
| ---------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| [ai-workflow-assignments.md](./ai-workflow-assignments.md)                                           | Master index of all assignments               |
| [ai-workflow-config.md](./ai-workflow-config.md)                                                     | Tool config, event lifecycle, success metrics |
| [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)         | Orchestration algorithm, execution rules      |
| [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md) | **Canonical DSL syntax**, event rules         |
| [validate-dynamic-workflow-script.md](./ai-workflow-assignments/validate-dynamic-workflow-script.md) | Validation assignment                         |
| [ai-common-procedures.md](./ai-common-procedures.md)                                                 | Shared procedures (`<procedure ref="..."/>`)  |
</core_files>

<assignment_structure>
## Assignment Structure (Quick Reference)

**Location:** `ai_instruction_modules/ai-workflow-assignments/<short-id>.md`

**Required Sections:**
1. Front Matter (YAML: `description`, `scope`, `role`)
2. `<overview>` → `<goal>`, `<input>`, `<output>`
3. `<acceptance_criteria>` → `<criterion>` list
4. `<workflow>` → numbered `<step>` elements
5. `<validation>` → final checks

**Optional:** `<prerequisites>`, `<events>`, `<notes>`, `<references>`, `<appendix>`

**Full specification:** See [ai-workflow-assignment-empty-template.md](./ai-workflow-assignments/ai-workflow-assignment-empty-template.md)
</assignment_structure>

<dsl_reference>
## Dynamic Workflow DSL

**Canonical syntax specification:** [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)

**Quick patterns:**
```markdown
# Assignment list
`$assignments` = [`short-id-1`, `short-id-2`]

# Loop execution
For each `$name` in `$assignments`, you will:
   - assign the agent the `$name` assignment
   - record output as `#step-name.$name`

# Conditional
If `$condition` then:
   - action
```
</dsl_reference>

<event_system>
## Event System (Quick Reference)

| Event                      | When                       | Use For                 |
| -------------------------- | -------------------------- | ----------------------- |
| `pre-script-begin`         | Before workflow starts     | Environment validation  |
| `pre-assignment-begin`     | Before each loop iteration | Per-assignment setup    |
| `post-assignment-complete` | After each loop iteration  | Cleanup, documentation  |
| `post-script-complete`     | After all steps succeed    | Final reporting         |
| `on-assignment-failure`    | When assignment fails      | Error logging, rollback |
| `on-script-failure`        | When workflow fails        | Full cleanup            |

**Full event documentation:** [ai-workflow-config.md](./ai-workflow-config.md#event_system)
</event_system>

<orchestrator_rules>
## Orchestrator Non-Negotiables

1. **Resolution Trace** — Print file chain before execution
2. **Assignment-First** — Execute only from resolved assignment files
3. **Acceptance Gating** — All criteria must PASS
4. **Event Timing** — Execute events at exact lifecycle points
5. **Run Report** — Map 1:1 to acceptance criteria with evidence

**Full orchestrator specification:** [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
</orchestrator_rules>

<common_tasks>
## Common Tasks

### Adding New Assignment
1. Copy [ai-workflow-assignment-empty-template.md](./ai-workflow-assignments/ai-workflow-assignment-empty-template.md)
2. Place in `ai-workflow-assignments/<short-id>.md`
3. Complete all required sections
4. Add to [ai-workflow-assignments.md](./ai-workflow-assignments.md) index
5. Test end-to-end

### Adding New Dynamic Workflow
1. Create file in `ai-workflow-assignments/dynamic-workflows/<name>.md`
2. Follow [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
3. Add events if needed
4. Validate with `validate-dynamic-workflow-script`
5. Add to master index
</common_tasks>

<troubleshooting>
## Troubleshooting

| Issue                  | Solution                                                                                                             |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------- |
| "Assignment not found" | Verify short ID exists, check kebab-case naming                                                                      |
| Event not executing    | Check fourth-level heading under "Events" step                                                                       |
| Output reference fails | Loop: `#events.<event>.$name`, Singular: `#events.<event>`                                                           |
| DSL syntax error       | Compare against [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md) |
| Criteria not met       | Review assignment's Acceptance Criteria, ensure evidence exists                                                      |
</troubleshooting>

<quality_checklist>
## Quality Checklist
- [ ] All referenced assignment short IDs exist
- [ ] DSL follows [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
- [ ] Events use standard types
- [ ] Acceptance criteria are measurable
- [ ] Validated with `validate-dynamic-workflow-script`
</quality_checklist>

</instructions>
</xml>
