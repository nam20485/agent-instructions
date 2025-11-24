# Common Procedures

<xml>
<instructions role="reference" scope="common">
This file contains centralized procedures referenced by other instruction modules.
</instructions>
</xml>

## 1. Git & GitHub Workflow

<procedure id="git-flow">
1. **Branching**:
   - Always create a new branch for your work.
   - Naming convention: `type/description` (e.g., `feat/add-login`, `fix/memory-leak`).
   - Never commit directly to `main` or `master`.

2. **Committing**:
   - Commit often with clear, descriptive messages.
   - Format: `type: description` (e.g., `feat: add login component`).
   - Include issue references if applicable (e.g., `Closes #123`).

3. **Pull Requests**:
   - Create a PR when the work is ready for review.
   - Fill out the PR template completely.
   - Link related issues.
   - Request review from appropriate team members.
</procedure>

## 2. Validation Procedures

<procedure id="validation-basic">
1. **Build**:
   - Run the build command for the project (e.g., `npm run build`, `dotnet build`).
   - Ensure there are no errors.

2. **Lint**:
   - Run the lint command (e.g., `npm run lint`).
   - Fix all linting errors.

3. **Test**:
   - Run unit tests (e.g., `npm test`, `dotnet test`).
   - Ensure all tests pass.
   - Add new tests for new functionality.
</procedure>

## 3. Tool Usage

<procedure id="tool-usage">
1. **Terminal**:
   - Use `run_in_terminal` for executing commands.
   - Chain commands with `&&` or `;` where appropriate, but prefer separate calls for clarity if complex.
   - Check output for errors.

2. **File Editing**:
   - Use `replace_string_in_file` for precise edits.
   - Use `insert_edit_into_file` only when necessary or for large insertions.
   - Always read the file first to ensure context.
</procedure>

## 4. Issue Management

<procedure id="issue-workflow">
1. **Creation**:
   - Use the appropriate template (Epic, Story, Task, Bug).
   - Fill in all required fields.
   - Add labels and milestones.

2. **Updates**:
   - Keep issues updated with progress.
   - Link PRs to issues.
   - Close issues when completed.
</procedure>
