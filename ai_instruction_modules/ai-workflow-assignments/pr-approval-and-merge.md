---
description: Complete the full PR approval and merge process
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    Complete the full PR approval and merge process, including resolving all PR comments, obtaining approval, merging the PR, and closing associated issues.
  </overview>

  <input_schema>
    <parameter name="pr_num" type="string" required="true">
      <description>The pull request number to process</description>
    </parameter>
  </input_schema>

  <output_schema>
    <result name="result" type="string" required="true">
      <description>The status of the PR approval and merge process</description>
      <values>
        <value>merged: PR was successfully approved and merged to target branch</value>
        <value>pending: PR merge is pending additional checks or manual intervention</value>
        <value>failed: PR could not be merged due to conflicts, failed checks, or other issues</value>
      </values>
    </result>
  </output_schema>

  <validation>
    <criteria>Review Comment Resolution: `ai-pr-comment-protocol.md` workflow executed and logged</criteria>
    <criteria>Review Comment Resolution: `pr-review-comments` acceptance criteria satisfied</criteria>
    <criteria>Review Comment Resolution: GraphQL verification artifacts captured (empty `pr-unresolved-threads.json`, final query output)</criteria>
    <criteria>Review Comment Resolution: Evidence files and summary links attached to run report</criteria>
    <criteria>Approval & Merge: Stakeholder approval obtained after presenting resolution evidence</criteria>
    <criteria>Approval & Merge: Merge performed (or blocked reason documented) using repository policies</criteria>
    <criteria>Approval & Merge: Merge result recorded (`result` output set correctly)</criteria>
    <criteria>Post-Merge Hygiene: Source branch deleted (if merge succeeded and policy allows)</criteria>
    <criteria>Post-Merge Hygiene: Related issues/tickets closed or updated with resolution notes</criteria>
    <criteria>Post-Merge Hygiene: Run report updated with final status, evidence locations, and next steps</criteria>
  </validation>

  <workflow>
    <step name="Phase 0: Pre-flight Checklist">
      <action>Confirm you have the correct PR number, branch permissions, and authentication (`gh auth status`)</action>
      <action>Execute the GraphQL snapshot command from the protocol and store `.pr-thread-snapshot.json`</action>
      <action>Create or update a work log/issue (if required) capturing the current state of review threads and planned actions</action>
      <action>Log `✓ Read ai-pr-comment-protocol.md` and confirm familiarity with `pr-review-comments.md`</action>
    </step>

    <step name="Phase 1: Resolve Review Comments (Execute `pr-review-comments`)">
      <action>Follow the mandated workflow: Implement fixes, push commits, reply using template, call `resolveReviewThread` mutation</action>
      <action>Re-run the snapshot query until `pr-unresolved-threads.json` is empty</action>
      <action>Post the PR-wide summary comment that enumerates every thread (ID or link), associated commit SHA, and outcome</action>
      <action>Archive evidence in the run report: Attach final GraphQL output, record location of `pr-review-threads-summary.md`</action>
      <action>Notify the orchestrator/reviewer with links to the summary comment and evidence</action>
    </step>

    <step name="Phase 2: Secure Approval">
      <action>Address any follow-up questions or additional review comments immediately, repeating Phase 1 as necessary</action>
      <action>Once stakeholders confirm that all feedback is satisfied, record their approval (screenshot, link to approval comment, or review state change)</action>
      <action>Verify that CI checks are green and branch protection conditions are satisfied</action>
    </step>

    <step name="Phase 3: Merge Execution & Wrap-Up">
      <action>Attempt the merge using the repository’s preferred strategy (squash, rebase, merge)</action>
      <action>Set the `result` output based on outcome (merged, pending, failed)</action>
      <action>On successful merge: Delete the source branch (if policy allows)</action>
      <action>On successful merge: Close or update related issues with links to the PR and summary comment</action>
      <action>Update the run report with final status, evidence links, and next steps</action>
    </step>
  </workflow>

  <critical_protocols>
    <protocol name="Commit Changes Before Merge">
      <instruction>Commit all local changes to the PR branch using `git add .` and `git commit`</instruction>
      <instruction>Push changes to the remote branch using `git push origin <branch-name>`</instruction>
      <instruction>Verify changes are in the remote branch by checking the PR diff or using `git show origin/<branch-name>:<file-path>`</instruction>
      <warning>Failure to commit and push changes will result in permanent loss of all implementation work when the branch is merged and deleted.</warning>
    </protocol>
    <protocol name="Non-negotiable Prerequisites">
      <instruction>Acknowledge and follow the canonical protocol (`ai-pr-comment-protocol.md`)</instruction>
      <instruction>Execute the `pr-review-comments` assignment</instruction>
      <warning>Skipping these prerequisites invalidates this assignment.</warning>
    </protocol>
  </critical_protocols>

  <result_determination>
    <case value="merged">
      <condition>All PR comments have been resolved through the iterative process</condition>
      <condition>Stakeholder approval has been obtained</condition>
      <condition>Merge operation completes successfully without conflicts</condition>
      <condition>Target branch now contains the merged changes</condition>
    </case>
    <case value="pending">
      <condition>All PR comments have been resolved and approval obtained</condition>
      <condition>Merge operation initiated but blocked by pending status checks (CI/CD, tests, etc.)</condition>
      <condition>Manual intervention may be required when checks complete</condition>
      <condition>The PR is ready to merge but waiting for external conditions</condition>
    </case>
    <case value="failed">
      <condition>All PR comments have been resolved and approval obtained</condition>
      <condition>Merge operation fails due to conflicts with target branch</condition>
      <condition>Branch protection rules cannot be satisfied</condition>
      <condition>Merge blocked by unresolvable technical issues</condition>
      <condition>Required manual intervention for conflict resolution</condition>
    </case>
  </result_determination>
</instructions>
