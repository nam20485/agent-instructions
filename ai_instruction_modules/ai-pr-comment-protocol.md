---
description: Protocol for resolving PR review comments and managing review threads.
scope: pr-management
prerequisites: none
context: opt-in
---
# PR Comment Protocols

<xml>
<instructions role="pr-manager" scope="pr-management">

<overview>
## Overview
Canonical specification for resolving PR review threads. Mandatory for `pr-review-comments` and `pr-approval-and-merge` assignments.
</overview>

<workflow>
## Execution Workflow
1.  **Enumerate:** Capture snapshot of unresolved threads (GraphQL).
2.  **Process:** For each unresolved thread:
    -   Confirm fix.
    -   Reply with template (SHA + Rationale).
    -   Resolve via GraphQL mutation.
3.  **Verify:** Re-query to ensure `isResolved: true`.
4.  **Document:** Attach proof to run report.
</workflow>

<templates>
## Reply Template
-   **Format:**
    ```
    ✅ Fixed in {short_sha}
    Issue: {concern}
    Resolution: {fix details}
    ```
</templates>

<checklist>
## Safety Checklist
-   [ ] Fix builds and lints.
-   [ ] Reply describes fix clearly.
-   [ ] Commit pushed upstream.
-   [ ] Thread resolved via GraphQL (not just reply).
</checklist>

<utilities>
## Helper Utilities
-   **Script:** `scripts/query.ps1`
-   **Purpose:** Summarize, reply, and resolve threads programmatically.
-   **Usage:** See examples.
</utilities>

<troubleshooting>
## Common Pitfalls
-   **Reply != Resolve:** You MUST use the GraphQL mutation.
-   **REST API:** Do not use `resolved=true` (ignored).
-   **IDs:** Distinguish Comment ID (`PRRC_`) vs Thread ID (`PRRT_`).
</troubleshooting>

<examples>
## Examples
<see example="examples/pr-protocol-examples.md" />
</examples>

</instructions>
</xml>
