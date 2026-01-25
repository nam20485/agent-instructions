# Dynamic Workflow Syntax

Canonical DSL for workflow files. Location: `ai-workflow-assignments/dynamic-workflows/<name>.md`

## Structure

- **Steps**: Third-level headings `### <step-id>` (kebab-case)
- **Events**: Fourth-level under `### Events` section

## Syntax Reference

See also: [workflow-dsl-reference.md](../../templates/workflow-dsl-reference.md)

### Variables & Constants
```
$variable = <value>           # define variable
const $CONSTANT: <value>      # immutable constant
$variable                     # use variable
$object->property             # access property
```

### Step References
```
#<step>                       # output of step
#<step>.<substep>             # output of substep
```

### Control Flow
```
For each $item in $list, you will:
   - actions (indented)

if $variable is true:
   - conditional actions
```

### Orchestration Directives
```
- assign the agent the 'assignment-id' assignment with input $variable
- wait until the agent finishes the task
- review the work and approve it
- record output as #step.substep
```

### Logging
```
- log: "message with {variable}"
```

### Lists
```
$items = [item1, item2, item3]
```

## Events

| Event | When |
|-------|------|
| `pre-script-begin` | Before any steps |
| `post-script-complete` | After all steps succeed |
| `pre-assignment-begin` | Before each loop assignment |
| `post-assignment-complete` | After each loop assignment |
| `on-assignment-failure` | When assignment fails |
| `on-script-failure` | When workflow fails |

## Event Handler Resolution

- Event handler names resolve to assignment files at `ai-workflow-assignments/<short-id>.md`.
- If a handler assignment is missing, halt the workflow and report the missing file (do not synthesize or stub).

## Error Recovery

1. **Retry sequence**: targeted fix → scratch rerun → escalation (max 3)
2. **Independent validation**: QA agent validates, not executor
3. **Fail fast**: Missing inputs should halt immediately

## Example

```markdown
### Inputs
- `$project` (required): Project name

### initialize

`$assignments` = [`create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment with input $project
   - wait until the agent finishes
   - review the work and approve it
   - record output as `#initialize.$assignment_name`
   - record output as `#events.post-assignment-complete.$assignment_name`
```
