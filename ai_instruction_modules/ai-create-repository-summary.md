---
description: Instructions for creating a custom repository summary file (.ai-repository-summary.md).
scope: repo-summary
prerequisites: ai-instructions-format.md
context: opt-in
---
# Creating Repository Custom Instructions

<xml>
<instructions role="repo-summarizer" scope="repo-summary">

<overview>
## Overview
Create a `.ai-repository-summary.md` file in the repository root to "onboard" the AI agent. This file reduces exploration time and errors by providing high-level context, build steps, and architecture details.
</overview>

<goals>
## Goals
-   **Reduce Errors:** Prevent CI failures and invalid code generation.
-   **Speed Up:** Minimize need for `grep`, `find`, and exploration.
-   **Standardize:** Follow [ai-instructions-format.md](./ai-instructions-format.md).
</goals>

<constraints>
## Constraints
-   **Length:** Max 2 pages (approx. 8-16k tokens).
-   **Scope:** Repository-specific only (no generic task instructions).
-   **Format:** Markdown with XML tags for structure.
</constraints>

<process>
## Creation Process
1.  **Inventory:** Scan README, CONTRIBUTING, build scripts, workflows, and config files.
2.  **Validate:** Run build/test commands to verify they work. Document exact steps and versions.
3.  **Draft:** Create `.ai-repository-summary.md` (backup existing if present).
4.  **Refine:** Iteratively update as you learn more about the repo.
</process>

<content_guide>
## Content Requirements

### 1. High-Level Details
-   Project purpose and goals.
-   Tech stack (languages, frameworks, runtimes).
-   Repo size and complexity.

### 2. Build & Validation
-   **Commands:** Bootstrap, build, test, lint, run.
-   **Validation:** Exact sequence of steps.
-   **Troubleshooting:** Known issues and workarounds.
-   **Environment:** Required setup and versions.

### 3. Project Layout
-   Key directories and files.
-   Configuration locations (linting, testing).
-   Architecture overview.
-   Dependencies not obvious from file structure.
</content_guide>

<examples>
## Examples
<see example="examples/repo-summary-examples.md" />
</examples>

<resources>
## Resources
-   [GitHub: Writing effective repository custom instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions?tool=webui#creating-a-repository-custom-instructions-file)
</resources>

</instructions>
</xml>
