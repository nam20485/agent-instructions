---
description: Analyze repository progress against a plan or issue
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Rigorously interrogate the repository to analyze progress, identify gaps, and document findings in a new issue.</goal>
  </overview>

  <acceptance_criteria>
    <criterion>New issue created documenting findings with clear analysis.</criterion>
    <criterion>Entire codebase analyzed systematically.</criterion>
    <criterion>Gap analysis completed with prioritized recommendations.</criterion>
    <criterion>Stakeholder approval obtained.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Specification Analysis</title>
      <actions>
        <action>Read the provided issue or `plan_docs/ai-new-app-template.md`.</action>
        <action>Determine what is supposed to be built.</action>
      </actions>
    </step>

    <step number="2">
      <title>Repository Interrogation</title>
      <description>Conduct systematic analysis using available tools.</description>
      <tools>
        <tool>semantic_search</tool>
        <tool>grep_search</tool>
        <tool>mcp_github_list_issues</tool>
        <tool>git log</tool>
      </tools>
      <verification_rules>
        <rule>Verify all claims against actual code/commits.</rule>
        <rule>Document "Evidence Sources" for every finding.</rule>
      </verification_rules>
    </step>

    <step number="3">
      <title>Gap Analysis</title>
      <actions>
        <action>Compare actual implementation against requirements.</action>
        <action>Identify missing components and risks.</action>
        <action>Prioritize recommendations.</action>
      </actions>
    </step>

    <step number="4">
      <title>Reporting</title>
      <actions>
        <action>Create new issue with structured findings.</action>
        <action>Include: Completed work (checked), Remaining tasks (unchecked), Evidence Sources.</action>
        <action>Link to original issue.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Present new issue to stakeholder.</step>
    <step>Address feedback.</step>
    <step>Mark complete upon approval.</step>
  </validation>
</instructions>
