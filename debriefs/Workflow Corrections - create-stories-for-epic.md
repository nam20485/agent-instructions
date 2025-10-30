# Workflow Corrections for create-stories-for-epic Failure Prevention

## Overview

This document compiles targeted corrections to the AI workflow instructions in the nam20485/agent-instructions repository (branch: main, directory: ai_instruction_modules/ai-workflow-assignments/). The changes address root causes identified in the create-stories-for-epic workflow
execution failure, specifically:

• Incomplete prompt templating leading to invalid inputs and simulated (non-real) subagent executions.
• Inadequate error recovery (retries with unchanged faulty prompts).
• Lack of objective validation (self-reported success without independent checks).
• Missing post-delegation verification (no repo state query to confirm writes).

Goals of Changes:

• Ensure data propagation (e.g., full epic JSON interpolation).
• Implement tiered retries: Targeted fix → full scratch retry → escalation (max 3 attempts).
• Mandate separate, objective validation agent (e.g., qa-test-engineer).
• Add pre/post-delegation checks for robustness.
• Keep changes minimal (~150 lines added; no breaking changes; version as "v2" in comments).

Files Affected:

• orchestrate-dynamic-workflow.md
• create-stories-for-epic.md
• recover-from-error.md
• validate-assignment-completion.md
• dynamic-workflow-syntax.md

Application Instructions:

• Delegate to documentation-expert agent with this document as the prompt: "Implement these exact corrections as PRs to the canonical files. Add 'v2' notes for versioning. Validate syntax post-edit."
• Or, manually edit via GitHub UI/PRs.
• After application, test by re-running /orchestrate-dynamic-workflow - $workflow_name = create-stories-for-epic - $epic_issue_number = 20 on a test epic.

Version: v1 (Initial Correction Doc) – Date: 2025-10-29

## Root Cause Recap

The failure chain:

1. Prompt Templating Error: Orchestrator fetched epic JSON but used placeholders in subagent prompts (e.g., "[paste full epic JSON here]"), causing invalid inputs.
2. Subagent Halt & Simulation: gather-context detected missing data and halted; subagent emulated a success response without real writes (safety fallback).
3. Inadequate Recovery: on-assignment-failure → recover-from-error retried with the same faulty prompt, repeating the cycle.
4. No Verification: Parallel aggregation assumed completeness without querying repo state (e.g., linked issues count).
5. Self-Validation Bias: post-assignment-complete used the same agent type, trusting self-reports over independent checks.

