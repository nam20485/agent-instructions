---
description: Entry point for GitHub Copilot custom instructions
scope: global
role: System Orchestrator
---

<instructions>
  <overview>
    This file serves as the bootstrap entry point for the AI agent's instruction set.
    It defines the location of core modules, the protocol for loading remote instructions, and the single source of truth policy.
  </overview>

  <instruction_source>
    <repository>
      <name>nam20485/agent-instructions</name>
      <url>https://github.com/nam20485/agent-instructions/tree/main</url>
      <branch>main</branch>
    </repository>
    <guidance>
      Start with the Core Instructions linked below. Follow links to other modules as required by the user's request.
    </guidance>
  </instruction_source>

  <module_registry>
    <module type="core" required="true">
      <name>Core Instructions</name>
      <link>https://github.com/nam20485/agent-instructions/blob/main/ai_instruction_modules/ai-core-instructions.md</link>
      <description>The foundational behaviors and rules for the agent.</description>
    </module>

    <module type="local" required="true">
      <name>Local AI Instructions</name>
      <path>../local_ai_instruction_modules</path>
      <description>Context-specific instructions located in the local workspace.</description>
    </module>

    <module type="dynamic workflow" required="true">
      <name>Dynamic Workflow Orchestration</name>
      <path>../local_ai_instruction_modules/ai-dynamic-workflows.md</path>
      <description>Protocol for resolving workflows from the remote canonical repository.</description>
    </module>

    <module type="workflow assignment" required="true">
      <name>Workflow Assignments</name>
      <path>../local_ai_instruction_modules/ai-workflow-assignments.md</path>
      <description>Index of active workflow assignments by shortId.</description>
    </module>

    <module type="optional">
      <name>Terminal Commands</name>
      <path>../local_ai_instruction_modules/ai-terminal-commands.md</path>
      <description>Reference for terminal operations and GitHub CLI usage.</description>
    </module>
  </module_registry>

  <loading_protocol>
    <rule id="remote_access">
      <description>Accessing files in the remote repository</description>
      <instruction>
        Always use the RAW URL to read file contents. Do not use the GitHub UI URL.
      </instruction>
    </rule>

    <algorithm name="url_translation">
      <step>Identify the GitHub UI URL (e.g., `https://github.com/.../blob/main/...`).</step>
      <step>Replace `https://github.com/` with `https://raw.githubusercontent.com/`.</step>
      <step>Remove `blob/` from the path.</step>
      <step>Result: `https://raw.githubusercontent.com/.../main/...`</step>
    </algorithm>

    <examples>
      <example>
        <input>https://github.com/nam20485/agent-instructions/blob/main/ai_instruction_modules/ai-core-instructions.md</input>
        <output>https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-core-instructions.md</output>
      </example>
    </examples>
  </loading_protocol>

  <policy name="single_source_of_truth">
    <statement>
      The remote canonical repository is the ONLY authoritative source for dynamic workflows and workflow assignments.
    </statement>
    <rules>
      <rule>Do not use local mirrors or cached plans to derive steps.</rule>
      <rule>Fetch and execute directly from the remote canonical URLs.</rule>
      <rule>Changes in the remote repo take effect immediately.</rule>
    </rules>
  </policy>
</instructions>
