---
description: Analyze an application development plan issue to determine fitness for implementation
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Analyze an application development plan issue to determine fitness for implementation, identify gaps, rate risks, and provide actionable recommendations.</goal>
    <input>
      <parameter name="repository" optional="true" default="current workspace">Git repository containing the plan issue</parameter>
      <parameter name="issue_number" required="true">The GitHub issue number containing the application plan</parameter>
    </input>
  </overview>

  <acceptance_criteria>
    <criterion>New issue created documenting findings with clear analysis and recommendations.</criterion>
    <criterion>Comprehensive repository analysis completed using all available tools.</criterion>
    <criterion>Detailed findings documented with evidence sources.</criterion>
    <criterion>Risks and mitigations documented.</criterion>
    <criterion>Readiness assessment with specific recommendations.</criterion>
    <criterion>Roundtable discussion conducted with delegates.</criterion>
    <criterion>Stakeholder approval obtained.</criterion>
  </acceptance_criteria>

  <roles>
    <role>Orchestrator (You)</role>
    <role>Project Planner</role>
    <role>Product Manager</role>
    <role>Backend Developer</role>
    <role>Frontend Developer</role>
    <role>QA Engineer</role>
    <role>Researcher</role>
  </roles>

  <workflow>
    <step number="1">
      <title>Initial Assessment</title>
      <actions>
        <action>Read the provided issue or `APP_PLAN.md`.</action>
        <action>If missing, inform stakeholder and halt.</action>
      </actions>
    </step>

    <step number="2">
      <title>Independent Analysis</title>
      <description>Conduct systematic repository analysis using all available tools.</description>
      <tools>
        <tool>semantic_search</tool>
        <tool>grep_search</tool>
        <tool>mcp_github_list_issues</tool>
        <tool>git log</tool>
      </tools>
      <verification_rules>
        <rule>DO NOT accept statements in issues/PRs as fact without verification.</rule>
        <rule>Base analysis ONLY on verifiable code/commits.</rule>
        <rule>Include "Evidence Sources" for every finding.</rule>
      </verification_rules>
    </step>

    <step number="3">
      <title>Draft Findings</title>
      <actions>
        <action>Create initial draft of findings and recommendations.</action>
        <action>Include specific evidence (commits, files).</action>
        <action>Prioritize by importance/effort.</action>
      </actions>
    </step>

    <step number="4">
      <title>Delegate Roundtable</title>
      <actions>
        <action>Gather input from all delegate roles.</action>
        <action>Conduct roundtable discussion to review findings.</action>
        <action>Resolve disagreements and reach consensus.</action>
        <action>Categorize recommendations (Must-have, Should-have, Nice-to-have).</action>
      </actions>
    </step>

    <step number="5">
      <title>Documentation</title>
      <actions>
        <action>Create a new issue documenting findings.</action>
        <action>Include: Completed work, Gaps, Recommendations, Evidence Sources.</action>
        <action>Link to original issue if provided.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Present findings to stakeholder with direct link to new issue.</step>
    <step>Address questions and make revisions.</step>
    <step>Obtain approval before marking complete.</step>
  </validation>
</instructions>
