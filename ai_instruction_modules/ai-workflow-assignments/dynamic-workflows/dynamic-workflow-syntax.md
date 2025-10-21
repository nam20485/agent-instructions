# Dynamic Workflow Syntax (Canonical)

This file defines the canonical syntax for dynamic workflow files. All tools and documentation should reference this file for the DSL specification.

## File location and naming

- Place workflows under: ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/<name>.md
- Each workflow must include a top-level section named "## Script"

## Script structure

- Steps are third-level headings: "### <step-id>" (kebab-case, unique per file)
- The lines under each step define variables, loops, and assignment/function directives

## Orchestrator Responsibilities

  - Resolve each listed assignment to its `ai-workflow-assignments/<assignment>.md` file.
  - Compile context for passing during delegtion or workflow assignments
  - 
  - Extract and enforce the assignment’s Acceptance Criteria as the Definition of Done.
  - Print a resolution trace and produce a Run Report as defined in the orchestrator guardrails.

## Legend

### Variables

- `$variable` = <value>: define variable
- `${variable}` = <value>: define variable (brace format)
- `const $VARIABLE: <value>`: define constant (immutable variable)

- `$variable`: use variable
- `${variable}`: use variable (brace format)

### Step References

- `#<step>`: reference output of a step
- `#<step>.<substep>`: reference output of a substep/assignment in that step

### Functions and Data Structures

- `get-function-name(<parameters>)`: call a function with parameters
- [ listItem1, listItem2, ... ]: define a list
- `$object_variable->property`: access an object property 

### Control Flow

- `For each $item in $list, you will:` - iterate over a list
- `if $variable is true:` - conditional execution when variable is true
- `if $variable is false:` - conditional execution when variable is false
- Indent nested blocks under control flow statements

### Orchestration Directives

Standard pattern for delegating work to an agent:
- `assign the agent the 'assignment-id' assignment with input $variable`
- `wait until the agent finishes the task`
- `review the work and approve it`
- `record output as #step.substep`

### Logging

- `log: "message"` - output a log message during workflow execution
- `log: "message with {variable}"` - interpolate variables in log messages using curly braces
- `log: "access property: {object.property}"` - access object properties in log messages
- Log messages are output to the orchestrator's execution trace for debugging and monitoring

### Events

Events are special subsections within the Script section that define actions to be executed at specific lifecycle points during workflow execution. Events enable dynamic, context-aware behavior that responds to workflow state changes.

#### Event Declaration

Events are declared as fourth-level headings under a third-level "Events" step:

```markdown
### Events

#### `event-name`
```

#### Standard Event Types

- `pre-script-begin`: Executes once before any script steps begin
- `post-script-complete`: Executes once after all script steps complete successfully
- `pre-assignment-begin`: Executes before each assignment in an iteration starts
- `post-assignment-completion`: Executes after each assignment in an iteration completes successfully
- `on-assignment-failure`: Executes when an assignment fails (provides error context)
- `on-script-failure`: Executes when the entire script fails (cleanup/rollback actions)

#### Event Execution Rules

1. **Timing is Critical**: Events MUST execute at their designated lifecycle point
   - `pre-*` events run BEFORE the associated action
   - `post-*` events run AFTER the associated action completes
   - `on-*-failure` events run only when the associated action fails

2. **Scope and Context**:
   - `pre-script-begin` and `post-script-complete` execute once per workflow run
   - `pre-assignment-begin` and `post-assignment-completion` execute once per assignment in loops
   - Events have access to the same variables and outputs as the parent script
   - Loop events can access the current iteration's `$assignment_name` and loop index

3. **Execution Order**:
   ```
   pre-script-begin
   → main-step-1
      → pre-assignment-begin (if loop)
      → assignment execution
      → post-assignment-completion (if loop)
   → main-step-2
   → ...
   → post-script-complete
   ```

4. **Failure Handling**:
   - If an event script fails, the entire workflow fails
   - `on-assignment-failure` and `on-script-failure` events should not throw errors
   - Use failure events for cleanup, logging, and notification only

5. **Output Recording**:
   - Event outputs should be recorded under: `#events.<event-name>.$assignment_name` (for loop events)
   - Or: `#events.<event-name>` (for singular events)

#### Event Script Syntax

Event scripts use the same DSL syntax as main scripts:

