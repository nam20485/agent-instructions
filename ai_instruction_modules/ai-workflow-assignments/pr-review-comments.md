# Assignment: PR Review Comments (pr-review-comments)

This assignment defines the exact flow to process PR review comments safely and deterministically.

- For resolving the PR comment threads read the protocol document linked below in section # Resolving Threads, Reply Content, and Commit Hygiene Protocol.
- It contains the script for resolving, templates for the replies, and general guidance on how to approach the task.

## ✅ What “Done” Means (Acceptance Criteria)
1) Every non-outdated, unresolved review comment is addressed in code when needed.
2) A unique, per-thread reply is posted explaining the fix or rationale.
3) Each reviewed thread is marked Resolved.
4) A PR-wide summary comment is posted listing all handled comments and their outcomes.
5) The PR branch contains all necessary commits and is ready for re-review.

## 🔁 Algorithm (pseudocode → concrete steps)

For all review comments `rc` in current/assigned PR where `rc` is unresolved AND not outdated:
- If rc requires a code change: implement the fix; commit with message referencing the file/area and PR.
- Post a reply to rc describing what you changed (or why no change is required).
- Resolve rc’s review thread.

After processing all `rc`:
- Post a PR-wide summary comment that lists each `rc` and its resolution.
- Notify the requester in chat that the PR is ready for re-review.

## 🏁 Completion
- [ ] All unresolved comments addressed and resolved.
- [ ] PR-wide summary comment posted.
- [ ] Notify stakeholder in chat the PR is ready for re-review.

## Resolving Threads, Reply Content, and Commit Hygiene Protocol

Reference the following documents for details on resolving threads, reply content, commit hygiene, and the script used to manage PR review threads:

- [PR Comment Protocols](../ai-pr-comment-protocol.md)
