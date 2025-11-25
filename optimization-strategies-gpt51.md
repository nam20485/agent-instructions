# GPT-5.1 Instruction Optimization Strategies

## Executive Summary

- The instruction corpus currently spans **114 markdown files** totaling **~869 KB (~620k tokens expanded)**, overwhelming GPT-5.1 context windows and causing context rot during long sessions.
- Size is concentrated: the top 10 files consume ~257 KB (~30% of total) with `update-from-feedback.md` and the workflow guides as primary offenders.
- Implementing the tiered strategy set below can realistically cut always-loaded context by 45–60% within two sprints while improving adherence through clearer structure.
- Recommendations align with Anthropic/OpenAI context-engineering research (see `ai-context-optimization-research.md`): prioritize high-signal summaries, move static artifacts out-of-band, and enable on-demand retrieval.
- The roadmap groups work into **Tier A (quick wins), Tier B (structural changes), and Tier C (architectural investments)** so we can deliver measurable savings early while setting up long-term sustainability.
## Methodology & Inputs

1. **Step 0 – Research.** Consolidated proven techniques from `ai-context-optimization-research.md`, Anthropic's Context Engineering guide, and OpenAI system prompt guidance to ground every recommendation in documented LLM behavior.
2. **Step 1 – Corpus analysis.** Measured file counts and sizes via PowerShell (see Corpus Assessment snapshot) to pinpoint bloated artifacts and quantify current-state cost.
3. **Step 2 – Brainstorm.** Facilitated workshops-within-the-doc by mapping redundant content types (templates, repeated procedures, exhaustive DSL copies) to candidate reduction levers.
4. **Step 3 – Strategy evaluation.** Rated each idea for effort, risk, token savings, and maintainability, then organized them into tiers for phased delivery.

> Constraint reminder: strategies favor automation-friendly changes so the team can rerun the optimization play whenever new instructions are added.
## Corpus Assessment Snapshot

- **Total footprint:** 888,751 bytes across 114 files inside `ai_instruction_modules/` (excludes archived docs).
- **Concentration:** 10 files drive ~30% of the size, dominated by workflow assignments and guides that ship embedded templates/examples.
- **Context impact:** Loading every "required" file plus one assignment already exceeds 200k tokens before the user shares repo context, forcing aggressive truncation by GPT-5.1.

| Rank | File                                                            | Size (KB) | Notes                                                              |
| ---- | --------------------------------------------------------------- | --------: | ------------------------------------------------------------------ |
| 1    | `.github/prompts/continue-instructions-optimizations.prompt.md` |      56.9 | Legacy mega-prompt still bundled in onboarding flows.              |
| 2    | `ai_workflow_assignments/update-from-feedback.md`               |      48.7 | Contains multi-page templates + duplicated guidance.               |
| 3    | `docs/.archived/FEEDBACK_RESPONSE_SUMMARY.md`                   |      26.6 | Reference doc rarely needed at runtime.                            |
| 4    | `ai-workflow-development-guide.md`                              |      25.6 | Comprehensive guide repeats DSL verbatim.                          |
| 5    | `ai-development-environment-guide.md`                           |      25.1 | Step-by-step environment script plus screenshots.                  |
| 6    | `ai-workflow-assignments.md`                                    |      23.2 | Index duplicates assignment metadata already in per-shortId files. |
| 7    | `ai-application-development-guide.md`                           |      21.7 | Contains entire stack primers plus examples.                       |
| 8    | `ai-comprehensive-guides-architecture.md`                       |      21.5 | Visuals and descriptions repeated in diagrams file.                |
| 9    | `ai-instructions-format.md`                                     |      20.3 | Specification + examples + templates.                              |
| 10   | `ai-context-optimization-research.md`                           |      19.9 | Research content already summarized elsewhere.                     |

*Conclusion:* Targeting these files first unlocks the majority of attainable savings without touching niche instructions.
## Evaluation Framework

### Scoring Dimensions

