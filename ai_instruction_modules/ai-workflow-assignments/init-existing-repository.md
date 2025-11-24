---
description: Initiate a new repository for a project
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Initiate a new repository for a project, including configuration, issue tracking setup, and administrative structure.</goal>
    <prerequisites>
      <item>GitHub authentication with required scopes.</item>
      <item>GitHub CLI installed.</item>
    </prerequisites>
  </overview>

  <acceptance_criteria>
    <criterion>PR and new branch created.</criterion>
    <criterion>GitHub Project created and linked.</criterion>
    <criterion>Project columns created.</criterion>
    <criterion>Labels imported.</criterion>
    <criterion>Filenames renamed to match project.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Create Project</title>
      <actions>
        <action>Create GitHub Project (Board template).</action>
        <action>Link to repository.</action>
        <action>Create columns (Not Started, In Progress, In Review, Done).</action>
      </actions>
    </step>

    <step number="2">
      <title>Import Labels</title>
      <actions>
        <action>Import labels using `import-labels.ps1`.</action>
      </actions>
    </step>

    <step number="3">
      <title>Rename Files</title>
      <actions>
        <action>Rename devcontainer name in `devcontainer.json`.</action>
        <action>Rename `.code-workspace` file.</action>
      </actions>
    </step>

    <step number="4">
      <title>Create Branch</title>
      <actions>
        <action>Create branch `dynamic-workflow-<name>`.</action>
        <action>Create PR linked to Project.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify Project and PR creation.</step>
    <step>Verify label import.</step>
    <step>Notify orchestrator of completion.</step>
  </validation>
</instructions>
