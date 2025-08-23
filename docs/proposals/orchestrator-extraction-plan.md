# Proposal: Extract Dynamic Workflow Orchestrator to a Dedicated Repository

## Background
The current repository contains a dynamic workflow engine (DSL parsing, planning, dry-run, real execution, logging, and VS Code task integration). This has grown beyond the scope of instruction docs. Extracting the engine into a dedicated repo isolates responsibilities, enables reuse, and allows semantic versioning of the CLI and JSONL contracts.

## Goals
- Keep the engine generic: no repo-root assumptions, no hard-coded paths.
- Preserve existing features and behavior; improve configurability for multi-repo use.
- Maintain stable, documented contracts (CLI flags, JSONL schemas, executor interface).

## Non-Goals
- Rewriting executors to call external services (can come later).
- Building a full UI or extension in this proposal (tracked separately).

## Architecture (Target)
- New repo (`ai-workflow-orchestrator`)
  - src/orchestrator.mjs (ESM)
  - src/lib/: params loader, refs helper, logger, schema
  - docs/: canonical DSL syntax, real-mode plan
  - examples/: sample-minimal workflow and fixtures
  - tests/: unit for parsing/planning; integration covering dry-run and real-mode with sample executors
- Package exports
  - CLI: `orchestrate` (bin), supports Node >= 18/20/22
  - JS API: run({ file|workflow, execPaths, workflowsPath, ... }) returning a summary

## Integration from Consumer Repos
- Provide executors in `scripts/executors/**/*`
- Keep workflows anywhere; pass `--workflows-path` to CLI or via API
- Invoke via VS Code tasks (/task) or later via `/orchestrate` (extension wrapper)

## CLI Flags (v0.1.0)
- `--workflow <name>` | `--file <path>`
- `--dry-run` | real by default
- `--strict`
- `--fixtures <path>`
- `--params <path>` (layered precedence + ref interpolation)
- `--log <jsonl>` | `--console` | `--verbose`
- `--exec-paths <paths>` (search order for executors; first match wins)
- `--workflows-path <path>` (location of workflow .md files)

## Contracts
- JSONL records: assignment/function start/end with status, durationMs; optional artifact records
- Executor interface: `export default async function run(ctx)` with ctx.meta/env/refs/logger/config/params
- Output recording under `#<step>.<assignment>` and refs resolution rules

## Phases
1) Prep
- Finalize contracts and add repo-agnostic flags
2) New Repo Bring-up
- Port core, docs, examples; add CI + tests; publish v0.1.0
3) Consumer Wiring (this repo)
- Update tasks.json to call the new CLI; keep executors/workflows local; optional shim
- Validate parity (dry-run and real mode)
4) Cutover
- Tag versions; document usage patterns

## Risks + Mitigations
- Cross-platform paths → path-safe joins, explicit flags
- Version drift → pin orchestrator version; Renovate or manual upgrades
- Adoption → optional compatibility shim with warnings

## Success Metrics
- Zero-regression runs of existing workflows (sample-minimal, new-project)
- Fully green CI on Node LTS (Linux + Windows)
- Docs are centralized and referenced from consumers