| Dimension       | Description                                            | Scale                                     |
| --------------- | ------------------------------------------------------ | ----------------------------------------- |
| Impact          | Estimated reduction in always-on tokens + quality lift | 1 (low) – 5 (transformative)              |
| Effort          | Engineering + documentation time including reviews     | 1 (≤1 day) – 5 (≥4 weeks)                 |
| Risk            | Chance of regressions in instruction clarity           | 1 (minimal) – 5 (high)                    |
| Maintainability | Ongoing cost to keep change healthy                    | 1 (self-serve) – 5 (requires coordinator) |

**Opportunity Score = (Impact × 1.2 + Maintainability × 0.8) / (Effort + Risk/2).** Items with score ≥1.2 move into the active roadmap.

### Tier Definitions

- **Tier A – Quick Wins:** Effort ≤ 1 sprint, low risk, score ≥1.5.
- **Tier B – Structural:** Multi-sprint projects that reshape how instructions are assembled or loaded.
- **Tier C – Architectural:** Requires new services/tooling but unlocks the largest long-term savings.
## Strategy Catalog

### Tier A – Quick Wins (0–2 weeks)

#### A1. Extract Templates & Examples
- **Problem:** `update-from-feedback.md` and similar files embed multi-page templates that are rarely customized but always loaded.
- **Actions:** Move templates/examples into `templates/` + `examples/` directories, replace inline content with `<see template="...">` references, and add a helper snippet showing how to load them on demand.
- **Impact:** 40–60% reduction for the top 5 files (~120 KB) while preserving clarity.
- **Effort / Risk:** 2 dev-days, low risk (content is copy/paste). Add automated link checker to prevent drift.

#### A2. Rewrite for Concision
- **Problem:** Many instructions repeat the same rule in prose, bullets, and examples, inflating tokens and confusing GPT-5.1.
- **Actions:** Apply a "one idea = one bullet" edit pass starting with `ai-core-instructions.md`, `ai-workflow-assignments.md`, and `ai-instructions-format.md`. Enforce style with Vale or a custom markdown lint preset.
- **Impact:** 10–20% reduction per edited file plus improved compliance thanks to direct imperatives (per Anthropic guidance).
- **Effort / Risk:** 1 week editorial sweep, low risk because edits are semantic-preserving.
#### A3. Centralize Common Procedures ✅ COMPLETE
- **Status:** Completed 2025-11-24
- **Problem:** Git/GitHub workflow, validation steps, and terminal etiquette repeat across assignments.
- **Actions:** Create `ai-common-procedures.md` with numbered sections (Issue workflow, Validation, Tool usage) and replace repeated blocks with references. Update assignments to include `<procedure ref="validation-basic"/>` style markers.
- **Result:** Created `ai-common-procedures.md` with 10 procedures; assignments updated to use `<procedure ref="..."/>` syntax.
- **Impact:** Removes ~15 KB of duplicated text per assignment and guarantees consistent wording.
- **Effort / Risk:** 3 dev-days for synthesis + link updates; risk low if we augment with automated tests ensuring references resolve.

