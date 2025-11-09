# Assignment: PR Review Comments (pr-review-comments)

This assignment defines the exact flow to process PR review comments safely and deterministically. **You must execute the full workflow specified in [`ai-pr-comment-protocol.md`](../ai-pr-comment-protocol.md) before this assignment can be marked complete.**

## ✅ Acceptance Criteria (All Must Pass)
1. Every non-outdated review thread has an implemented fix (when required), a unique reply referencing the change, and has been explicitly resolved via the GraphQL mutation or approved UI action.
2. The canonical verification artifacts exist:
	- `pr-unresolved-threads.json` (or equivalent) is present and empty.
	- Final GraphQL query output showing `isResolved: true` for all threads is attached to the run report.
3. A PR-wide summary comment is posted that enumerates each review thread (link or ID), the associated commit SHA, and the final disposition (fixed / explained).
4. `pr-review-threads-summary.md` (or the helper output from `scripts/query.ps1`) is updated/committed with the latest run details.
5. The PR branch contains all required commits, is pushed to the remote, and the PR is ready for re-review (no pending local changes).
6. Stakeholder/orchestrator is notified with links to the summary comment and verification artifacts.

Failure to satisfy any criterion above requires additional work—do not proceed to approval or merge.

## 🔁 Required Execution Flow

1. **Read & Acknowledge Protocol**
	- Log `✓ Read ai-pr-comment-protocol.md` before touching review feedback.

2. **Enumerate Threads**
	- Run the GraphQL snapshot command from the protocol and store the result (defaults to `.pr-thread-snapshot.json`).

3. **Process Each Thread**
	- For every unresolved, non-outdated thread:
	  - Implement and commit the fix (or document why no change is required).
	  - Reply using the mandated template, referencing the commit SHA.
	  - Call the `resolveReviewThread` mutation with the correct thread ID.

4. **Re-verify & Capture Evidence**
	- Re-run the snapshot query; pipe unresolved results into `pr-unresolved-threads.json`.
	- If the file is non-empty, continue iterating—threads remain unresolved.
	- Archive the GraphQL output and helper summaries for the run report.

5. **Publish Summary & Notify Stakeholders**
	- Post a PR-wide summary comment listing every thread (link or ID), resolution status, and supporting commit SHA.
	- Ping the requester/orchestrator with the summary link plus locations of evidence files.

## 🏁 Completion Checklist
- [ ] Acceptance criteria 1–6 above are satisfied with recorded evidence.
- [ ] PR-wide summary comment URL shared with stakeholders.
- [ ] Verification artifacts committed or attached as required.
- [ ] Stakeholder notified that the PR is ready for re-review.

Refer to the canonical protocol for command examples and failure modes:
- [`ai-pr-comment-protocol.md`](../ai-pr-comment-protocol.md)
