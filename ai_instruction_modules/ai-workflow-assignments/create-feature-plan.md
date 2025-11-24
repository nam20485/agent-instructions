---
description: Create a comprehensive plan for a new feature
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a comprehensive plan for delivering a major new feature within an existing application.</goal>
    <context>PLANNING ONLY - No implementation code.</context>
  </overview>

  <acceptance_criteria>
    <criterion>Feature spec and architecture analyzed.</criterion>
    <criterion>Dependencies and integration points identified.</criterion>
    <criterion>Planning docs updated (`tech-stack.md`, `architecture.md`).</criterion>
    <criterion>Plan documented in issue using Appendix A template.</criterion>
    <criterion>Milestones created and issues linked.</criterion>
    <criterion>Plan linked to GitHub Project.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis</title>
      <actions>
        <action>Analyze feature spec and supporting docs.</action>
        <action>Identify affected components and integrations.</action>
        <action>Engage stakeholders for clarification.</action>
      </actions>
    </step>

    <step number="2">
      <title>Design Plan</title>
      <actions>
        <action>Define phases/epics.</action>
        <action>Break phases into tasks.</action>
        <action>Document migration, testing, observability requirements.</action>
        <action>Update planning docs.</action>
      </actions>
    </step>

    <step number="3">
      <title>Publish</title>
      <actions>
        <action>Create feature plan issue using template.</action>
        <action>Create/update milestones.</action>
        <action>Link issue to Project.</action>
        <action>Apply labels.</action>
      </actions>
    </step>
  </workflow>

  <events>
    <event name="pre-assignment-begin">
      <action>gather-context</action>
    </event>
    <event name="on-assignment-failure">
      <action>recover-from-error</action>
    </event>
    <event name="post-assignment-complete">
      <action>report-progress</action>
    </event>
  </events>

  <validation>
    <step>Obtain stakeholder approval.</step>
    <step>Ensure NO implementation code was written.</step>
  </validation>

  <appendix id="A">
    <note>Template moved to `.github/ISSUE_TEMPLATE/feature-plan.md`.</note>
  </appendix>
</instructions>
