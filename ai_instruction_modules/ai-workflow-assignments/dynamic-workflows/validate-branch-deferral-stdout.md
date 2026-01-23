# Dynamic Workflow: Validate Branch Deferral (stdout-only)

## Overview

A **stdout-only** dynamic workflow you can run to sanity-check that the "branch selection single-source-of-truth" guidance is consistent.

- This workflow intentionally performs **no assignments** and makes **no code changes**.
- It only emits log lines (via `- log: "..."`) so you can validate orchestration + DSL parsing, and manually confirm expectations.

## Script

### Inputs

- $ssot_file
    - path to the canonical branch authority doc
    - string
    - optional
    - default: `.github/copilot-instructions.md`

- $note
    - optional note to include in logs (e.g., link to PR/issue)
    - string
    - optional

### announce

- log: "[validate-branch-deferral-stdout] Starting stdout-only validation"
- log: "[validate-branch-deferral-stdout] SSOT file: {ssot_file}"
- log: "[validate-branch-deferral-stdout] Note: {note}"

### checklist

`$entrypoints` = [
  `AGENTS.md`,
  `CLAUDE.md`,
  `GEMINI.md`,
  `QWEN.md`,
  `opencode-instructions.md`,
  `.gemini/GEMINI.md`,
  `.qwen/QWEN.md`
]

For each `$file` in `$entrypoints`, you will:
- log: "[validate-branch-deferral-stdout] CHECK: {file} MUST defer branch selection to {ssot_file} (no hardcoded branch)"

- log: "[validate-branch-deferral-stdout] CHECK: ai_instruction_modules/ai-shared-agent-context.md reinforces SSOT"
- log: "[validate-branch-deferral-stdout] CHECK: ai_instruction_modules/ai-core-instructions.md points instruction/workflow lookups to agent-instructions-expert"

### suggested-manual-verification

- log: "[validate-branch-deferral-stdout] Manual verification suggestions (run locally):"
- log: "[validate-branch-deferral-stdout]   - git grep -n \"Active Branch:\\" -- '*.md'"
- log: "[validate-branch-deferral-stdout]   - git grep -n \"MUST be read from\" -- AGENTS.md CLAUDE.md GEMINI.md QWEN.md opencode-instructions.md .gemini/GEMINI.md .qwen/QWEN.md"
- log: "[validate-branch-deferral-stdout]   - verify .github/copilot-instructions.md <configuration><branch> is the only branch selector"

### done

- log: "[validate-branch-deferral-stdout] Completed stdout-only validation"

### Events

#### `pre-script-begin`
- log: "[validate-branch-deferral-stdout] Event: pre-script-begin"

#### `post-script-complete`
- log: "[validate-branch-deferral-stdout] Event: post-script-complete"

#### `on-script-failure`
- log: "[validate-branch-deferral-stdout] Event: on-script-failure"