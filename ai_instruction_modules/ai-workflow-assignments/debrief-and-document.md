---
description: Perform a comprehensive debrief and document learnings
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Perform a comprehensive debriefing session to capture learnings, insights, and improvements, and document them in a structured report.</goal>
    <output>Debriefing report in .md format</output>
  </overview>

  <acceptance_criteria>
    <criterion>Report created using structured template.</criterion>
    <criterion>All 12 sections completed comprehensively.</criterion>
    <criterion>Report reviewed and approved by stakeholders.</criterion>
    <criterion>Report committed to repository.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Create Report</title>
      <actions>
        <action>Use the structured template.</action>
        <action>Fill in Executive Summary, Workflow Overview, Deliverables.</action>
        <action>Document Lessons Learned, What Worked, Improvements.</action>
        <action>Detail Errors, Challenges, Suggested Changes.</action>
        <action>Provide Metrics and Future Recommendations.</action>
      </actions>
    </step>

    <step number="2">
      <title>Review</title>
      <actions>
        <action>Post report for review.</action>
        <action>Address feedback from stakeholders.</action>
        <action>Gain approval.</action>
      </actions>
    </step>

    <step number="3">
      <title>Finalize</title>
      <actions>
        <action>Commit report to repository.</action>
        <action>Initiate continuous improvement cycle.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify report completeness.</step>
    <step>Confirm stakeholder approval.</step>
    <step>Verify file existence in repo.</step>
  </validation>

  <appendix id="template">
    <note>See original file for full Report Template.</note>
  </appendix>
</instructions>
