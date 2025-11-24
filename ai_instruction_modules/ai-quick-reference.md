---
description: Quick reference card for AI tools, workflows, and commands.
scope: quick-reference
prerequisites: none
---
# Quick AI Tool Reference Card

<xml>
<instructions role="assistant" scope="quick-reference">

<tools>
## Tools
-   **Sequential Thinking:** Use for complex problems, planning, debugging (3+ steps).
-   **Memory:** Use for context tracking, relationships, preferences, lessons learned.
</tools>

<workflow>
## Default Workflow
1.  **Start:** Check memory.
2.  **Plan:** Sequential thinking.
3.  **Execute:** Systematic approach.
4.  **Record:** Update memory.
</workflow>

<checklist>
## Quality Checklist
-   [ ] Used sequential thinking?
-   [ ] Checked/Updated memory?
-   [ ] Considered ASP.NET Core + GCP context?
</checklist>

<validation>
## Testing & Validation
-   **TDD:** Tests first.
-   **Coverage:** Target ≥80%.
-   **Build:** `dotnet build` mandatory.
-   **Test:** `dotnet test` mandatory.
</validation>

<terminal>
## Terminal Commands
-   **Tool:** `run_in_terminal`.
-   **Background:** `isBackground=true` only for long-running.
-   **Reference:** [ai-working-command-examples.md](./ai-working-command-examples.md).
</terminal>

</instructions>
</xml>
