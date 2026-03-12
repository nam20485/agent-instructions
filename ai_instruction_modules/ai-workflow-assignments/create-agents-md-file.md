# Assignment: Create AGENTS.md File

## (create-agents-md-file)

### Goal

Create a comprehensive `AGENTS.md` file at the root of the repository that provides AI coding agents with the context and instructions they need to work effectively on the project. The file follows the open [AGENTS.md](https://agents.md/) format and is compatible with a wide ecosystem of coding agents including GitHub Copilot, OpenAI Codex, Aider, Cursor, Goose, and others.

### Prerequisites

- Repository has been initialized (`init-existing-repository` assignment completed)
- Application plan exists (documented in issue and/or `APP_PLAN.md`)
- Project structure has been created (`create-project-structure` assignment completed)
- Basic build/test tooling is in place or documented

> For gh project/repo permissions-related issues, see the [scripts/test-github-permissions.ps1](../../scripts/test-github-permissions.ps1) script for verification and troubleshooting, and the [scripts/gh-auth.ps1](../../scripts/gh-auth.ps1) helper script for authentication assistance.

### Acceptance Criteria

1. `AGENTS.md` file exists at the repository root
2. File contains a project overview section describing purpose and tech stack
3. File contains setup/build/test commands that have been verified to work
4. File contains code style and conventions section
5. File contains project structure / directory layout section
6. File contains testing instructions
7. File contains PR / commit guidelines (if applicable)
8. File is written in standard Markdown with clear, agent-focused language
9. Commands listed in the file have been validated by running them
10. File is committed and pushed to the working branch
11. Stakeholder approval obtained

### Assignment

You will create an `AGENTS.md` file at the root of the repository that serves as a dedicated, predictable place for AI coding agents to find the context and instructions they need. Unlike README.md (which targets human contributors), `AGENTS.md` targets coding agents with precise, actionable guidance: build steps, test commands, code conventions, and project structure details.

This file follows the open [AGENTS.md](https://agents.md/) specification and is compatible with many AI coding agents. It complements other repository documentation (README.md, `.ai-repository-summary.md`) by being specifically optimized for agent consumption.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

#### 1. Gather Project Context

1. Review existing repository documentation:
   - README.md
   - `.ai-repository-summary.md` (if created by `create-repository-summary` assignment)
   - Application plan (issue or `APP_PLAN.md`)
   - `plan_docs/` directory contents
   - Any existing CI/CD workflow files in `.github/workflows/`

2. Inventory the project's tech stack:
   - Programming language(s) and version(s)
   - Frameworks and libraries
   - Build tools and package managers
   - Testing frameworks
   - Linting / formatting tools
   - Containerization (Docker, etc.)

3. Identify the project's directory structure:
   - Source code layout and architecture pattern
   - Configuration file locations
   - Test file locations and conventions
   - Documentation locations

#### 2. Validate Build and Test Commands

1. Run each build/setup command and confirm it succeeds:
   - Dependency installation
   - Build / compile
   - Test suite execution
   - Linting / formatting checks

2. Document the exact commands that work, in the correct order
3. Note any prerequisites or environment variables required
4. Record any common pitfalls or errors and their resolutions

#### 3. Draft the AGENTS.md File

Create the file at the repository root following this structure. Include only sections that are relevant to the project; omit sections that do not apply.

```markdown
# AGENTS.md

## Project Overview

[Brief description of what the project does, its purpose, and key technologies]

## Setup Commands

- Install dependencies: `<command>`
- Build: `<command>`
- Run: `<command>`
- Run tests: `<command>`
- Lint: `<command>`

## Project Structure

[Description of directory layout and where key components live]

[Include a directory tree showing key folders and their purposes]

## Code Style

- [Convention 1, e.g. "Use strict TypeScript mode"]
- [Convention 2, e.g. "Follow C# naming conventions per .editorconfig"]
- [Convention 3]

## Testing Instructions

- [How to run the full test suite]
- [How to run a single test or subset]
- [Testing conventions: where to place tests, naming patterns]
- [Always add or update tests for changed code]

## Architecture Notes

- [Key architectural patterns in use]
- [Important design decisions or constraints]
- [Dependencies between components]

## PR and Commit Guidelines

- [Commit message format]
- [PR title format]
- [Required checks before committing]
- [Branch naming conventions]

## Common Pitfalls

- [Known issues or gotchas agents should be aware of]
- [Commands that must be run in a specific order]
- [Environment-specific considerations]

```

#### 4. Adapt for Monorepos (If Applicable)

1. If the repository is a monorepo, create additional nested `AGENTS.md` files in subproject directories
2. Each nested file should contain instructions specific to that subproject
3. The root `AGENTS.md` should reference the nested files and explain the monorepo structure

#### 5. Cross-Reference with Existing Documentation

1. Ensure `AGENTS.md` does not duplicate entire sections from README.md — instead, complement it
2. Verify consistency with `.ai-repository-summary.md` (if it exists)
3. Review and cross-reference any plan-related documents in the `plan_docs/` folder (if it exists), including the application template, tech-stack, architecture docs, and any linked supporting files
4. Link to other docs where appropriate rather than copying content
5. Ensure no conflicts between `AGENTS.md` instructions and other documentation

#### 6. Final Validation

1. Re-run all commands listed in the `AGENTS.md` to confirm they still work
2. Review the file for clarity, completeness, and accuracy
3. Ensure the file uses positive, direct instructions ("Do X" rather than "Don't do Y")
4. Confirm the file is concise — agents perform best with focused, actionable content

### Completion

1. **Verify AGENTS.md is Complete:**
   - All relevant sections are populated with accurate information
   - All listed commands have been validated by running them
   - File is well-structured and uses standard Markdown
   - File is saved at the repository root as `AGENTS.md`

2. **Present to Stakeholder:**
   - Show the complete `AGENTS.md` content
   - Demonstrate that listed commands work correctly
   - Explain how the file complements other repository documentation

3. **Stakeholder Review Process:**
   - Ask if they approve the `AGENTS.md` file
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit the `AGENTS.md` file to the working branch
   - Push changes to the remote repository
   - Mark the assignment as complete once approved
   - Proceed to next assignment

### Notes

- `AGENTS.md` is an open format — no required fields, just standard Markdown. Use headings that make sense for the project.
- The closest `AGENTS.md` to the file being edited takes precedence (important for monorepos).
- Agents will attempt to execute commands listed in the file, so ensure all commands are correct and safe.
- Treat `AGENTS.md` as living documentation — it should be updated as the project evolves.
- Reference: [https://agents.md/](https://agents.md/) for the full specification and examples.
