# Assignment: Validate Dynamic Workflow Script

## (validate-dynamic-workflow-script)

### Overview

This assignment involves validating the syntax and logical correctness of a dynamic workflow script. The script is written in a custom domain-specific language (DSL) designed for specifying dynamic workflows. Your task is to ensure that the script adheres to the language's syntax rules and logical structure, and to provide feedback on the validity of the script.

### Inputs

- $workflow_name
    - short id of the dynamic workflow assignment to validate
    - string
    - optional (iff $workflow_file is provided)
    - e.g., `breakdown-plan`
  
 - $workflow_file
    - path to the dynamic workflow file to validate
    - string
    - optional (iff $workflow_name is provided)    
    - e.g., `dynamic-workflows/breakdown-plan.md`

### Goal

Your goal is to validate the provided dynamic workflow script to ensure it meets the syntax and logical requirements of the custom DSL, and provide reassurance of validity or feedback on any issues found.

### Acceptance Criteria

1. The script adheres to the syntax rules of the custom DSL.
2. The logical structure of the script is correct and coherent.
3. All variables and functions used in the script are properly defined and referenced.
4. The script does not contain any logical errors or contradictions.

### Assignment

Your assignment is to validate the provided dynamic workflow script. This involves systematically checking the script against the syntax and logical rules of the custom DSL to ensure it is correct and coherent. If the script is found to be valid, you will provide reassurance of its validity. If any issues are found, you will provide feedback on the nature of the issues and how they can be resolved. 

##### Syntax reference (canonical)

- Canonical syntax: [dynamic-workflow-syntax.md](./dynamic-workflows/dynamic-workflow-syntax.md)
- Orchestration instructions: [orchestrate-dynamic-workflow.md](./orchestrate-dynamic-workflow.md)

### Detailed Steps

1. Review the provided dynamic workflow script.
2. Check the script against the syntax rules of the custom DSL (see canonical legend).
3. Verify the logical structure of the script is correct and coherent.
4. Ensure all variables and functions used in the script are properly defined and referenced.
5. Verify that all referenced assignment short IDs exist in this repository (e.g., `create-app-plan`, `perform-task`).
6. Verify that any referenced files/paths resolve (e.g., dynamic workflow file location and name).
7. Check the script for any logical errors or contradictions.
8. If the script is found to be valid, provide reassurance of its validity.
9. If any issues are found, provide feedback on the nature of the issues and how they can be resolved.

### Completion

After completing the above steps, you will have validated the provided dynamic workflow script. You may then proceed to orchestrate it using [orchestrate-dynamic-workflow](./orchestrate-dynamic-workflow.md).

## Preflight Outputs
- Resolution Trace: orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → assignments → assignment files (URLs/SHAs)
- Acceptance Criteria: Parsed list per assignment that will be enforced as gates
- Preflight Checks: Template availability, required scripts, permissions, branch protection
- Fail-Fast: If any required file is unreadable or preflight fails, stop before executing actions

## Usage
- Run the validator with $workflow_name and to ensure all inputs and files are resolvable.
- Only proceed to orchestration if the dry-run passes.

## References
- Orchestrator guardrails: [orchestrate-dynamic-workflow.md](./orchestrate-dynamic-workflow.md)
- Dynamic syntax: [dynamic-workflow-syntax.md](./dynamic-workflows/dynamic-workflow-syntax.md)

## Appendix: Quick DSL Validation Checklist

- File location and name align with repository convention (dynamic-workflows/<name>.md)
- Contains a "## Script" section with one or more third-level step headings (### <step-id>)
- Step IDs use kebab-case and are unique within the file
- Uses approved quoting conventions (backticks for assignment short IDs/step identifiers; single quotes for free strings; no quotes for variables/keywords)
- Variables are defined before use and not redefined inconsistently
- When iterating, outputs are recorded per assignment using the output recording convention (e.g., `#step.assignment-short-id`) if later referenced
- All referenced assignment short IDs exist in the repository
- Any referenced paths resolve from this file’s location
- No contradictory or unreachable instructions; steps proceed in a logical order