#### A4. Standard Front Matter & Anthropic-Style XML Tagging ✅ COMPLETE
- **Status:** Completed 2025-11-24
- **Problem:** Files mix markdown, ad-hoc bold labels, and inconsistent heading levels that force models to relearn structure each time, and they often omit the `<xml>` root metadata Anthropic recommends for disambiguating instructions.
- **Actions:**
  1. Prepend every required file with a compact front matter block (purpose, scope, prerequisites) followed by consistent XML sections (`<persona>`, `<workflow>`, `<validation>`).
  2. Wrap each instruction packet in a top-level `<xml>` block whose child elements include descriptive attributes (e.g., `<instructions role="workflow" scope="tier1">…</instructions>`), mirroring [Anthropic's XML tagging guidance](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/use-xml-tags).
  3. Provide a lint rule that fails CI when tags are missing/out of order or when attributes do not describe the enclosed content.
- **Result:** All 37 workflow assignments + all 31 root instruction files verified XML format.
- **Impact:** Up to 8% token savings from removing duplicated prose, plus improved parsing accuracy and Claude compliance thanks to semantically rich XML metadata.
- **Effort / Risk:** 1 sprint for tooling; requires coordination but minimal semantic change.

#### A5. Retire Archived Artifacts from Default Context ✅ COMPLETE
- **Status:** Completed 2025-11-24
- **Problem:** Files under `docs/.archived` still appear in aggregated prompts even though they exist only for historical reference.
- **Actions:** Add a manifest flag `context: opt-in` and update loaders to exclude flagged files unless explicitly requested.
- **Result:** 12 `.wip/` files + 3 large reference files (`ai-comprehensive-guides-*.md`, `ai-working-command-examples.md`) marked `context: opt-in`. ~38.7KB no longer auto-loads.
- **Impact:** Immediate 7–10% drop in baseline tokens with zero editing work.
- **Effort / Risk:** <1 day; ensure documentation teaches agents how to fetch archived material when needed.

#### A6. Corpus-Wide Redundancy & Verbosity Sweep
- **Problem:** Most `ai-*.md` modules ship near-duplicate reminders (tool usage, acceptance-gating prose, Git workflows) even though orchestrators rarely load more than one workflow assignment or dynamic workflow at a time. This redundancy bloats token counts without adding meaning.
- **Actions:**
  1. Run a text-similarity pass (e.g., `scripts/find-dup-content.ps1`) across all `ai-*.md` files to cluster repeated paragraphs.
  2. Move shared guidance into the centralized `ai-common-procedures.md`/`ai-core-instructions.md` sections, then replace inline duplicates with `<see ref="common.git-flow"/>`-style pointers.
  3. During the rewrite, trim excessive verbosity (convert multi-sentence reminders into imperative bullets) so that each module only covers scenario-specific deltas.
  4. Add a CI check that fails when any single `ai-*.md` file exceeds its token budget without justifying unique content in front matter.
- **Impact:** Consistently removes 10–15% of tokens per module, lowers context churn when swapping assignments, and keeps attention on the few files actually loaded together.
- **Effort / Risk:** 1 sprint editorial + scripting effort; low risk because content migrates to canonical references rather than disappearing.
### Tier B – Structural Programs (2–6 weeks)

#### B1. Tiered Context Loader & Budgets
- **Description:** Enforce the Core → Role → Reference hierarchy described in `agent-instructions-optimization.md` by shipping a manifest that tags every file with `tier`, `priority`, and `avg_tokens`.
- **Key Actions:**
  1. Build `instructions.manifest.json` listing file metadata.
  2. Update loading scripts to respect a hard 80k-token budget for Tier 1 and lazily stream Tier 2/3 via `read_file` calls.
  3. Provide a CLI (`scripts/build-context.ps1`) that prints the resolved stack for auditing.
- **Impact:** Prevents uncontrolled growth and keeps GPT-5.1 primed with only high-signal content.
- **Effort / Risk:** 3–4 weeks including tooling + docs; medium risk if manifest drifts (mitigated via tests).

#### B2. Instruction Bundler Pipeline
- **Description:** Replace manual copy/paste with a build step that assembles the final prompt packet from modular fragments (core, persona, assignment, optional add-ons).
- **Key Actions:**
  - Use front matter metadata to declare dependencies.
  - Generate a single `dist/context-pack.md` artifact for production use.
  - Surface a diff summary whenever the pack changes to simplify reviews.
- **Impact:** Guarantees deterministic ordering, eliminates duplicates, and enables automated regression tests on prompt size.
- **Effort / Risk:** 1 month of scripting + CI integration; medium complexity but high payoff for governance.
#### B3. Versioning, TTLs, and Changelogs
- **Description:** Introduce semantic versions for every instruction bundle plus `expires_on` metadata so stale guidance ages out automatically.
- **Key Actions:** Store versions in the manifest, require a changelog entry for each edit, and add a CI check that fails when `expires_on` is in the past without a renewal PR.
- **Impact:** Stops "zombie" instructions from lingering indefinitely and keeps the bundle lean.
- **Effort / Risk:** 2 weeks; process-heavy but low technical risk.

#### B4. Telemetry & Context Budget Dashboards
- **Description:** Instrument the loader to log which files were injected per run, token counts, and downstream success metrics (task completion, human overrides).
- **Key Actions:** Emit structured JSON to `data/context-usage/`, aggregate via a lightweight Power BI or Grafana dashboard, and set alerts when baseline tokens exceed thresholds.
- **Impact:** Turns optimization into a measurable discipline rather than one-off cleanups.
- **Effort / Risk:** 2–3 weeks; medium complexity (needs logging infra) but critical for continuous improvement.

#### B5. Guide-as-Index Refactor (from `optimization-strategies.md` Strategy 5)
- **Description:** Reshape `ai-workflow-development-guide.md`, `ai-application-development-guide.md`, and `ai-development-environment-guide.md` into lightweight navigation layers that reference canonical specs instead of reprinting them. Keep orientation tables, troubleshooting matrices, and "when to use" cues, but relocate duplicated DSL, stack primers, and examples into their authoritative files or a shared `examples/` directory.
- **Key Actions:**
  1. Audit each comprehensive guide to tag sections that duplicate canonical files and extract that content into the source document (or template/example files) with `<see>` references.
  2. Add an automated lint or CI check that fails if guides contain blocks exceeding a set token threshold without an outbound reference, ensuring they stay summary-first.
  3. Update the manifest to mark guides as Tier 2 summaries so the loader can prefer the slimmer versions by default.
- **Impact:** Medium-high. Eliminates double-loading of DSL/spec content (~20–25 KB) and clarifies the single source of truth while keeping discoverability high.
- **Effort / Risk:** Medium effort (1 sprint) and low risk because content remains available in canonical files. Aligns directly with Gemin's Strategy 5 recommendation.
### Tier C – Architectural Investments (6–12 weeks)

#### C1. Retrieval-Augmented Instruction Fetching
- **Concept:** Store instructions, templates, and historical decisions in a vector index (e.g., Azure Cognitive Search, pgvector). Inject only the top-K relevant chunks per task.
- **Benefit:** Shrinks default context to the bare minimum while still giving agents instant access to deep references.
- **Considerations:** Requires embedding pipeline, cache invalidation, and security review to avoid leaking sensitive content. High impact once mature.

#### C2. Progressive Multi-Window Workflow
- **Concept:** Split work into context windows (Setup → Build → Validate) with machine-readable handoff objects (todo lists + state snapshots). GPT-5.1 starts each window fresh, eliminating cumulative drift.
- **Benefit:** Maintains clarity on long assignments and allows automatic rollback to earlier windows if guardrails fail.
- **Considerations:** Needs orchestrator enhancements plus serialization format design.

#### C3. Automated Summarization & Verification Loop
- **Concept:** Nightly job runs GPT-5.1/GPT-4o-mini to summarize each large file into a <1k token abstract, then diff-checks the summary against the canonical source.
- **Benefit:** Summaries power Tier 1 context; full docs stay as references. Also surfaces outdated rules when summary validation fails.
- **Considerations:** Requires evaluation harness and reviewer workflow to prevent hallucinated summaries from shipping.
## Roadmap & Next Steps

| Phase                            | Timeline   | Focus                                                          | Key Deliverables                                                               |
| -------------------------------- | ---------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **Phase 0 – Prep**               | Week 0     | Approve strategy list, create owners, align on manifest schema | RACI, signed-off manifest design, backlog grooming                             |
| **Phase 1 – Quick Wins**         | Weeks 1–2  | Execute Tier A (A1–A5)                                         | Template repo, lint rules, archived manifest flags                             |
| **Phase 2 – Structural**         | Weeks 3–6  | Implement Tier B (B1–B4) sequentially                          | Loader manifest, bundler pipeline, telemetry dashboard                         |
| **Phase 3 – Pilot Architecture** | Weeks 7–12 | Prototype Tier C initiatives starting with retrieval           | Vector index PoC, multi-window orchestration design doc, automated summary job |

**Immediate Actions:**
1. Stand up a short workshop to prioritize which Tier A item to tackle first (recommend A1 + A5 simultaneously).
2. Assign tooling owner for manifest + bundler (likely `scripts/` maintainer).
3. Define success metrics (next section) and baseline them before changes land.
## Success Metrics & Guardrails

| Metric                                      | Baseline | Target           | Notes                                                                                   |
| ------------------------------------------- | -------- | ---------------- | --------------------------------------------------------------------------------------- |
| Always-loaded tokens (Tier 1)               | ~210k    | ≤110k            | Measured via bundler output; fail build if exceeded.                                    |
| Instruction compliance defects per 10 tasks | 3.2      | ≤1               | Track via retro notes + PR feedback.                                                    |
| Context reload time for new task            | 6–8 min  | ≤3 min           | Faster priming correlates with throughput.                                              |
| Archived/reference fetches per task         | <1       | ≥2 (when needed) | Higher number means agents are proactively pulling optional docs instead of preloading. |

Guardrails:
- Every change must preserve authoritative content; add regression tests that diff the semantic outlines before/after.
- Document fallback instructions ("If template missing, load from ...") to avoid runtime confusion while files move.
- Run a shadow evaluation (existing vs optimized instructions) on at least 5 representative workflow assignments before defaulting to the new pack.

## Crosswalk with `optimization-strategies.md`

The Gemin-authored `optimization-strategies.md` file (produced from the same `agent-instructions-optimization.md` brief) surfaces a compact list of five recommendations. The table below shows how this GPT-5.1 review incorporates each item:

| `optimization-strategies.md` Strategy    | Status in this document         | Notes                                                                            |
| ---------------------------------------- | ------------------------------- | -------------------------------------------------------------------------------- |
| 1. Extract static templates/examples     | ✅ Covered by Tier A **A1**      | Same action set, plus manifest/link-check enforcement described here.            |
| 2. Centralize common procedures          | ✅ Covered by Tier A **A3**      | We extend Gemin's idea with `<procedure ref>` markers and automated tests.       |
| 3. Condense language                     | ✅ Covered by Tier A **A2**      | Adds Vale/custom linting guidance for sustained enforcement.                     |
| 4. Tiered context loading                | ✅ Covered by Tier B **B1**      | We expand scope with manifests, CLIs, and token budgets.                         |
| 5. Remove comprehensive-guide redundancy | ✅ Now included as Tier B **B5** | New section added above to implement Gemin's guide-to-index refactor suggestion. |

Additionally, Gemin's three-phase roadmap (De-bloat → Standardize → Architect) maps directly to the Tier A/B/C track in this document, so delivery sequencing stays aligned while adding richer telemetry and governance requirements.

## Related Documentation

| Document                                                                        | Description                                                                                                                         |
| ------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| [Context Delivery Strategies](docs/context-delivery-strategies.md)              | Detailed implementation plans for branch parameterization, RAG-based MCP server, and hybrid approaches for dynamic context delivery |
| [Context Optimization Research](docs/ai-context-optimization-research.md)       | Research notes on Anthropic/OpenAI context engineering best practices                                                               |
| [Custom Instructions Optimization](docs/ai-custom-instructions-optimization.md) | Analysis of custom instruction patterns and optimization opportunities                                                              |

## Closing Notes

- This document fulfills the plan from `agent-instructions-optimization.md` by (1) researching proven reduction methods, (2) analyzing the current corpus, (3) brainstorming actionable strategies, and (4) documenting each option with cost/benefit tiers.
- Next review checkpoint should occur after Phase 1 delivery to verify actual token savings vs projections and to decide whether Tier B work proceeds as-is or requires scope adjustment.
- Keep `optimization-strategies.md` as historical context; treat this GPT-5.1-focused plan as the living source going forward.
