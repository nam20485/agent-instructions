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

- `$variable` = <value>: define variable
- `${variable}` = <value>: define variable (brace format)

- `$variable`: use variable
- `${variable}`: use variable (brace format)

- `#<step>`: reference output of a step
- `#<step>.<substep>`: reference output of a substep/assignment in that step

- `get-function-name(<parameters>)`: call a function with parameters
- [ listItem1, listItem2, ... ]: define a list
- `$object_variable->property`: access an object property 

## Example: Accessing Object Properties
- $object_variable can be either a simple scalar value type or another complex object
- when $object_variable is another complex object type, any property defined in that type of object can be accessed
- when $object_variable is a simple scalar value type, only basic property types such as e.g. length, name, count, etc. can be accessed (depending on the type of the scalar value)  
  
Quoting conventions:
- Use backticks for assignment short IDs and step identifiers (e.g., `perform-task`)
- Use single quotes for free-form strings
- Do not quote keywords or variables

Output recording convention for loops:
- When iterating over a list of assignment short IDs, record outputs under the current step using the assignment short ID as a subkey
- Example: after running `create-app-plan` inside step `create-project-and-plan`, record as `#create-project-and-plan.create-app-plan`

## Examples

Define an array and iterate:

`$assignments` = [`create-app-plan`, `create-project-structure`]

For each `$assignment_name` in `$assignments`, you will:
  - assign the agent the `$assignment_name` assignment
  - record output as `#plan-and-setup.$assignment_name`
