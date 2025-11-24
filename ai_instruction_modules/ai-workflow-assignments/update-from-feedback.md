---
description: Incorporate feedback to improve work quality and effectiveness
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    Incorporate feedback received from the previous assignment to improve the overall quality and effectiveness of the work. This includes addressing any specific points raised by reviewers and making necessary adjustments to the existing implementation, documentation, or plans.
  </overview>

  <input_schema>
    <parameter name="directory" type="string" required="true">
      <description>path to directory containing feedback documents for review</description>
    </parameter>
  </input_schema>

  <validation>
    <criteria>All reviewer comments have been addressed.</criteria>
    <criteria>All feedback items have been categorized and prioritized.</criteria>
    <criteria>Action plan has been created with specific, actionable items for each feedback category.</criteria>
    <criteria>Implementation issues (epics/stories/tasks/bugs) have been created or updated in GitHub.</criteria>
    <criteria>Documentation has been updated to reflect changes made.</criteria>
    <criteria>Workflow changes have been documented with specific file locations and modifications.</criteria>
    <criteria>Any new issues identified during the review have been logged and prioritized.</criteria>
    <criteria>Improvements identified in the feedback have been implemented or scheduled.</criteria>
    <criteria>Changes have been validated against acceptance criteria.</criteria>
    <criteria>A comprehensive summary report has been created documenting all changes.</criteria>
    <criteria>Success metrics have been defined for tracking improvement impact.</criteria>
  </validation>

  <workflow>
    <step name="Review Feedback Documents">
      <action>Access and inventory feedback documents in the specified directory</action>
      <action>Read and extract feedback items, noting severity, context, and metrics</action>
      <action>Create a structured list of feedback items with ID, source, title, description, current/desired state, severity, and effort</action>
    </step>

    <step name="Categorize Feedback Items">
      <action>Assign primary and secondary categories to each feedback item (see Categories section)</action>
      <action>Record rationale for categorization</action>
    </step>

    <step name="Prioritize Feedback Items">
      <action>Assign priority levels (P0-P3) based on the prioritization matrix</action>
      <action>Estimate effort (Small, Medium, Large)</action>
      <action>Calculate priority score: (Severity Weight × Impact) / Effort</action>
      <action>Sort feedback items by priority score</action>
    </step>

    <step name="Document Action Plan">
      <action>Create a comprehensive action plan document using the template</action>
    </step>

    <step name="Create/Update GitHub Issues">
      <action>Determine issue type (Epic, Story, Task, Bug) for each actionable item</action>
      <action>Create issues in GitHub with appropriate labels and links to the action plan</action>
      <action>Update existing issues with new acceptance criteria or tasks if applicable</action>
      <action>Track issue creation in a table in the action plan</action>
    </step>

    <step name="Implement Changes">
      <substep name="Immediate Implementation (P0/P1)">
        <action>Create feature branch</action>
        <action>Implement fix (code or documentation)</action>
        <action>Validate fix</action>
        <action>Commit changes and create Pull Request</action>
      </substep>
      <substep name="Schedule Future Implementation (P2/P3)">
        <action>Ensure GitHub issues are created</action>
        <action>Assign to milestone/sprint</action>
        <action>Add to project board</action>
      </substep>
      <substep name="Workflow Changes Implementation">
        <action>Create Workflow Changes Document</action>
        <action>Save as `docs/FEEDBACK_WORKFLOW_CHANGES.md`</action>
        <action>Create issue in `agent-instructions` repo linking to the document</action>
      </substep>
    </step>

    <step name="Validate Changes">
      <action>Verify code changes (build, lint, test, PR approved)</action>
      <action>Verify documentation changes (accurate, valid links, formatting)</action>
      <action>Verify issue creation (labeled, linked, clear criteria)</action>
      <action>Verify workflow changes (documented, rationale provided)</action>
      <action>Compare before/after metrics</action>
      <action>Check acceptance criteria for each feedback item</action>
    </step>

    <step name="Document Summary">
      <action>Create Feedback Response Summary document</action>
      <action>Update original feedback documents with status (Addressed, Scheduled, Deferred)</action>
      <action>Communicate results to team and stakeholders</action>
    </step>
  </workflow>

  <categories>
    <category name="Implementation Status & Gaps">
      <criteria>Missing features, incomplete implementations, deferred items</criteria>
      <action_type>Implementation Gaps</action_type>
    </category>
    <category name="Quality & Validation Issues">
      <criteria>Build errors, lint warnings, TypeScript errors, code quality</criteria>
      <action_type>Implementation Gaps (Bug Fixes)</action_type>
    </category>
    <category name="Architecture & Design Issues">
      <criteria>Incorrect configurations, design pattern violations, architectural misalignments</criteria>
      <action_type>Planning Changes + Implementation Gaps (Refactoring)</action_type>
    </category>
    <category name="Performance & Optimization">
      <criteria>Bundle size, rendering performance, memory usage, load times</criteria>
      <action_type>Planning Changes + Implementation Gaps</action_type>
    </category>
    <category name="Documentation Gaps">
      <criteria>Missing docs, outdated content, incomplete API documentation</criteria>
      <action_type>Implementation Gaps (Documentation Tasks)</action_type>
    </category>
    <category name="Process & Workflow Improvements">
      <criteria>Workflow changes, agent enhancements, prompt improvements</criteria>
      <action_type>Workflow Changes</action_type>
    </category>
    <category name="Testing & Quality Assurance">
      <criteria>Missing tests, coverage gaps, test infrastructure needs</criteria>
      <action_type>Implementation Gaps + Planning Changes</action_type>
    </category>
    <category name="Lessons Learned & Best Practices">
      <criteria>What worked, what didn't, recommendations for future</criteria>
      <action_type>Workflow Changes + Planning Changes + Documentation</action_type>
    </category>
  </categories>

  <templates>
    <template name="Action Plan">
      <path>../templates/feedback-action-plan.md</path>
    </template>
    <template name="Workflow Changes">
      <path>../templates/feedback-workflow-changes.md</path>
    </template>
    <template name="Response Summary">
      <path>../templates/feedback-response-summary.md</path>
    </template>
  </templates>
</instructions>
