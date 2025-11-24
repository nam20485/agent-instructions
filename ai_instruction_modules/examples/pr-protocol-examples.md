<examples>
  <example id="pr-thread-enumeration">
    <description>GraphQL query to enumerate review threads.</description>
    <content>
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
    </content>
  </example>

  <example id="pr-thread-resolution">
    <description>GraphQL mutation to resolve a review thread.</description>
    <content>
```bash
gh api graphql -f query='
  mutation($thread:ID!){
      resolveReviewThread(input:{threadId:$thread}) {
        thread { id isResolved }
      }
  }
' -F thread=$THREAD_ID
```
    </content>
  </example>

  <example id="pr-reply-template">
    <description>Template for replying to a review comment.</description>
    <content>
```
✅ Fixed in {short_sha}
Issue: {short restatement of reviewer’s concern}
Resolution: {what changed and where}
Notes: {tests/validation or rationale if no code change}
```
    </content>
  </example>

  <example id="pr-script-usage">
    <description>Examples of using the `query.ps1` helper script.</description>
    <content>
```powershell
# Summarize unresolved threads
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -NoResolve

# Reply and resolve all unresolved threads
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -PullRequestNumber 9 -ReplyEach "✅ Fixed; see commits in PR #9."

# Resolve only threads in a specific file
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/query.ps1 -Path "scripts/setup-environment.ps1" -AutoResolve -ReplyEach "✅ Fixed in latest commit."
```
    </content>
  </example>
</examples>
