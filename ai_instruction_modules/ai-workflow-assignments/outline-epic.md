---
description: Create a structural outline for an existing epic
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Create a comprehensive structural outline (code files only) for an EXISTING epic and its stories. NO NEW ISSUES.</goal>
    <input>
      <parameter name="epic">Existing Epic issue object</parameter>
    </input>
    <output>Epic outline object with created files and build status</output>
  </overview>

  <acceptance_criteria>
    <criterion>Existing Epic and Story issues retrieved (NOT created).</criterion>
    <criterion>Class files created with XML documentation.</criterion>
    <criterion>Interfaces defined with XML documentation.</criterion>
    <criterion>Public methods declared with signatures only.</criterion>
    <criterion>Test case stubs created for all functionality.</criterion>
    <criterion>Project builds successfully.</criterion>
    <criterion>Code committed to feature branch.</criterion>
    <criterion>NO NEW GITHUB ISSUES CREATED.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Retrieve Context</title>
      <actions>
        <action>Read EXISTING epic and story issues.</action>
        <action>Identify features and architecture.</action>
        <action>Do NOT create new issues.</action>
      </actions>
    </step>

    <step number="2">
      <title>Design Structure</title>
      <actions>
        <action>Design class and interface hierarchy.</action>
        <action>Map to project structure.</action>
      </actions>
    </step>

    <step number="3">
      <title>Create Code Files</title>
      <actions>
        <action>Create interface files with documentation.</action>
        <action>Create class files with documentation.</action>
        <action>Declare methods with `NotImplementedException`.</action>
      </actions>
    </step>

    <step number="4">
      <title>Create Tests</title>
      <actions>
        <action>Create test classes for production classes.</action>
        <action>Create test method stubs (Arrange-Act-Assert).</action>
      </actions>
    </step>

    <step number="5">
      <title>Validate & Commit</title>
      <actions>
        <action>Build project and verify no errors.</action>
        <action>Create feature branch `feature/outline-<name>`.</action>
        <action>Commit files.</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Verify only code files were created.</step>
    <step>Verify project builds.</step>
    <step>Return outline object.</step>
  </validation>
</instructions>
