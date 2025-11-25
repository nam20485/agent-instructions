# Optimization Strategies for Agent Instructions

## Executive Summary
The current agent instruction set suffers from "context rot" due to large file sizes, redundancy, and the inclusion of static content like templates and examples directly within instruction files. This document outlines strategies to significantly reduce token usage, improve model adherence, and streamline the instruction architecture.

## Strategy 1: Extract Static Content (Templates & Examples)
**Description:**
Currently, files like `update-from-feedback.md` contain massive inline templates (e.g., Action Plan Template) and extensive examples. These should be moved to dedicated directories (`templates/` and `examples/`). The instruction files should merely reference these files by path (e.g., "Read the template at `templates/feedback-action-plan.md`").

**Feasibility:** High
- **Effort:** Low. Mostly cut-and-paste operations.
- **Risk:** Low. Just need to ensure file paths are correct.

**Impact:** High
- **Token Reduction:** Estimated 40-60% reduction for large assignment files.
- **Clarity:** Instructions become focused on *process*, not *content*.

**Rating:** ⭐⭐⭐⭐⭐ (Essential)

---

## Strategy 2: Modularize & Centralize Common Procedures
**Description:**
Identify procedures repeated across multiple files (e.g., "How to create a GitHub issue", "Standard Git workflow", "Validation steps"). specific instructions for these should be centralized in a `common-procedures.md` or `standard-operating-procedures.md` file. Individual assignments should reference these standard procedures rather than redefining them.

**Feasibility:** Medium
- **Effort:** Medium. Requires analyzing files to find commonalities and creating a unified standard.
- **Risk:** Low.

**Impact:** Medium-High
- **Token Reduction:** Reduces redundancy across the entire corpus.
- **Consistency:** Ensures the agent performs common tasks uniformly regardless of the specific assignment.

**Rating:** ⭐⭐⭐⭐ (Highly Recommended)

---

## Strategy 3: Condense & Simplify Language
**Description:**
Rewrite instructions to use concise, imperative language. Remove conversational filler, polite preamble, and redundant explanations.
- *Before:* "You will need to review the document and then please ensure that you categorize..."
- *After:* "Review document. Categorize items."

**Feasibility:** Medium
- **Effort:** Medium. Requires manual editing of text.
- **Risk:** Low.

**Impact:** Medium
- **Token Reduction:** Estimated 10-20% per file.
- **Effectiveness:** Short, punchy instructions are often followed better by LLMs.

**Rating:** ⭐⭐⭐ (Good Practice)

---

## Strategy 4: Tiered Context Loading Architecture
**Description:**
Formalize a hierarchy for context loading to prevent overloading the window with irrelevant info.
- **Tier 1 (Core):** Always loaded. Contains identity, core behaviors, tool usage, and the "Map" of the repo.
- **Tier 2 (Role/Task):** Loaded only when a specific role or assignment is active.
- **Tier 3 (Reference):** Templates, examples, and deep-dive specifications. Loaded *on-demand* by the agent using `read_file`.

**Feasibility:** High
- **Effort:** High (Architectural change).
- **Risk:** Medium. Requires the agent to be proactive in reading Tier 3 content.

**Impact:** Very High
- **Token Reduction:** Drastic reduction in initial context size.
- **Focus:** Agent context remains relevant to the immediate task.

**Rating:** ⭐⭐⭐⭐⭐ (Transformative)

---

## Strategy 5: Eliminate Redundancy in Comprehensive Guides
**Description:**
Review "Comprehensive Guides" (e.g., `ai-workflow-development-guide.md`) to ensure they act as *indexes* or *summaries* rather than duplicating content from canonical files. If a guide repeats the full DSL syntax from `dynamic-workflow-syntax.md`, it defeats the purpose of having separate files.

**Feasibility:** Medium
- **Effort:** Medium. Content audit required.
- **Risk:** Low.

**Impact:** Medium-High
- **Token Reduction:** Prevents double-loading of heavy information.
- **Maintenance:** Single source of truth prevents conflicting instructions.

**Rating:** ⭐⭐⭐⭐ (Important for consistency)

---

## Implementation Roadmap

### Phase 1: De-bloat (Immediate)
1. Create `templates/` and `examples/` directories.
2. Refactor `update-from-feedback.md` (the largest offender) to use external references.
3. Audit top 10 largest files for similar extraction opportunities.

### Phase 2: Standardization (Short-term)
1. Create `ai-common-procedures.md`.
2. Refactor assignments to link to common procedures.
3. Apply "Condense Language" strategy to `ai-core-instructions.md`.

### Phase 3: Architecture (Long-term)
1. Restructure `ai-core-instructions.md` to strictly enforce the Tiered Loading model.
2. Audit Comprehensive Guides for redundancy.

### Phase 4: Concision & Simplification (New)
**Goal:** Apply Strategy 3 (Condense & Simplify Language) to high-impact files.
1. **Review and Rewrite Guides:**
   - `ai-application-development-guide.md`
   - `ai-workflow-development-guide.md`
   - `ai-development-environment-guide.md`
