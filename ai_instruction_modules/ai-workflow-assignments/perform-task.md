---
description: Execute a specific task using the task-based workflow process
role: assistant
scope: workflow-assignment
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    Execute a specific task given to you by an orchestrator or stakeholder, using the task-based workflow process. This includes understanding the task requirements, planning/gaining approval and gathering necessary resources, and delivering the expected outcome.
  </overview>

  <input_schema>
    <parameter name="task" type="object" required="true">
      <description>Task object or description containing the task requirements, objectives, deliverables, and any relevant context</description>
    </parameter>
  </input_schema>

  <output_schema>
    <result name="completion_status">
      <description>Task successfully completed according to acceptance criteria</description>
    </result>
    <result name="deliverables">
      <description>All deliverables validated and approved by stakeholders</description>
    </result>
    <result name="documentation">
      <description>Work documented and integrated into the project</description>
    </result>
  </output_schema>

  <validation>
    <criteria>Task requirements have been fully understood and clarified</criteria>
    <criteria>Detailed implementation plan has been created and approved</criteria>
    <criteria>All necessary resources and dependencies have been identified and secured</criteria>
    <criteria>Task has been executed according to the approved plan</criteria>
    <criteria>Expected outcomes have been delivered and validated</criteria>
    <criteria>All work has been documented and committed appropriately</criteria>
    <criteria>Stakeholder has confirmed task completion satisfactorily</criteria>
  </validation>

  <workflow>
    <step name="Task Understanding and Analysis">
      <action>Carefully review the task description and requirements provided</action>
      <action>Identify all deliverables, acceptance criteria, and success metrics</action>
      <action>Understand the context and background of why this task is needed</action>
      <action>Identify any constraints, dependencies, or prerequisites</action>
      <action>Ask clarifying questions if any requirements are unclear or ambiguous</action>
    </step>

    <step name="Planning and Resource Assessment">
      <action>Break down the task into smaller, manageable subtasks</action>
      <action>Estimate time and effort required for each subtask</action>
      <action>Identify all resources, tools, and dependencies needed</action>
      <action>Assess potential risks and develop mitigation strategies</action>
      <action>Create a detailed timeline with milestones and checkpoints</action>
    </step>

    <step name="Stakeholder Approval Process">
      <action>Create a GitHub issue outlining the task and implementation plan</action>
      <action>Use the task-based workflow format with checkboxes for each step</action>
      <action>Include detailed descriptions of what will be changed and why</action>
      <action>Present the plan to stakeholders for review and approval</action>
      <action>Iterate on the plan based on stakeholder feedback until approved</action>
    </step>

    <step name="Implementation Execution">
      <action>Mark the issue as "state:in-progress" once approval is received</action>
      <action>Create appropriate feature branches using naming convention: `issues/<number>-<short-description>`</action>
      <note>If working in parallel with other agents, ensure your branch name is unique and descriptive (e.g., `issues/42-user-authentication`)</note>
      <action>Execute each subtask systematically according to the approved plan</action>
      <action>Update issue checkboxes and progress as you complete each step</action>
      <action>Commit work frequently with descriptive commit messages</action>
      <action>Push your feature branch regularly to make progress visible to orchestrator</action>
    </step>

    <step name="Quality Assurance and Testing">
      <action>Test each component as it's implemented</action>
      <action>Perform integration testing to ensure everything works together</action>
      <action>Validate that all acceptance criteria are met</action>
      <action>Run any relevant automated tests (unit, integration, etc.)</action>
      <action>Conduct manual testing for user-facing features</action>
    </step>

    <step name="Documentation and Communication">
      <action>Document all changes, configurations, and decisions made</action>
      <action>Update any relevant project documentation</action>
      <action>Provide clear instructions for deployment or usage</action>
      <action>Keep stakeholders informed of progress and any issues encountered</action>
      <action>Create comprehensive commit messages linking to the issue</action>
    </step>

    <step name="Delivery and Validation">
      <action>Ensure all deliverables are complete and meet quality standards</action>
      <action>Push all changes to the appropriate remote branches</action>
      <action>Create pull requests with proper reviewers assigned</action>
      <action>Provide demonstration or walkthrough of completed work</action>
      <action>Address any feedback or change requests from stakeholders</action>
    </step>

    <step name="Completion">
      <substep name="Final Review and Sign-off">
        <action>Conduct a final review of all deliverables against acceptance criteria</action>
        <action>Ensure all code is committed and pushed to remote repositories</action>
        <action>Update the issue with a summary of completed work</action>
        <action>Request final stakeholder review and approval</action>
        <action>Address any last-minute feedback or concerns</action>
      </substep>
      <substep name="Project Integration">
        <action>Merge approved pull requests following established procedures</action>
        <action>Deploy changes to appropriate environments if required</action>
        <action>Update any project tracking or management systems</action>
        <action>Ensure all related documentation is current and accurate</action>
        <action>Clean up temporary branches and resources</action>
      </substep>
      <substep name="Handoff and Closure">
        <action>Provide any necessary handoff documentation or training</action>
        <action>Close the GitHub issue with a comprehensive summary</action>
        <action>Update any project status or progress tracking systems</action>
        <action>Gather lessons learned and feedback for future improvements</action>
        <action>Confirm with stakeholders that the task is complete and satisfactory</action>
      </substep>
    </step>
  </workflow>

  <guidance>
    <parallel_execution>
      <instruction>Focus on your assigned task's scope - do not overlap with other agents' work</instruction>
      <instruction>Use clear, descriptive feature branch names to avoid confusion</instruction>
      <instruction>Commit and push your work frequently to minimize merge conflicts</instruction>
      <instruction>Coordinate with the orchestrator if you discover dependencies on other agents' work</instruction>
      <instruction>Be prepared for integration testing once all parallel tasks complete</instruction>
    </parallel_execution>
  </guidance>
</instructions>
