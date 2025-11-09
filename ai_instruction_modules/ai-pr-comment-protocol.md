# PR Comment Protocols

<overview>
This module is the **canonical specification** for resolving PR review comment threads. Every assignment that touches review feedback (for example `pr-review-comments` or `pr-approval-and-merge`) is contractually required to follow this workflow. If you skip any step in this document, the orchestrator will treat the run as failed.
</overview>

## 🔒 Non-Negotiable Execution Order

You MUST perform the following steps for every unresolved, non-outdated review thread. Treat this as executable pseudocode—missing any step violates downstream acceptance criteria.

1. **Enumerate all review threads**
    - Capture a fresh snapshot _before_ making changes:
       ```bash
       gh api graphql -f query='
          query($owner:String!, $repo:String!, $pr:Int!) {
             repository(owner:$owner, name:$repo) {
                pullRequest(number:$pr) {
                   reviewThreads(first:100) {
                      nodes {
                         id
                         isResolved
                         isOutdated
                         comments(last:1) { nodes { id body author { login } } }
                      }
                   }
                }
             }
          }
       ' -f owner=$OWNER -f repo=$REPO -F pr=$PR_NUMBER > .pr-thread-snapshot.json
       ```
    - Drive the entire workflow from this dataset. Do **not** rely on UI badge counts.

2. **Process each unresolved, non-outdated thread** (`isResolved == false` _and_ `isOutdated == false`):
    1. Confirm the fix is implemented, committed, and pushed.
    2. Post a reply using the template below, referencing the commit SHA or rationale.
         ```bash
         gh api -X POST \
            repos/$OWNER/$REPO/pulls/comments/$COMMENT_ID/replies \
            -f body="✅ Fixed in ${SHORT_SHA}. Issue: … Resolution: …"
         ```
    3. Explicitly resolve the thread via GraphQL:
         ```bash
         gh api graphql -f query='
            mutation($thread:ID!){
               resolveReviewThread(input:{threadId:$thread}) {
                  thread { id isResolved }
               }
            }
         ' -F thread=$THREAD_ID
         ```

3. **Re-verify immediately**
    - Re-run the enumeration query and filter unresolved results:
       ```bash
       gh api graphql -f query='…same as above…' \
          -f owner=$OWNER -f repo=$REPO -F pr=$PR_NUMBER |
          jq '.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == false and .isOutdated == false)'
       ```
    - Redirect the `jq` output to `pr-unresolved-threads.json`. If the file is non-empty, keep working—you are not finished.

4. **Document proof before requesting re-review**
    - Attach the latest GraphQL output (or the empty `pr-unresolved-threads.json`) to the run report.
    - Prepare a PR-wide summary comment listing every thread ID (or permalink) with its outcome and commit SHA.
    - Store any helper output (e.g., `pr-review-threads-summary.md`) under version control per repository policy.

5. **Escalate on tooling failure**
    - If any CLI command errors, stop. Fix authentication, parameters, or connectivity issues before proceeding.
    - Do **not** assume the thread resolved—explicit confirmation is mandatory.

> ⚠️ **Critical:** Replying to a comment does **not** resolve the thread. Only the GraphQL mutation above (or manually clicking “Resolve conversation” in the UI) toggles `isResolved` to `true`.

## 📝 Reply Template & Safety Checklist

### Reply template (per comment)
```
✅ Fixed in {short_sha}
Issue: {short restatement of reviewer’s concern}
Resolution: {what changed and where}
Notes: {tests/validation or rationale if no code change}
```

### Safety checklist before marking resolved
- [ ] Change builds and lints locally.
- [ ] Any scripts/workflows touched still run (dry run when applicable).
- [ ] Reply clearly describes the fix (or rationale) and references the location.
- [ ] Thread is not marked “outdated”. (If outdated, reply when helpful but do **not** resolve unless it still applies.)
- [ ] Matching commit is pushed upstream **before** the mutation runs.

### Commit hygiene
- Keep diffs scoped and reference the related area in the message (e.g., `fix(setup-environment.ps1): pin pnpm via env var`).
- Prefer single-responsibility commits tied directly to the reply you post.

## ✅ Verification & Evidence Checklist (Gate to Merge/Approval)

You may not advance to approval or merge until **every** box is checked:

- [ ] `pr-unresolved-threads.json` exists and is empty (or contains only `[]`).
- [ ] Final GraphQL query output demonstrating `isResolved: true` for all threads is attached to the run report.
- [ ] PR-wide summary comment posted with per-thread outcomes, links, and commit SHAs.
- [ ] Local helper output (for example `pr-review-threads-summary.md`) archived in the repository.

If any item is unchecked, the assignment is incomplete.

## 🧰 Command Reference & Tooling

Use GitHub CLI (`gh auth login` with repo scope) as the default interface.

- **Enumerate review threads:** `reviewThreads(first:100)` GraphQL query (see Step 1).
- **Reply to a review comment:** `POST /repos/{owner}/{repo}/pulls/comments/{comment_id}/replies` via `gh api`.
- **Resolve a thread:** `resolveReviewThread` GraphQL mutation (Step 2.3).
- **Post PR-wide summary comment:** `gh pr comment {pull_number} -b "<markdown summary>"` or use `-F` with a prepared file.

Helper script (`scripts/query.ps1`):
- Summarises unresolved threads, posts optional replies, and resolves threads programmatically.
- Supports dry-run, per-thread targeting, and filtered resolution (see script header for parameters).
- Always capture the generated `pr-review-threads-summary.md` artifact.

## ⚠️ Common Failure Patterns (and how to avoid them)

1. **Assuming reply = resolution** – Only the GraphQL mutation (or manual UI resolve) sets `isResolved` to `true`.
2. **Using REST `resolved=true`** – The REST API ignores the flag. Use the mutation shown above.
3. **Mixing comment IDs and thread IDs** – Comment IDs begin with `PRRC_`; thread IDs begin with `PRRT_`. The mutation needs the thread ID from the enumeration query.
4. **Skipping verification artifacts** – Without re-querying and storing the empty result, you have no proof. Downstream assignments will fail acceptance criteria.
5. **Bulk auto-resolving without replies** – Every thread needs an explanatory reply prior to resolution. Automated bulk resolution without communication fails review.

When unsure, restart at Step 1 and re-run the entire workflow. If it is not recorded, it did not happen.

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
