# Feedback: `agent-instructions-expert.md`

**Reviewed file:** `ai_instruction_modules/agent/agent-instructions-expert.md`

**Date:** 2025-12-17

## Summary
The subagent spec is a solid start (clear intent + retrieval vs insert modes), but it needs a few correctness fixes (branch/source-of-truth, formatting) and stronger constraints to consistently produce ultra-small, high-signal answers.

## Critical fixes (correctness)

1. **Wrong default branch**
   - The file states: **Branch = `optimized` (default)**.
   - Canonical configuration in `.github/copilot-instructions.md` uses `<branch>main</branch>`.
   - **Fix:** Don’t hardcode a branch. Derive the active branch from `.github/copilot-instructions.md` and treat that as the single source of truth. If you keep a default, it should be `main`.

>User: You are correct. I changed it back to `main`

2. **Top-level markdown code fence**
   - The file appears wrapped in a top-level ````markdown … ```` fence.
   - This causes the entire document to render as a code block (harder for agents to parse/execute as instructions).
   - **Fix:** Remove the outer fence and keep the content as normal markdown.

3. **Insert mode promises “commit”**
   - It says: “Apply – Upon confirmation, commit the change.”
   - That’s often inaccurate (many flows require PRs; agent may not have commit rights).
   - **Fix:** Reword to: “prepare a patch/diff + propose placement; orchestrator applies via the repo’s approved change flow (usually PR).”

## High-value improvements (quality / brevity)

1. **Add strict response-size constraints**
   - Current: “minimal, focused response.”
   - Suggested hard rules:
     - Max **5–7 bullets** (unless explicitly requested otherwise)
     - Max **1–3 sources**
     - No tables unless asked
     - Always include **exact file path + raw URL** for any citation

2. **Add an ambiguity protocol**
   - If query is ambiguous: ask **one** clarifying question *only if required*.
   - Otherwise: proceed with a best-effort assumption and state it in **one line**.

3. **Special-case guidance for workflow queries**
   For “How do I run workflow X?” the subagent should always return:
   - workflow definition path + raw URL
   - orchestrator path + raw URL
   - ordered assignment chain
   - events + gates (validation/halts)

>User: There is a lot of required info & details in dynamic workflows and workflow assignments. So for those cases only, we should either pass the full path back and have the delegator read the file, or make that an exception to the brevity rule and allow more detailed responses. What do you think?

## Consistency / maintainability improvements

1. **Normalize paths to match actual repo layout**
   - Some references (e.g., `ai-workflow-assignments/` without `ai_instruction_modules/`) risk being inconsistent with repo conventions.
   - **Fix:** Use repo-relative paths that exist, consistently prefixed with `ai_instruction_modules/...`.

2. **Align with the repo’s “single source of truth” policy**
   - State explicitly:
     - the branch is resolved from `.github/copilot-instructions.md`
     - workflows/assignments should be fetched via *raw* URLs
     - local workspace mirrors are not authoritative

## Example corrections to consider

- Verify example paths used in the “Example Interactions” section point to real files.
  - If not, update examples to known-good references.

## Recommended next edits (actionable checklist)

- [ ] Remove outer markdown code fence from `agent-instructions-expert.md`.
- [ ] Replace hardcoded branch (`optimized`) with “derive from `.github/copilot-instructions.md`” (or change default to `main`).
- [ ] Replace “commit the change” with “propose patch/diff; apply via PR/approved flow.”
- [ ] Add strict brevity contract (bullets, max sources, citation rule).
- [ ] Add ambiguity protocol (≤ 1 clarifying question).
- [ ] Add workflow-query special-case response contract.
- [ ] Validate example file paths.
