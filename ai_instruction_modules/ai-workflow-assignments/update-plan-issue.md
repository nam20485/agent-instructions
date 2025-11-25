---
description: Update plan issue by incorporating analysis findings
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Update an existing plan issue by incorporating analysis findings, discussion results, and refined requirements.</goal>
    <context>Runs after analysis phase completes. Transforms raw analysis into actionable plan updates.</context>
  </overview>

  <prerequisites>
    <item>Existing plan issue to update (issue number/URL).</item>
    <item>Analysis findings from repository analysis phase.</item>
    <item>Discussion results from delegate roundtable (if applicable).</item>
    <item>Write access to the plan issue.</item>
  </prerequisites>

  <acceptance_criteria>
    <criterion>Plan issue updated with analysis findings.</criterion>
    <criterion>Technical requirements refined based on analysis.</criterion>
    <criterion>Dependencies and blockers identified and documented.</criterion>
    <criterion>Implementation approach updated with concrete details.</criterion>
    <criterion>Acceptance criteria updated to reflect analysis insights.</criterion>
    <criterion>All stakeholder feedback incorporated.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Retrieve Current Plan State</title>
      <actions>
        <action>Fetch current plan issue content.</action>
        <action>Identify sections that need updates.</action>
        <action>Note existing decisions that should be preserved.</action>
        <action>List questions or gaps that analysis should address.</action>
      </actions>
    </step>

    <step number="2">
      <title>Process Analysis Findings</title>
      <actions>
        <action>Review repository analysis results.</action>
        <action>Extract key findings: existing patterns, constraints, opportunities.</action>
        <action>Identify technical dependencies discovered.</action>
        <action>Note potential risks or blockers found.</action>
        <action>Document recommended approaches based on analysis.</action>
      </actions>
    </step>

    <step number="3">
      <title>Incorporate Delegate Discussion</title>
      <description>If roundtable discussion occurred.</description>
      <actions>
        <action>Review delegate perspectives and recommendations.</action>
        <action>Identify consensus points.</action>
        <action>Note dissenting opinions and trade-offs.</action>
        <action>Extract action items from discussion.</action>
      </actions>
    </step>

    <step number="4">
      <title>Update Plan Sections</title>
      <actions>
        <action>Update Technical Approach with analysis-informed details.</action>
        <action>Refine Implementation Steps with concrete tasks.</action>
        <action>Update Dependencies section with discovered dependencies.</action>
        <action>Add/update Risks section with identified blockers.</action>
        <action>Refine Acceptance Criteria to be more specific.</action>
        <action>Update Timeline if analysis impacts estimates.</action>
      </actions>
    </step>

    <step number="5">
      <title>Add Analysis Artifacts</title>
      <actions>
        <action>Link to analysis documents if created.</action>
        <action>Add relevant code snippets or examples.</action>
        <action>Include architecture diagrams if applicable.</action>
        <action>Reference related issues or PRs discovered.</action>
      </actions>
    </step>

    <step number="6">
      <title>Submit Plan Update</title>
      <actions>
        <action>Review all changes for consistency.</action>
        <action>Update plan issue via GitHub API or CLI.</action>
        <action>Add comment summarizing what changed and why.</action>
        <action>Notify stakeholders of plan update.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Plan issue successfully updated with analysis findings.</step>
    <step>All analysis insights incorporated appropriately.</step>
    <step>Plan maintains consistency and clarity.</step>
    <step>Stakeholders notified of changes.</step>
    <step>Change summary comment added to issue.</step>
  </validation>

  <notes>
    <note>Preserve existing decisions unless analysis contradicts them.</note>
    <note>Be explicit about what changed and why.</note>
    <note>Link analysis artifacts for traceability.</note>
    <note>Flag any findings that require stakeholder review.</note>
  </notes>
</instructions>
