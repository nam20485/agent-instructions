---
description: Process PR review comments safely and deterministically
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    This assignment defines the exact flow to process PR review comments safely and deterministically. You must execute the full workflow specified in `ai-pr-comment-protocol.md` before this assignment can be marked complete.
  </overview>

  <validation>
    <criteria>Every non-outdated review thread has an implemented fix (when required), a unique reply referencing the change, and has been explicitly resolved via the GraphQL mutation or approved UI action.</criteria>
    <criteria>The canonical verification artifacts exist: `pr-unresolved-threads.json` (or equivalent) is present and empty.</criteria>
    <criteria>Final GraphQL query output showing `isResolved: true` for all threads is attached to the run report.</criteria>
    <criteria>A PR-wide summary comment is posted that enumerates each review thread (link or ID), the associated commit SHA, and the final disposition (fixed / explained).</criteria>
    <criteria>`pr-review-threads-summary.md` (or the helper output from `scripts/query.ps1`) is updated/committed with the latest run details.</criteria>
    <criteria>The PR branch contains all required commits, is pushed to the remote, and the PR is ready for re-review (no pending local changes).</criteria>
    <criteria>Stakeholder/orchestrator is notified with links to the summary comment and verification artifacts.</criteria>
  </validation>

  <workflow>
    <step name="Read & Acknowledge Protocol">
      <action>Log `✓ Read ai-pr-comment-protocol.md` before touching review feedback.</action>
    </step>

    <step name="Enumerate Threads">
      <action>Run the GraphQL snapshot command from the protocol and store the result (defaults to `.pr-thread-snapshot.json`).</action>
    </step>

    <step name="Process Each Thread">
      <action>For every unresolved, non-outdated thread:</action>
      <substep>Implement and commit the fix (or document why no change is required).</substep>
      <substep>Reply using the mandated template, referencing the commit SHA.</substep>
      <substep>Call the `resolveReviewThread` mutation with the correct thread ID.</substep>
    </step>

    <step name="Re-verify & Capture Evidence">
      <action>Re-run the snapshot query; pipe unresolved results into `pr-unresolved-threads.json`.</action>
      <action>If the file is non-empty, continue iterating—threads remain unresolved.</action>
      <action>Archive the GraphQL output and helper summaries for the run report.</action>
    </step>

    <step name="Publish Summary & Notify Stakeholders">
      <action>Post a PR-wide summary comment listing every thread (link or ID), resolution status, and supporting commit SHA.</action>
      <action>Ping the requester/orchestrator with the summary link plus locations of evidence files.</action>
    </step>
  </workflow>

  <completion_checklist>
    <item>Acceptance criteria 1–6 above are satisfied with recorded evidence.</item>
    <item>PR-wide summary comment URL shared with stakeholders.</item>
    <item>Verification artifacts committed or attached as required.</item>
    <item>Stakeholder notified that the PR is ready for re-review.</item>
  </completion_checklist>

  <references>
    <reference>[`ai-pr-comment-protocol.md`](../ai-pr-comment-protocol.md)</reference>
  </references>
</instructions>
