---
description: Convert debrief reports into actionable improvement plans
scope: workflow-assignment
role: System Orchestrator
version: v1
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Convert an approved debrief report into an actionable continuous improvement program.</goal>
    <prerequisites>
      <item>Completed `debrief-and-document` assignment.</item>
      <item>Write access to repository.</item>
      <item>Independent validation agent available.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>Improvement opportunities extracted and scored.</criterion>
    <criterion>`docs/continuous-improvement/continuous-improvement.md` created/updated.</criterion>
    <criterion>Plan reviewed by independent agent.</criterion>
    <criterion>High Value/Low Risk items implemented and validated.</criterion>
    <criterion>Final report recorded.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Analysis</title>
      <actions>
        <action>Parse debrief report (Sections 6, 7, 8, 9, 11).</action>
        <action>Extract improvement candidates.</action>
        <action>Score Value vs. Risk/Complexity (1-5 scale).</action>
        <action>Calculate Ratio (Value/Risk).</action>
      </actions>
    </step>

    <step number="2">
      <title>Prioritization</title>
      <actions>
        <action>Sort by ratio.</action>
        <action>Segment into Section A (High Value/Low Risk), Section B (Moderate Value/Low Risk), Section C (Remaining).</action>
      </actions>
    </step>

    <step number="3">
      <title>Documentation</title>
      <actions>
        <action>Create `continuous-improvement.md` with backlog table.</action>
        <action>Build execution plan for Sections A & B.</action>
      </actions>
    </step>

    <step number="4">
      <title>Review</title>
      <actions>
        <action>Delegate plan to independent agent for review.</action>
        <action>Incorporate feedback.</action>
      </actions>
    </step>

    <step number="5">
      <title>Implementation</title>
      <actions>
        <action>Implement Section A & B items.</action>
        <action>Validate fixes.</action>
        <action>Update backlog status.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Summarize completed work and metrics.</step>
    <step>Present outstanding items for approval/deferral.</step>
    <step>Finalize documentation and commit.</step>
  </validation>
</instructions>
