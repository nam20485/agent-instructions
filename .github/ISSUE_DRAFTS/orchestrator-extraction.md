# Extract Dynamic Workflow Orchestrator to a Dedicated Repository

## Summary
Split the dynamic workflow engine (parser, planner, runner, logging, tasks integration) out of this repo into a new repository (tentative: `ai-workflow-orchestrator`). Keep `agent-instructions` as a consumer that provides workflows and repo-specific executors. Replace in-repo runner with tasks that call the new CLI.

## Motivation
- Separation of concerns: engine/tooling vs. instruction content and repo-specific executors
- Reuse and versioning: share the engine across projects with a stable CLI/JSONL contract
- Maintainability: smaller, focused repos with clear responsibilities

## Scope
In-scope:
- New repo with the orchestrator code, CLI, docs, examples, and tests
- Engine features maintained: --workflow/--file, --dry-run, --strict, --fixtures, --params, --log, --console, --verbose
- New flags for repo-agnostic integration: --exec-paths, --workflows-path
- Move canonical docs (syntax + real-mode plan) to the new repo
- Update agent-instructions tasks to call the new CLI; keep executors and workflows here

Out-of-scope (for this issue; can be follow-ups):
- VS Code extension exposing /orchestrate command (tracked in a follow-up issue after repo creation)
- Deep GitHub API integrations in executors beyond current stubs

## Deliverables
- New repo initialized with:
  - src/orchestrator (ESM), src/lib/* helpers
  - docs/: canonical syntax + real-mode plan
  - examples/: sample-minimal workflow + fixtures
  - tests/: minimal unit/integration
  - Package published (npm or GH Packages) v0.1.0
- agent-instructions updated:
  - tasks.json points to new CLI via npx
  - optional thin shim in scripts/ for backwards compatibility
  - docs: local stubs that link to canonical docs in new repo

## Phases (Plan)
- Phase 0: Prep (in-place)
  - Finalize CLI/JSONL contracts; add --exec-paths and --workflows-path flags
- Phase 1: New repo bring-up
  - Move engine code, canonical docs, examples; add CI and tests; publish v0.1.0
- Phase 2: Wire agent-instructions
  - Update tasks.json to use new CLI; keep executors/workflows local; add shim (optional)
  - Validate dry-run and real-mode parity vs. current behavior
- Phase 3: Cutover and tag
  - Tag agent-instructions migration commit; tag orchestrator v0.1.0; document usage

## Acceptance Criteria
- From agent-instructions, chat `/task Orchestrate: Real (workflow)` invokes the new CLI and produces identical logs/artifacts for `sample-minimal` and `new-project`
- Canonical docs live in the new repo; agent-instructions points to them
- Executable discovery via --exec-paths works on Windows and Linux
- CI for orchestrator is green on Node LTS

## Risks & Mitigations
- Path resolution differences across OS → explicit flags and Windows-safe path handling
- Version drift → pin orchestrator package in agent-instructions and bump intentionally
- Incremental adoption → keep optional shim to reduce breakage window

## Tasks (initial)
- [ ] Create new repo and scaffold package + CI
- [ ] Port orchestrator core and helpers; introduce --exec-paths/--workflows-path
- [ ] Move canonical docs and examples; add tests; publish v0.1.0
- [ ] Update agent-instructions tasks to use new CLI (npx)
- [ ] Add shim (optional) and doc stubs linking to new canonical docs
- [ ] Validate dry-run/real-mode parity and artifacts

## Follow-ups (file after new repo exists)
- [ ] Change main command interface from chat `/task …` to `/orchestrate …` via a tiny VS Code extension that wraps the CLI
- [ ] Author a deep background doc in the new repo capturing all design/context

## References
- Current engine: scripts/orchestrator.mjs
- Canonical syntax: ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-synatx.md
- Real-mode plan: ai_instruction_modules/ai-workflow-assignments/dynamic-workflow-real-mode-plan.md
- Chat tasks: tasks.json