2. **Review and Rewrite Core Modules:**
   - `ai-design-principles.md`
   - `ai-testing-validation.md`
   - `ai-application-guidelines.md`
3. **Audit & General Cleanup:**
   - Scan remaining files in `ai_instruction_modules/` for conversational filler.
   - Ensure all instructions use imperative mood (e.g., "Do X" instead of "Please make sure to do X").

---

## Progress Tracking

### Completed ✅

| Task                                                     | Date       | Notes                                                                                                                       |
| -------------------------------------------------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------- |
| A5: Mark `.wip/` files `context: opt-in`                 | 2025-11-24 | 12 files no longer auto-load                                                                                                |
| A3: Create `ai-common-procedures.md`                     | 2025-11-24 | 10 procedures centralized                                                                                                   |
| Format Consistency: Workflow assignments                 | 2025-11-24 | All 37 files converted to XML format                                                                                        |
| Format Consistency: Root instruction files               | 2025-11-24 | All 31 `ai-*.md` files verified XML format                                                                                  |
| Documentation: Update `ai-workflow-development-guide.md` | 2025-11-24 | New assignment format documented                                                                                            |
| Recovery: Restore 4 lost files from git                  | 2025-11-24 | `recover-from-error.md`, `validate-assignment-completion.md`, `validate-dynamic-workflow-script.md`, `update-plan-issue.md` |
| Quick Win: `ai-comprehensive-guides-architecture.md`     | 2025-11-24 | Added `context: opt-in` (17.2KB no longer auto-loads)                                                                       |
| Quick Win: `ai-comprehensive-guides-diagrams.md`         | 2025-11-24 | Added `context: opt-in` (12.5KB no longer auto-loads)                                                                       |
| Quick Win: `ai-working-command-examples.md`              | 2025-11-24 | Added `context: opt-in` (9.0KB no longer auto-loads)                                                                        |

### In Progress 🔄

*None currently*

### Pending 📋

#### Quick Wins (Low effort)
*All quick wins completed!*

#### Medium Effort (Redundancy Reduction)
- [ ] Consolidate GitHub auth instructions (currently in 4 files)
  - Files: `ai-gh-authentication.md`, `ai-common-procedures.md`, `ai-development-environment-guide.md`, `ai-working-command-examples.md`
  - Decision needed: Which file is canonical? Others should reference it.
- [ ] Remove DSL duplication from `ai-workflow-development-guide.md` (~4KB)
  - Currently duplicates content from `dynamic-workflow-syntax.md`
  - Should use `<see ref="..."/>` pattern instead

#### Concision Pass (Phase 4)
Target files by size (largest first):
- [ ] `ai-workflow-development-guide.md` (18.0KB, 448 lines)
- [ ] `ai-quickstart.md` (8.3KB, 247 lines)
- [ ] `ai-workflow-assignments.md` (7.6KB, 123 lines)
- [ ] `ai-core-instructions.md` (5.8KB, 149 lines)
- [ ] `ai-application-development-guide.md` (4.8KB, 120 lines)
- [ ] `ai-development-environment-guide.md` (4.7KB, 128 lines)

---

## Metrics Summary

### Token Reduction Achieved
- **Net lines reduced:** ~6,959 (15,225 deletions vs 8,297 insertions)
- **Percentage:** ~30% reduction from original
- **Auto-loaded WIP files:** 12 → 0
- **Auto-loaded reference files:** 3 → 0 (additional ~38.7KB no longer auto-loads)

### Estimated Remaining Gains
| Category                           | Est. Reduction  |
| ---------------------------------- | --------------- |
| ~~Quick wins (`context: opt-in`)~~ | ~~40KB~~ ✅ Done |
| Redundancy elimination             | ~6KB            |
| Concision pass                     | ~8-10KB         |
| **Total potential remaining**      | **~15KB**       |

---

## Redundancy Analysis (Root Instruction Files)

### Topics Found in Multiple Files

| Topic                                   | Files                                                                                                                         | Recommendation                                                |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| GitHub Auth (`gh auth`, `GITHUB_TOKEN`) | `ai-gh-authentication.md`, `ai-common-procedures.md`, `ai-development-environment-guide.md`, `ai-working-command-examples.md` | Make `ai-common-procedures.md` canonical; others reference it |
| PR Creation (`gh pr create`)            | `ai-common-procedures.md`, `ai-development-environment-guide.md`, `ai-working-command-examples.md`                            | Already in common-procedures; remove from others              |
| Issue Creation                          | `ai-common-procedures.md` only                                                                                                | ✅ Already centralized                                         |
| Commit Messages                         | `ai-common-procedures.md` only                                                                                                | ✅ Already centralized                                         |

### Files That Should Reference Common Procedures
These files contain inline instructions that should be replaced with `<procedure ref="..."/>`:
- `ai-gh-authentication.md` → Could be deprecated or simplified to just reference common-procedures
- `ai-development-environment-guide.md` → Replace auth/PR sections with refs
- `ai-working-command-examples.md` → Consider moving to `examples/` dir with `context: opt-in`
