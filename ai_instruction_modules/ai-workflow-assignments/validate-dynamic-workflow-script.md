# Assignment: Validate Dynamic Workflow Script

## (validate-dynamic-workflow-script)

### Overview

This assignment involves validating the syntax and logical correctness of a dynamic workflow script. The script is written in a custom domain-specific language (DSL) designed for specifying dynamic workflows. Your task is to ensure that the script adheres to the language's syntax rules and logical structure, and to provide feedback on the validity of the script.

### Goal

Your goal is to validate the provided dynamic workflow script to ensure it meets the syntax and logical requirements of the custom DSL, and provide reassurance of validity or feedback on any issues found.

### Acceptance Criteria

1. The script adheres to the syntax rules of the custom DSL.
2. The logical structure of the script is correct and coherent.
3. All variables and functions used in the script are properly defined and referenced.
4. The script does not contain any logical errors or contradictions.

### Assignment

Your assignment is to validate the provided dynamic workflow script. This involves systematically checking the script against the syntax and logical rules of the custom DSL to ensure it is correct and coherent. If the script is found to be valid, you will provide reassurance of its validity. If any issues are found, you will provide feedback on the nature of the issues and how they can be resolved. 

##### Legend for Dynamic Workflow File Syntax

- The syntax for dynamic workflow files is defined in the `orchestrate-dynamic-workflow` assignment.
- Canonical reference: [orchestrate-dynamic-workflow.md](./orchestrate-dynamic-workflow.md)
- That definition is the canonical source of truth for the syntax of dynamic workflow files.

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