---
description: Research findings on optimizing context windows and custom instructions for AI models.
scope: context-optimization
prerequisites: ai-core-instructions.md
---
# Context & Custom Instruction Optimization Research

<xml>
<instructions role="researcher" scope="context-optimization">

<overview>
## Overview
Research on optimizing context windows and custom instructions for LLMs (Claude, etc.) to improve performance and reduce complexity.
</overview>

<key_findings>
## Key Findings

### Tier 1: High Impact, Low Complexity (Implement First)
1.  **XML Tags:** Use `<tag>` for structure. Improves parsing and clarity.
2.  **Fewer, Longer Files:** Consolidate small files. Reduces overhead.
3.  **Curated Examples:** 3-5 diverse, canonical examples. Better than rules.
4.  **Positive Instructions:** "Do X" instead of "Don't do Y".
5.  **Consistent Formatting:** Standard Markdown headers and lists.

### Tier 2: High Impact, Medium Complexity
6.  **Context Compaction:** Prune irrelevant info. Focus on high-signal data.
7.  **Hierarchical Tasks:** Break down tasks into phases with acceptance criteria.
8.  **Tool Descriptions:** Include examples in tool definitions.

### Tier 3: Medium-High Impact, High Complexity
9.  **Multi-Context Workflows:** Manage state across windows for long tasks.
10. **Dynamic Context (RAG):** Retrieve relevant chunks from vector DB.
</key_findings>

<implementation>
## Implementation Roadmap
1.  **Phase 1 (Quick Wins):** XML tags, consolidate files, positive instructions, formatting, examples.
2.  **Phase 2 (Focused):** Audit content, restructure, task hierarchy, tool examples.
3.  **Phase 3 (Advanced):** Multi-context, RAG (if needed).
</implementation>

<considerations>
## Considerations
-   **Token Efficiency:** Plain text > Markdown > XML > JSON.
-   **Context Window:** Target 30-50% of max capacity. Start/End positioning is best.
</considerations>

<examples>
## Examples
<see example="examples/context-optimization-examples.md" />
</examples>

<resources>
## References
-   [Anthropic: Effective Context Engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
-   [Anthropic: Use XML Tags](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
-   [Anthropic: Claude 4 Best Practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
</resources>

</instructions>
</xml>