```markdown
#### `post-assignment-completion`

`$assignments` = [`create-repository-summary`]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`
```

### Quoting Conventions

- Use backticks for assignment short IDs and step identifiers (e.g., `perform-task`)
- Use single quotes for free-form strings
- Do not quote keywords or variables

## Example: Accessing Object Properties

- $object_variable can be either a simple scalar value type or another complex object
- when $object_variable is another complex object type, any property defined in that type of object can be accessed
- when $object_variable is a simple scalar value type, only basic property types such as e.g. length, name, count, etc. can be accessed (depending on the type of the scalar value)

## Example: Output Recording Convention for Loops

- When iterating over a list of assignment short IDs, record outputs under the current step using the assignment short ID as a subkey
- Example: after running `create-app-plan` inside step `create-project-and-plan`, record as `#create-project-and-plan.create-app-plan`

## Documentation Conventions

### Helper Functions

Document custom functions before the main script with this format:

```
### Helper Functions

#### function-name($param1, $param2)
Brief description of what the function does.
- **Input:** Description of input parameters
- **Returns:** Description of return value and format
- **Example:** `function-name(value1, value2)` returns expected output
```

### Workflow Inputs

Document workflow inputs at the start of the script section:

```
### Inputs
- `$parameter_name` (required/optional)
  - Description of parameter
  - Additional details or constraints
  - Default value if applicable
```

## Example: Accessing Object Properties

- $object_variable can be either a simple scalar value type or another complex object
- when $object_variable is another complex object type, any property defined in that type of object can be accessed
- when $object_variable is a simple scalar value type, only basic property types such as e.g. length, name, count, etc. can be accessed (depending on the type of the scalar value)

## Example: Output Recording Convention for Loops

- When iterating over a list of assignment short IDs, record outputs under the current step using the assignment short ID as a subkey
- Example: after running `create-app-plan` inside step `create-project-and-plan`, record as `#create-project-and-plan.create-app-plan`

## Example: Complete Workflow with Conditionals and Orchestration

## Example: Complete Workflow with Conditionals and Orchestration

Define an array and iterate with conditional logic:

```markdown
### Inputs
- `$parallel_mode` (optional)
  - Boolean flag to control execution mode
  - Default: true

### my-workflow-step

const `$PARALLEL_MODE`: `true`

`$assignments` = [`create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$assignments`, you will:
  - assign the agent the `$assignment_name` assignment
  - wait until the agent finishes the task
  - review the work and approve it
  - record output as `#plan-and-setup.$assignment_name`
  
  if `$PARALLEL_MODE` is `true`:
    - process results immediately
  
if `$PARALLEL_MODE` is `false`:
  - process all results after loop completes
```

## Example: Basic Array Iteration

`$assignments` = [`create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$assignments`, you will:
  - assign the agent the `$assignment_name` assignment
  - record output as `#plan-and-setup.$assignment_name`

## Example: Complete Workflow with Events

This example demonstrates a complete workflow with pre-script, loop iteration, and post-assignment events:

```markdown
### Inputs
- `$project_name` (required): Name of the project to initialize

### Events

#### `pre-script-begin`
- validate environment prerequisites
- ensure GitHub authentication is configured
- record validation results as `#events.pre-script-begin`

#### `pre-assignment-begin`
- log assignment start time
- prepare assignment-specific context
- validate assignment prerequisites
- record preparation status as `#events.pre-assignment-begin.$assignment_name`

#### `post-assignment-completion`

`$cleanup_assignments` = [`create-repository-summary`, `update-documentation`]

For each `$assignment_name` in `$cleanup_assignments`, you will:
   - assign the agent the `$assignment_name` assignment with input $project_name
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`

#### `post-script-complete`
- generate final workflow report
- notify stakeholders of completion
- record completion metrics as `#events.post-script-complete`

#### `on-script-failure`
- log failure details and context
- attempt to rollback partial changes
- notify stakeholders of failure
- record failure report as `#events.on-script-failure`

### initialize-project

`$main_assignments` = [`init-existing-repository`, `create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$main_assignments`, you will:
   - assign the agent the `$assignment_name` assignment with input $project_name
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#initialize-project.$assignment_name`
```

**Execution Flow**:
1. `pre-script-begin` event executes (validates environment)
2. `initialize-project` step begins
3. For each assignment in loop:
   - `pre-assignment-begin` event executes (prepares assignment context)
   - Assignment executes
   - `post-assignment-completion` event executes (creates summary and updates docs)
4. After all assignments complete, `post-script-complete` event executes (generates report)
5. If any failure occurs, `on-script-failure` event executes instead of `post-script-complete`
