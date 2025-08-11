gh api graphql -f query='mutation($id:ID!){resolveReviewThread(input:{threadId:$id}){thread{id isResolved}}}' -f id="2265503449" -H "Accept: application/vnd.github+json"

#https://github.com/nam20485/agent-instructions/pull/3#discussion_r2265503449