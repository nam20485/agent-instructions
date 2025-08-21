# Dynamic Workflow Real Mode: Implementation Plan

This document captures the concrete plan to take the dynamic workflow runner from dry-run to fully executing assignments and functions in real mode while keeping the DSL unchanged.

## Goals

- Execute planned actions in real mode using pluggable executors
- Preserve logging parity with dry-run, adding status and duration
- Record outputs under canonical keys (e.g., #step.assignmentId) for downstream refs

## Milestones

1) Executor layer (P0)
- Dynamic resolution for assignments and functions
- Minimal contract: async run(ctx) returning { output?, vars?, artifacts? }
- Locations:
  - assignments: scripts/executors/assignments/<assignmentId>.mjs
  - functions:  scripts/executors/functions/<functionName>.mjs

2) Runtime context (P0)
- Outputs map with implicit keys: #<stepId>.<assignmentId>
- ctx.refs.get(ref) to resolve prior outputs and nested fields
- ctx.env for variables; ctx.logger for structured logging; ctx.config for env/secrets

3) Logging (P0)
- Start/end events with status: ok|error and duration ms
- Include brief payload summaries and artifact paths when available

4) First executors (P0)
- assignment: create-app-plan → create a Markdown stub artifact under logs/real-mode/
- function: get-sub-issues-from-previous-step → read referenced output or fallback to []

5) Robustness (P1)
- Config loader (env + optional orchestrator.config.json)
- Timeouts, retries (for network tasks later)
- Fail-fast vs continue-on-error flag

6) Polish (P2)
- Summary output (--summary)
- Optional concurrency for independent actions
- Golden tests for dry-run and real mode

## Contracts

- Executor signature: default export async function run(ctx)
- ctx.meta: { stepId, actionId|functionName, source, runId }
- ctx.env: Record<string, any>
- ctx.refs.get(ref: string, path?: string): any
- ctx.logger: { action|warn|error }
- ctx.config: derived from process.env and optional config file
- Return shape: { output?: any, vars?: Record<string, any>, artifacts?: Record<string, string> }

## Edge cases

- Missing executor → clear error with expected module path
- Ref to missing output → error (or warn if permissive)
- Function returns non-array for for-each → error in strict mode, warn otherwise
- Windows path handling for artifact writes

## Done when

- "sample-minimal" executes in real mode creating at least one file artifact
- JSONL logs include start/end, status and duration for each action
- Later steps can reference earlier outputs by #step.action
