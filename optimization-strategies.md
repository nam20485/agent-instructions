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
