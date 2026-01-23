---
description: Prove (via explicit evidence lines) that instruction/workflow lookups were delegated to agent-instructions-expert and branch came from copilot-instructions
scope: workflow-assignment
role: System Orchestrator
---

<instructions role="assistant" scope="workflow-assignment">
  <overview>
    <goal>Produce verifiable evidence that instruction/workflow lookups are being performed via `ai_instruction_modules/agent/agent-instructions-expert.md` and that branch selection is sourced from `.github/copilot-instructions.md`.</goal>
    <context>
      This assignment is designed for validation runs. It is intentionally "audit style": the deliverable is evidence text that a reviewer (or automated check) can verify.
    </context>
  </overview>

  <prerequisites>
    <item>Repository contains `.github/copilot-instructions.md` (branch authority).</item>
    <item>Repository contains `ai_instruction_modules/agent/agent-instructions-expert.md` (lookup proxy).</item>
  </prerequisites>

  <acceptance_criteria>
    <criterion>Output includes a "resolution trace" list of files consulted, including `.github/copilot-instructions.md` and `ai_instruction_modules/agent/agent-instructions-expert.md`.</criterion>
    <criterion>Output includes the exact evidence line: `[evidence] expert_invoked=true`</criterion>
    <criterion>Output includes the exact evidence line: `[evidence] lookup_source=agent-instructions-expert`</criterion>
    <criterion>Output includes the exact evidence line: `[evidence] branch_source=.github/copilot-instructions.md`</criterion>
    <criterion>Output includes the extracted branch value from `.github/copilot-instructions.md` (or a clear explanation why it could not be extracted).</criterion>
    <criterion>Output includes one concrete example of a resolved canonical URL (raw GitHub URL) constructed using the extracted branch value.</criterion>
    <criterion>Output explicitly states that no branch value was hardcoded in the validation output.</criterion>
  </acceptance_criteria>

  <workflow>
    <step number="1">
      <title>Resolve branch authority (SSOT)</title>
      <description>Read `.github/copilot-instructions.md` and extract the configured branch value from `<configuration><branch>`.</description>
      <actions>
        <action>Read `.github/copilot-instructions.md` and locate `<configuration><branch>...</branch>`.</action>
        <action>Record the branch value you found (e.g., `optimization`).</action>
        <action>If the branch cannot be extracted, explain why (missing file, missing tag, parsing ambiguity) and continue with an explicit "unknown" marker.</action>
      </actions>
    </step>

    <step number="2">
      <title>Perform lookup via agent-instructions-expert</title>
      <description>Use `ai_instruction_modules/agent/agent-instructions-expert.md` as the sole mechanism to resolve at least one instruction/workflow file and produce canonical raw URLs.</description>
      <actions>
        <action>Consult `ai_instruction_modules/agent/agent-instructions-expert.md` for how to resolve canonical URLs and what sources are authoritative.</action>
        <action>Resolve the canonical raw URL for at least one of the following files: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md` OR `ai_instruction_modules/ai-core-instructions.md`.</action>
        <action>Show the URL translation you used (UI → raw) using the extracted branch value (no hardcoding).</action>
      </actions>
    </step>

    <step number="3">
      <title>Emit verifiable evidence</title>
      <description>Print explicit evidence lines and a resolution trace so reviewers can confirm the new lookup path was used.</description>
      <actions>
        <action>Print a resolution trace list of the exact files you consulted.</action>
        <action>Print the three required evidence lines: `[evidence] expert_invoked=true`, `[evidence] lookup_source=agent-instructions-expert`, `[evidence] branch_source=.github/copilot-instructions.md`.</action>
        <action>State explicitly: `No branch value was hardcoded; it was derived from .github/copilot-instructions.md.`</action>
      </actions>
    </step>
  </workflow>

  <validation>
    <step>Confirm all acceptance criteria are satisfied with evidence present in the output.</step>
    <step>If any criterion is not met, explicitly mark FAIL and state what is missing.</step>
  </validation>

  <notes>
    <note>This assignment is intentionally "self-describing". The output is the proof artifact.</note>
    <note>It does not attempt to detect "old way" programmatically; instead, it proves the "new way" by requiring explicit evidence lines and a resolution trace that includes `agent-instructions-expert`.</note>
  </notes>
</instructions>
