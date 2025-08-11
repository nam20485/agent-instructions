# Assignment: PR Review Comments (pr-review-comments)

## 🚨 CRITICAL: Individual Replies Required
- **MUST** reply to each review comment individually (never general PR comment)
- Use: `gh api -X POST repos/owner/repo/pulls/number/comments/{comment_id}/replies`

## Goal & Acceptance Criteria
**Resolve ALL PR comments and get approval**
1. Fix issues described in each comment
2. Individual replies to each comment thread describing the fix
3. Commit all changes to PR branch (checkout PR branch first!)
4. Mark all comment threads as resolved

## Process
1. **Setup**: Checkout correct PR branch
2. **For each unresolved comment**:
   - Understand issue → plan fix → make changes → commit (reference PR & comment)
   - Reply to specific comment explaining resolution → mark resolved
3. **Iterate** until all comments resolved
4. **Complete**: Request re-review

## Technical Details

### Individual Comment Replies (Required)
```bash
gh api -X POST repos/{owner}/{repo}/pulls/{pull_number}/comments/{comment_id}/replies -f body="Your reply"
```

### Reply Format
```markdown
✅ **Fixed in commit {hash}**
**Issue**: {problem description}
**Resolution**: {fix explanation}
**Benefits**: {improvement result}
```

### Mark Threads Resolved
Use GraphQL API with `resolveReviewThread` mutation and thread ID from review threads query.

### Completion
Inform stakeholder PR is ready for review. Ensure NO unresolved comments remain.
