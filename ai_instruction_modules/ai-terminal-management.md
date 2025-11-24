---
description: Best practices for managing terminal sessions and processes.
scope: terminal-management
prerequisites: none
---
# Terminal Management Best Practices

<xml>
<instructions role="assistant" scope="terminal-management">

<core_principle>
## Core Principle: Reuse Terminal Sessions

### Default Behavior (Recommended)
- **Command:** `run_in_terminal` with `isBackground=false` (or omitted)
- **Use for:** Sequential commands, builds, tests, file operations
- **Behavior:** Reuses the same terminal session
- **Benefits:** Efficient, maintains context, cleaner process list

### Background Process Behavior (Use Sparingly)
- **Command:** `run_in_terminal` with `isBackground=true`
- **Use for:** Long-running services, servers, watch tasks, Docker containers
- **Behavior:** Creates new terminal session that runs independently
- **When to use:** Only when you need the process to continue running while executing other commands
- **⚠️ IMPORTANT:** Always stop any existing background process BEFORE starting a new one to avoid port conflicts and resource waste
</core_principle>

<examples>
## Examples
<see example="examples/terminal-management-examples.md" />
</examples>

<system_impact>
## System Impact
- **Multiple terminals waste system resources**
- **Clutters process list and VS Code terminal tabs**
- **Makes debugging and monitoring more difficult**
- **Can lead to orphaned processes**
</system_impact>

<cleanup_strategy>
## Cleanup Strategy
- Monitor running PowerShell/terminal processes
- Clean up unnecessary background processes
- Use `Get-Process` to check for resource usage
</cleanup_strategy>

</instructions>
</xml>
