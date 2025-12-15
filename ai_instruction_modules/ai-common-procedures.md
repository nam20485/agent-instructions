---
description: Standard procedures referenced via <procedure ref="category.name"/>
scope: common-procedures
---
# Common Procedures

## git-flow

### branch-naming
Kebab-case with type prefix: `feature/`, `bugfix/`, `docs/`, `chore/`. Include issue: `feature/123-add-login`.

### commit-messages
Conventional Commits: `type(scope): description`. Types: `feat|fix|docs|style|refactor|test|chore`. <50 chars, imperative.

### pr-creation
`gh pr create` → Link issue (`Fixes #123`) → Complete template → Self-review.

### pr-comment-resolution
`pwsh scripts/query.ps1 -PullRequestNumber <PR#> -Interactive` to resolve threads. Use `-ReplyEach "Fixed in <commit>"`.

## github-management

### authentication
1. Set `GITHUB_AUTH_TOKEN` env var
2. Run `pwsh scripts/gh-auth.ps1`
3. For scopes: `gh auth login --scopes <scope>`

### issue-creation
Check duplicates → Use template → Fill required fields → Assign if working.

### sub-issue-creation
**MANDATORY:** Use GitHub native sub-issues via `gh issue create --parent <id>` or `gh api`. Do NOT paste links.

## validation

### basic-validation
Build → Lint → Test.

### template-validation
All sections filled, no `[TODO]` placeholders, valid links.

## tool-usage

### powershell-execution
Use `run_in_terminal`, prefer `pwsh`, handle errors with `try...catch`.
