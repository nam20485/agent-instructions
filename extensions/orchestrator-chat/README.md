# Orchestrator Chat / Slash Commands (Design)

This folder is a placeholder for a lightweight extension or chat command shim that lets you trigger the orchestrator from chat without typing `node` commands.

## Approaches

1) VS Code Tasks + Chat `/task` (zero code)
- Add tasks (done). In chat, run: `/task Orchestrate: Real (workflow)`
- Prompts let you fill workflow, params, etc.

2) VS Code Command Palette (no code)
- Run Task via Cmd/Ctrl+Shift+P → "Run Task" → choose orchestrate task

3) VS Code Extension (thin wrapper)
- Contributes commands like `orchestrator.runWorkflow` that read quick inputs and spawn the node script, surfacing output in a terminal.
- Optional: read params file or quick input JSON inline.

4) Bot side shim (if chat provider supports calling local commands)
- Map `/orchestrate` to the task or script with parameters.

## Next
- If needed, we can scaffold a minimal extension (`yo code` or simple package.json + out/ command) that exposes 2 commands: Real (workflow) and Dry Run (workflow).