These led to 3/5 real stories (#53-55), 1 partial (#52 unlinked), and 1 missing (Story 1). Corrections prevent recurrence by validating inputs, fixing retries, separating validation, and adding checks.

## Proposed Changes

### 1. Update orchestrate-dynamic-workflow.md

Purpose: Add pre-delegation prompt validation and mandate separate validation agent for objectivity.

Edit Location: "Execution Algorithm" section.

• In "Plan" Step (Add new sub-bullet after parsing):
- For each delegation prompt: Validate completeness (scan for placeholders like "[paste ...]"; re-fetch data if needed, e.g., interpolate $epic JSON via string replacement). If invalid, log error and fix before delegating. Use sequential-thinking tool to confirm: "Is prompt
data-complete? Yes/No + fix."

• In "Execute" Step (Update post-assignment-complete handling):
- Else
    **If `post-assignment-complete` event exists, execute it**:
    - Delegate `validate-assignment-completion` to a dedicated qa-test-engineer agent (not the same type as the executor, e.g., not developer if main was developer). This ensures objective, independent verification. Pass execution outputs but no self-reported success.


Rationale: Catches templating errors early; enforces separation of duties for unbiased validation.

### 2. Update create-stories-for-epic.md

Purpose: Explicitly interpolate epic JSON before the loop; add post-loop verification query to confirm creations.

Edit Location: "## Script" section.

• Before the Parallel Loop (Add new lines after $stories = getstories($epic_issue)):
# INTERPOLATE DATA: Ensure full epic JSON is available for prompts
`$full_epic_json` = JSON.stringify($epic_issue)  # Convert to string for prompt insertion
log: "Interpolated epic JSON length: {length($full_epic_json)} characters"

if `$parallel_execution` is `true`:
   # PARALLEL MODE: Create stories concurrently when safe
   For each `$story` in `$stories`, in parallel:
      $prompt = "Execute create-story-v2 with full epic JSON: {$full_epic_json} and story: {$story}"
      if ! (`$story` has already been created as a story issue linked to `$epic_issue`):
         - assign an available agent the `create-story-v2` assignment with input $prompt
         ...

• After the Parallel Loop (Add new lines before "record aggregated outputs"):
   - wait until all parallel story-creation assignments complete
   - VERIFY CREATION: Query GitHub for linked stories to #{$epic_issue_number} (use github-expert agent). Expected count: {length($stories)}. If mismatch, trigger on-assignment-failure for missing ones (with re-fetch of $epic_issue).
   - record aggregated outputs as `#create-stories-for-epic.parallel-complete`


Rationale: Guarantees data completeness in prompts; post-loop check detects gaps (e.g., 4/5) and auto-triggers recovery.

### 3. Update recover-from-error.md

Purpose: Implement tiered retries (targeted fix → scratch retry → escalation) to handle errors progressively without loops.

Edit Location: "Detailed Steps" > Replace entire "2. Follow Escalation Procedure for Persistent Errors" sub-section.

• New Full Sub-Section:
2. Follow Escalation Procedure for Persistent Errors (Tiered Retry Protocol)
- Document the error thoroughly: Capture full error message, stack trace, steps leading to failure, environment details, and attempted solutions. Log as "#recover-from-error.diagnosis".
- Attempt 1: Targeted Fix – Identify root cause (e.g., missing input via sequential-thinking). Re-fetch data if needed (e.g., re-run getepic for epic JSON) and re-template prompt with interpolated values (replace placeholders with actual data). Log: "Applied targeted fix:
Re-delegating with complete data." Retry the specific assignment.
- If Attempt 1 Fails: Attempt 2 (Scratch Retry) – Restart the entire assignment from the beginning: Re-execute pre-assignment-begin (gather-context) with fresh data fetch, then full main assignment. Treat as "from scratch" to reset state. Log: "Scratch retry initiated due to
persistent failure."
- If Attempt 2 Fails: Attempt 3 (Final Escalation) – Halt workflow, create GitHub issue with full error report (tag "bug" and "needs-investigation"), notify stakeholders (e.g., user/orchestrator), and do not proceed. No further retries. Log: "Max retries exceeded; manual
intervention required."
- Limit: Maximum 3 attempts total. Always use a different subagent instance (e.g., qa-test-engineer for validation in retry) for objectivity.


Rationale: Starts efficient (targeted for common issues like data loss), escalates to thorough (scratch for state corruption), and caps to avoid loops. Aligns with your suggestion while adding safeguards.

### 4. Update validate-assignment-completion.md

Purpose: Mandate delegation to a separate objective agent (e.g., qa-test-engineer) and add real-state queries.

Edit Location: "Assignment" section (add rule); "Detailed Steps" > "7. Report Results" (add agent note).

• New Addition (End of "Assignment" section):
The assignment ensures that: ...
- Validation is always delegated to a separate, objective agent (e.g., qa-test-engineer) independent of the main executor (e.g., not developer if main was developer). This prevents self-validation bias.

• New Addition (In "2. Verify Assignment Outputs", add sub-bullet for GitHub):
2. Verify Assignment Outputs
1. Check that all required files exist: ...
- FOR GITHUB OPERATIONS (e.g., issue creation): Use github-expert agent to query repo state (e.g., "Fetch issue #{$new_issue_number}"). Confirm existence, title, linkages (blocks #{$epic_id}), labels. If missing, mark as FAILED and trigger recover-from-error.

• New Addition (In "7. Report Results"):
1. Print validation summary to console: ...
- Note: This validation was performed by qa-test-engineer agent for objectivity. Cross-reference with main executor's outputs but prioritize independent checks (e.g., real repo query over self-report).


Rationale: Ensures unbiased verification; real queries (e.g., GitHub API) catch simulation gaps.

### 5. Update dynamic-workflow-syntax.md

Purpose: Standardize retry limits, objective validation, and prompt standards across all workflows.

Edit Location: "Orchestration Directives" section (add new sub-section at end).

• New Sub-Section:
### Error Recovery & Validation Standards
- On any failure: Follow tiered retry in recover-from-error.md (targeted fix → scratch retry → escalate after 3 attempts).
- Validation: Always use a dedicated qa-test-engineer agent for post-assignment-complete events. Input: Execution outputs + real state query (e.g., GitHub API). Output: Independent PASS/FAIL with evidence (e.g., "Repo query confirms issue #X exists").
- Prompt Standard: Include explicit data interpolation (e.g., $full_epic_json) and validation check before delegation.


Rationale: Makes these rules canonical for all dynamic workflows, preventing similar issues elsewhere.

## Implementation Notes

• Versioning: Add <!-- v2: Added input validation, tiered retries, objective validation (2025-10-29) --> at top of each edited section.
• Backward Compatibility: Changes are additive; old workflows still run but log warnings for missing validations.
• Testing: After edits, dry-run the workflow on a test epic (e.g., create a dummy #21). Check: Prompts have no placeholders, retries re-fetch, validation uses qa-test-engineer, post-loop verifies count.
• Estimated Effort: 30-45 min for PRs; test run: 10 min.
• Risks: None—enhances reliability without breaking existing flows.

This document is ready for delegation or direct use. If you need expansions (e.g., full PR diffs) or a test simulation, let me know!
Orchestrator x-ai/grok-4-fast (05:50 PM)