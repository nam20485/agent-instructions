---
description: Complete full PR approval and merge process
role: assistant
scope: workflow-assignment
---

# PR Approval and Merge

Resolve PR comments, obtain approval, merge, close issues.

## Input
- `pr_num`: Pull request number

## Output
- `result`: merged | pending | failed

## Acceptance Criteria
- `ai-pr-comment-protocol.md` executed and logged
- `pr-review-comments` acceptance criteria satisfied
- GraphQL verification: empty `pr-unresolved-threads.json`
- Evidence files attached to run report
- Stakeholder approval obtained
- Merge performed (or blocked reason documented)
- Source branch deleted (if allowed)
- Related issues closed/updated

## Workflow

### Phase 0: Pre-flight
- Confirm PR number, permissions, auth (`gh auth status`)
- Execute GraphQL snapshot, store `.pr-thread-snapshot.json`
- Log `✓ Read ai-pr-comment-protocol.md`

### Phase 1: Resolve Comments
- Follow mandated workflow: fix → push → reply → resolve thread
- Re-run snapshot until `pr-unresolved-threads.json` is empty
- Post PR summary comment with all threads, commit SHAs, outcomes
- Archive evidence in run report
- Notify orchestrator/reviewer

### Phase 2: Secure Approval
- Address follow-up questions (repeat Phase 1 if needed)
- Record stakeholder approval
- Verify CI checks green

### Phase 3: Merge & Wrap-Up
- Merge using repository strategy (squash/rebase/merge)
- Set `result`: merged | pending | failed
- On success: delete source branch, close/update issues
- Update run report

## Critical

**Before Merge:**
- `git add .` + `git commit` all changes
- `git push origin <branch>`
- Verify changes in remote PR diff

**Result Values:**
- **merged**: All resolved, approved, merged successfully
- **pending**: Ready but waiting on CI/external checks
- **failed**: Conflicts, protection rules, or technical blockers
