---
description: Canonical reference for formatting AI instruction modules (XML tags, Markdown, structure).
scope: formatting-standards
prerequisites: none
---
# AI Instructions Format Guide

<xml>
<instructions role="format-specialist" scope="formatting-standards">

<overview>
## Overview
This document defines the **canonical format** for all AI instruction modules. Adherence ensures optimal parsing, context retention, and multi-agent compatibility.
</overview>

<principles>
## Core Principles
1.  **XML Tags:** Wrap all major sections in semantic tags (e.g., `<persona>`, `<workflow>`).
2.  **Markdown:** Use standard H1/H2 hierarchy, lists, and code blocks.
3.  **Concision:** Keep files under 32k tokens (target 8-16k). Consolidate where possible.
4.  **Positive Phrasing:** Use "Do X" instead of "Don't do Y".
5.  **Examples:** Use few-shot examples to demonstrate complex behaviors.
</principles>

<xml_rules>
## XML Tag Guidelines
-   **Naming:** Lowercase with underscores (e.g., `<core_behaviors>`).
-   **Nesting:** Nest tags for hierarchy.
-   **Closing:** Always close tags (`</tag>`).
-   **Common Tags:**
    -   `<persona>`: Role definition.
    -   `<hierarchy>`: Conflict resolution.
    -   `<core_behaviors>`: Expected actions.
    -   `<constraints>`: Limitations.
    -   `<workflow>`: Process steps.
    -   `<validation>`: Testing rules.
    -   `<examples>`: Few-shot examples.
</xml_rules>

<markdown_rules>
## Markdown Standards
-   **H1:** File title (one per file).
-   **H2:** Major sections (inside XML tags).
-   **Lists:** Use `-` for unordered, `1.` for ordered.
-   **Code:** Triple backticks with language ID.
-   **Links:** Relative for internal (`./file.md`), absolute for external.
</markdown_rules>

<consolidation>
## Consolidation Strategy
-   **Goal:** Reduce fragmentation and token usage.
-   **Trigger:** Consolidate if files are < 50 lines or cover overlapping topics.
-   **Limit:** Split if file approaches 32k tokens.
</consolidation>

<examples>
## Templates & Examples
<see example="examples/format-examples.md" />
</examples>

<checklist>
## Validation Checklist
-   [ ] H1 Title present.
-   [ ] YAML Front Matter present.
-   [ ] All sections wrapped in XML tags.
-   [ ] Positive instructions used.
-   [ ] Examples extracted to `examples/` if verbose.
-   [ ] Validated with token counter (if large).
</checklist>

<references>
## References
-   [Anthropic: Use XML Tags](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
-   [Anthropic: Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
</references>

</instructions>
</xml>
