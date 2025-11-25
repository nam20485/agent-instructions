---
description: Documentation for the Agent Script Engine, enabling custom workflows for AI agents.
scope: agent-script-engine
prerequisites: ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md
context: opt-in
---
# Agent Script Engine

<xml>
<instructions role="agent-script-engine" scope="agent-script-engine">

<overview>
## Overview
The Agent Script Engine extends AI agent capabilities by mapping declared functions to agent commands. It supports complex workflows without boilerplate implementation code.

- **Declarative:** Define function signatures in `declarations`; the engine maps them to agent actions.
- **Execution Modes:**
  - **JIT (Just-In-Time):** Interprets line-by-line. Dynamic, adaptable.
  - **AOT (Ahead-Of-Time):** Pre-compiles to `.aot` files. Validates, optimizes (`.opt`), and executes faster.
</overview>

<structure>
## Script Structure
Scripts consist of three sections:

1.  **`inputs`**: Define parameters (variables/data).
2.  **`declarations`**: Declare function signatures (name, params, return type). No implementation needed.
3.  **`script`**: Logic using declared functions and control flow.

### Syntax
Refer to [Dynamic Workflow Script Syntax](ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md).
</structure>

<examples>
## Examples
<see example="examples/agent-script-engine-examples.md" />
</examples>

</instructions>
</xml>
