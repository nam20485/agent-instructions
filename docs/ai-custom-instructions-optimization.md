---
description: Strategy and plan for optimizing custom instructions for context retention and performance.
scope: optimization-strategy
prerequisites: ai-context-optimization-research.md
context: opt-in
---
# Custom Instructions Optimization Strategy

<xml>
<instructions role="optimizer" scope="optimization-strategy">

<overview>
## Overview
This document outlines the active strategies for optimizing the instruction modules in this repository. The goal is to maximize context retention, reduce token usage, and improve instruction following across multiple AI agents.
</overview>

<references>
## Key References
-   **Research Findings:** [ai-context-optimization-research.md](./ai-context-optimization-research.md)
-   **Format Standard:** [ai-instructions-format.md](./ai-instructions-format.md)
</references>

<strategies>
## Active Strategies

### 1. Structural Optimization (XML)
-   **Action:** Wrap all content in semantic XML tags (e.g., `<instructions>`, `<overview>`, `<rules>`).
-   **Benefit:** Improves parsing and section separation for LLMs.

### 2. Content Consolidation
-   **Action:** Merge small, fragmented files into larger, cohesive modules.
-   **Benefit:** Reduces context fragmentation and file switching overhead.

### 3. Example Curation
-   **Action:** Extract verbose inline examples to dedicated files in `examples/`.
-   **Action:** Reference examples using `<see example="..." />`.
-   **Benefit:** Keeps core instructions concise; allows "lazy loading" of examples.

### 4. Positive Phrasing
-   **Action:** Convert "Don't do X" to "Do Y".
-   **Benefit:** Reduces ambiguity and cognitive load.

### 5. Front Matter
-   **Action:** Add YAML front matter (`description`, `scope`, `prerequisites`) to all files.
-   **Benefit:** Standardizes metadata for indexing and retrieval.
</strategies>

<compatibility>
## Agent Compatibility
These strategies are designed to work across:
-   GitHub Copilot
-   Claude Code CLI
-   Gemini Code Assist
-   Opencode.ai
</compatibility>

</instructions>
</xml>
