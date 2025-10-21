# PR Comment Protocols

<overview>
This module documents the protocols for managing PR review comments and how/when to use the `scripts/query.ps1` helper.
</overview>

<reply_comments>
## Reply Comments

### 📝 Reply template (per comment)
```
✅ Fixed in {short_sha}
Issue: {short restatement of reviewer’s concern}
Resolution: {what changed and where}
Notes: {tests/validation or rationale if no code change}
```

### 🧪 Safety checklist before marking Resolved
- [ ] Change builds and lints locally.
- [ ] Any scripts/workflows updated run successfully (dry run if applicable).
- [ ] The reply clearly explains the fix and references the area changed.
- [ ] The thread is not “outdated” (if outdated, reply is optional; don’t mark resolved unless still relevant).

### 📦 Commit hygiene
- Commit to the PR branch; keep diffs minimal and scoped.
- Reference the area and optional thread context in the message.
   - Example: `fix(setup-environment.ps1): use Get-PackageManager; pin pnpm via env or package.json`
   - 
## 🧰 Commands and minimal tooling

Use GitHub CLI. Authenticate once with repo scope: `gh auth login`.

- List review threads (GraphQL):
   - Query: `reviewThreads(first: 100)` on the pullRequest, then filter unresolved and not outdated in your script or tooling.

- Reply to a specific review comment (Required):
   - REST: `POST /repos/{owner}/{repo}/pulls/comments/{comment_id}/replies`
   - CLI:
      ```bash
      gh api -X POST \
         repos/{owner}/{repo}/pulls/comments/{comment_id}/replies \
         -f body="✅ Fixed in {short_sha}. Issue: … Resolution: …"
      ```

- Resolve a review thread by ID (GraphQL mutation):
   - `resolveReviewThread(input:{threadId:$threadId}) { thread { id isResolved } }`

- Post a PR-wide summary comment:
   - CLI:
      ```bash
      gh pr comment {pull_number} -b "<markdown summary>"
      ```

   - Or from a prepared file (recommended):
      ```bash
      gh pr comment {pull_number} -F pr-summary.md
      ```

Note: You only need a helper to 1) enumerate threads (for your own loop), 2) reply by comment_id, and 3) resolve by thread_id. Avoid bulk auto-resolution unless explicitly requested.
</reply_comments>

<utilities>
# AI PR Utilities

This module documents the local PowerShell helper for managing PR review threads and how/when to use it.

## Script: `scripts/query.ps1`

Purpose:
- Summarize unresolved review threads for a specific pull request
- Optionally reply to the latest comment in each unresolved thread
- Optionally resolve all unresolved review threads

Requirements:
- GitHub CLI (gh) installed and authenticated with repo scope
- Access to the repository (owner/repo) and PR number

### Parameters
- Owner (string, default: `nam20485`)
- Repo (string, default: `agent-instructions`)
- PullRequestNumber (int, default: `9`)
- ThreadId (string) — Resolve only the thread with this GraphQL ID
- Path (string) — Filter threads where the file path contains this text
- BodyContains (string) — Filter where the latest comment contains this text
- Interactive (switch) — Prompt to resolve one thread at a time
- AutoResolve (switch) — Resolve selected threads automatically without prompting
- NoResolve (switch) — Write summary only, do not resolve
- DryRun (switch) — Show what would be resolved
- VerboseLogging (switch) — Print gh commands
- ReplyEach (string) — Message to reply on the latest comment of each unresolved thread prior to resolving

### Typical Scenarios
- Before requesting re-review, ensure all threads are addressed:
  1) Generate a quick summary to see what’s left.
  2) Optionally post a brief reply indicating how/where each was fixed.
  3) Resolve all threads.

### Examples
- Summarize unresolved threads:
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -NoResolve
```

- Dry run (list which threads would be resolved):
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -DryRun
```

- Reply and resolve all unresolved threads for a specific PR:
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -PullRequestNumber 9 -ReplyEach "✅ Fixed; see commits in PR #9." 
```

- Override owner/repo:
- Resolve a single thread by ID interactively:
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -ThreadId MDExOlB1bGxSZXF1ZXN0UmV2aWV3VGhyZWFkLTEyMzQ= -Interactive
```

- Resolve only threads in a given file path, no prompt:
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -Path "scripts/setup-environment.ps1" -AutoResolve -ReplyEach "✅ Fixed in latest commit."
```
```
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -Owner myorg -Repo myrepo -PullRequestNumber 123
```

### Notes
- The script writes a markdown summary to `pr-review-threads-summary.md` in the repo root.
- Thread resolution uses GraphQL `resolveReviewThread`; replies use `gh api` to the replies endpoint.
- This utility aligns with the guidance in `ai_workflow_assignments/pr-review-comments.md` (individual replies and resolving threads). Consider pairing its use with commit messages referencing the thread resolutions.
</utilities>
