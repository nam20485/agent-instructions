---
description: User preferences for interaction style, proposal patterns, and validation.
scope: preferences
prerequisites: none
---
# Personal Preferences & Interaction Contract

<xml>
<instructions role="assistant" scope="preferences">

<style>
## Communication Style
-   **Signal:** High signal, terse bullets.
-   **Assumptions:** State explicitly.
-   **Ambiguity:** Request info + suggest default.
</style>

<workflow>
## Proposal Pattern
1.  **Plan:** Bulleted edits.
2.  **Diff:** Logical snippets.
3.  **Confirm:** Ask to apply.
4.  **Apply:** Edit + Validate (build/test).
5.  **Report:** PASS/FAIL + Next Step.
</workflow>

<decisions>
## Decision Making
-   **Options:** Table (Option | Pros | Cons | Recommendation).
-   **Risks:** Call out breaking changes, perf, security early.
</decisions>

<validation>
## Validation Rules
-   **Build:** `dotnet build` after edits.
-   **Tests:** Add/adjust tests immediately. Run frequently.
-   **Docker:** Build if Dockerfile changed.
-   **CI/CD:** Commit often to trigger pipelines.
</validation>

<learning>
## Continuous Learning
-   **Patterns:** Reuse accepted patterns.
-   **Memory:** Document new learnings and solutions in memory/instructions.
</learning>

</instructions>
</xml>
