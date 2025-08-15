# Assignment: PR Review Comments (pr-review-comments)

This assignment defines the exact flow to process PR review comments safely and deterministically.

## ✅ What “Done” Means (Acceptance Criteria)
1) Every non-outdated, unresolved review comment is addressed in code when needed.
2) A unique, per-thread reply is posted explaining the fix or rationale.
3) Each reviewed thread is marked Resolved.
4) A PR-wide summary comment is posted listing all handled comments and their outcomes.
5) The PR branch contains all necessary commits and is ready for re-review.

## 🔁 Algorithm (pseudocode → concrete steps)

For all review comments rc in current/assigned PR where rc is unresolved AND not outdated:
- If rc requires a code change: implement the fix; commit with message referencing the file/area and PR.
- Post a reply to rc describing what you changed (or why no change is required).
- Resolve rc’s review thread.

After processing all rc:
- Post a PR-wide summary comment that lists each rc and its resolution.
- Notify the requester in chat that the PR is ready for re-review.

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

## 📝 Reply template (per comment)
```
✅ Fixed in {short_sha}
Issue: {short restatement of reviewer’s concern}
Resolution: {what changed and where}
Notes: {tests/validation or rationale if no code change}
```

## 🧪 Safety checklist before marking Resolved
- [ ] Change builds and lints locally.
- [ ] Any scripts/workflows updated run successfully (dry run if applicable).
- [ ] The reply clearly explains the fix and references the area changed.
- [ ] The thread is not “outdated” (if outdated, reply is optional; don’t mark resolved unless still relevant).

## 📦 Commit hygiene
- Commit to the PR branch; keep diffs minimal and scoped.
- Reference the area and optional thread context in the message.
   - Example: `fix(setup-environment.ps1): use Get-PackageManager; pin pnpm via env or package.json`

## 🏁 Completion
- [ ] All unresolved comments addressed and resolved.
- [ ] PR-wide summary comment posted.
- [ ] Notify stakeholder in chat the PR is ready for re-review.
