---
description: Centralized standard operating procedures for common tasks
scope: common-procedures
role: System Orchestrator
---

<instructions role="assistant" scope="common-procedures">
  <overview>
    <purpose>
      Defines standard procedures for recurring tasks to ensure consistency and quality across all workflow assignments.
      Assignments reference these procedures using `<procedure ref="category.procedure-name"/>`.
    </purpose>
  </overview>

  <procedures>
    <category name="git-flow">
      <procedure name="branch-naming">
        <title>Branch Naming Convention</title>
        <steps>
          <step>Use kebab-case.</step>
          <step>Prefix with type: `feature/`, `bugfix/`, `docs/`, `chore/`.</step>
          <step>Include issue number if applicable: `feature/123-add-login`.</step>
        </steps>
      </procedure>

      <procedure name="commit-messages">
        <title>Commit Message Standard</title>
        <steps>
          <step>Use Conventional Commits format: `type(scope): description`.</step>
          <step>Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.</step>
          <step>Keep subject under 50 characters.</step>
          <step>Use imperative mood ("Add feature" not "Added feature").</step>
        </steps>
      </procedure>

      <procedure name="pr-creation">
        <title>Pull Request Creation</title>
        <steps>
          <step>Create PR using `gh pr create`.</step>
          <step>Link to related issue using `Fixes #123` or `Connects to #123`.</step>
          <step>Fill out the PR template completely.</step>
          <step>Self-review code before requesting review.</step>
        </steps>
      </procedure>

      <procedure name="pr-comment-resolution">
        <title>Resolving PR Review Comments</title>
        <steps>
          <step>Address the feedback in the code.</step>
          <step>Use the `scripts/query.ps1` PowerShell script to manage threads.</step>
          <step>Run `pwsh scripts/query.ps1 -PullRequestNumber <PR#> -Interactive` to review and resolve threads.</step>
          <step>Use `-ReplyEach "Fixed in <commit>"` to auto-reply before resolving.</step>
          <step>MANDATORY: Do not manually resolve threads in the UI if the script can be used.</step>
        </steps>
      </procedure>
    </category>

    <category name="github-management">
      <procedure name="authentication">
        <title>GitHub Authentication</title>
        <steps>
          <step>Ensure `GITHUB_AUTH_TOKEN` environment variable is set with a valid PAT.</step>
          <step>Run `pwsh scripts/gh-auth.ps1` to authenticate or re-authenticate.</step>
          <step>If additional scopes are needed, first try running `gh auth login --scopes <scope>` to request them interactively.</step>
          <step>If interactive login fails or is unavailable, ask the user to update the `GITHUB_AUTH_TOKEN` with a new PAT.</step>
          <step>Do not rely on interactive browser login in headless environments.</step>
        </steps>
      </procedure>

      <procedure name="issue-creation">
        <title>Issue Creation</title>
        <steps>
          <step>Check for duplicates first.</step>
          <step>Use the appropriate issue template.</step>
          <step>Fill all required fields.</step>
          <step>Assign to yourself if you are working on it immediately.</step>
        </steps>
      </procedure>

      <procedure name="issue-linking">
        <title>Linking Issues and Projects</title>
        <steps>
          <step>Add issue to the repository's GitHub Project.</step>
          <step>Assign to the correct Milestone (e.g., "Phase 1").</step>
          <step>Apply appropriate labels (e.g., `bug`, `enhancement`, `documentation`).</step>
          <step>If it's a sub-task, link to the parent issue using "Parent issue: #123".</step>
        </steps>
      </procedure>

      <procedure name="sub-issue-creation">
        <title>Creating Sub-Issues</title>
        <steps>
          <step>MANDATORY: Use GitHub's native sub-issue feature. See [Adding sub-issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues).</step>
          <step>Do not just paste a link in the body (e.g., "Child issue: #123").</step>
          <step>Use `gh issue create --parent <parent-issue-id>` (if available) or `gh api` to create the relationship.</step>
          <step>Link the sub-issues to the appropriate milestone.</step>
          <step>List sub-issues in the relationships section to indicate they block the main issue. See [Creating issue dependencies](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies).</step>
        </steps>
      </procedure>
    </category>

    <category name="validation">
      <procedure name="basic-validation">
        <title>Basic Validation Steps</title>
        <steps>
          <step>Run build to ensure no compilation errors.</step>
          <step>Run linter to ensure code style compliance.</step>
          <step>Run unit tests to ensure no regressions.</step>
        </steps>
      </procedure>

      <procedure name="template-validation">
        <title>Template Validation</title>
        <steps>
          <step>Verify all sections of the template are filled.</step>
          <step>Ensure no placeholders (e.g., `[TODO]`) remain.</step>
          <step>Check that links to other documents are valid.</step>
        </steps>
      </procedure>
    </category>

    <category name="tool-usage">
      <procedure name="powershell-execution">
        <title>PowerShell Execution</title>
        <steps>
          <step>Use `run_in_terminal` tool.</step>
          <step>Prefer `pwsh` over `powershell` (Windows PowerShell).</step>
          <step>Handle errors using `try...catch` in scripts.</step>
        </steps>
      </procedure>
    </category>
  </procedures>
</instructions>
