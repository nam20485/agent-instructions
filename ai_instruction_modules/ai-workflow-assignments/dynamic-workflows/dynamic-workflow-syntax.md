# Dynamic Workflow Syntax (Canonical)

This file defines the canonical syntax for dynamic workflow files. All tools and documentation should reference this file for the DSL specification.

## File location and naming

- Place workflows under: ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/<name>.md
- Each workflow must include a top-level section named "## Script"

## Script structure

- Steps are third-level headings: "### <step-id>" (kebab-case, unique per file)
- The lines under each step define variables, loops, and assignment/function directives

## Legend

- `$variable` = <value>: define variable
- `$variable`: use variable
- `#<step>`: reference output of a step
- `#<step>.<substep>`: reference output of a substep/assignment in that step
- `get-function-name(<parameters>)`: call a function with parameters
- [ listItem1, listItem2, ... ]: define a list
  
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
