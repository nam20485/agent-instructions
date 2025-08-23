# Orchestrator Extraction Appendix

This appendix captures deeper background and context that does not belong in the issue but should be retained for future reference.

## Current Capabilities
- DSL parsing: steps, arrays (single- and multi-line), for-each, function calls, output recording convention
- Planning: IR of actions (assignments/functions) with warnings/errors in strict mode
- Dry-run: JSONL emission and console logging with a unified logger
- Real mode: dynamic executors, runtime outputs and refs, status/duration, artifacts
- Params: layered precedence (defaults < assignments < steps < actions) + `${#ref}` interpolation
- Chat integration: VS Code tasks (runnable via `/task ...` in chat)

## Artifacts/Logs
- Logs directory: `logs/*.jsonl` and `logs/real-mode/*.md`
- JSONL record types: assignment-start/end, function-start/end, artifact, error, warning

## Design Choices
- Minimal DSL changes; conventions over ceremony (output recording implied by step + assignment)
- No global mutable state outside the runner; ctx.env/outputs/refs scoped to a run
- Executors are repo-specific; engine remains generic

## Potential Future Enhancements
- Summary generator: `--summary` producing a Markdown recap (counts, durations, artifacts)
- Concurrency options: parallelize independent actions with a small DAG
- Retry policies and per-step timeouts in exec layer
- Pluggable transport for logs (e.g., write to S3 or artifact store)
- Strict schema validation for params/fixtures via JSON Schema

## Extension Path (/orchestrate)
- A tiny VS Code extension can wrap the CLI and expose commands `/orchestrate real <workflow>` and `/orchestrate dry <workflow>` for a seamless chat UX.
- Extension would simply prompt for inputs and spawn the CLI, piping logs to the output channel.
