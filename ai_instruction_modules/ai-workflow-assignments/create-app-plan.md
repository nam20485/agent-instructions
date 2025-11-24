---
description: Create a comprehensive application development plan
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a plan for application development using the template in Appendix A, based on a filled-out new application template.</goal>
    <context>PLANNING ONLY - No implementation code.</context>
  </overview>

  <acceptance_criteria>
    <criterion>Application template analyzed.</criterion>
    <criterion>Plan documented in an issue using Appendix A template.</criterion>
    <criterion>Milestones created and issues linked.</criterion>
    <criterion>Tech stack and architecture documented.</criterion>
    <criterion>Plan linked to GitHub Project.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis</title>
      <actions>
        <action>Analyze application template and linked documents.</action>
        <action>Identify requirements, features, components.</action>
        <action>Document tech stack in `plan_docs/tech-stack.md`.</action>
        <action>Document architecture in `plan_docs/architecture.md`.</action>
      </actions>
    </step>

    <step number="2">
      <title>Design Plan</title>
      <actions>
        <action>Design detailed plan based on template.</action>
        <action>Document planned project structure.</action>
        <action>Plan for testing, docs, containerization.</action>
      </actions>
    </step>

    <step number="3">
      <title>Documentation</title>
      <actions>
        <action>Create Issue documenting plan using template.</action>
        <action>Create milestones based on phases.</action>
        <action>Link issue to GitHub Project.</action>
        <action>Assign to "Phase 1: Foundation" milestone.</action>
        <action>Apply labels ("planning", "documentation").</action>
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
    <step>Obtain stakeholder approval for the plan.</step>
    <step>Ensure NO implementation code was written.</step>
  </validation>

  <appendix id="A">
    <note>Template moved to `.github/ISSUE_TEMPLATE/application-plan.md`.</note>
  </appendix>
</instructions>
