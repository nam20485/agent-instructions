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
