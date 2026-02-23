# Assignment: Create Workflow Plan

## (create-workflow-plan)

### Goal

Create a comprehensive workflow execution plan for the dynamic workflow currently being orchestrated. The plan covers how each workflow assignment will be executed in the context of the current project, drawing on a thorough reading of the dynamic workflow file, each constituent assignment, and all project planning documents in `plan_docs/`.

> **Note:** This is a plan for **executing the workflow assignments**, not a plan for implementing the application itself. The application plan is handled by the `create-app-plan` assignment later in the workflow.

### Prerequisites

- The invoking dynamic workflow file is accessible (e.g., `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/project-setup.md`)
- All referenced workflow assignment files are accessible under `ai_instruction_modules/ai-workflow-assignments/`
- The `plan_docs/` directory exists in the current repository and contains an app spec (e.g., `new app spec.md` or `ai-new-app-template.md`) and any supporting files
- Read access to the `nam20485/agent-instructions` canonical repository for remote assignment resolution

### Acceptance Criteria

1. The invoking dynamic workflow file has been read and fully understood, including its ordered list of assignments and any events.
2. Every workflow assignment referenced by the dynamic workflow has been traced and read completely.
3. All documents in `plan_docs/` have been read, starting with the primary app spec file (`new app spec.md` or equivalent).
4. A workflow execution plan has been produced that:
   - Lists each assignment in execution order with its short ID, goal, and key acceptance criteria
   - Summarizes project-specific context relevant to each assignment (derived from `plan_docs/`)
   - Identifies dependencies, sequencing constraints, and prerequisites between assignments
   - Notes any potential risks or challenges for each assignment given the project context
5. The plan has been presented to the user/stakeholder in a clear, structured format.
6. The user/stakeholder has reviewed the plan and approved it (or requested changes, which have been addressed and re-approved).
7. The approved plan is committed to the repository as `plan_docs/workflow-plan.md`.

### Assignment

Before any other workflow assignment begins executing, create a clear, project-specific workflow execution plan so that both the agent and stakeholders share a common understanding of what will happen, in what order, and why.

You will do this by reading the dynamic workflow, tracing every assignment it invokes, understanding the project through its planning documents, and synthesizing all of that into a structured plan document. The plan must be presented to the user, revised as needed, and explicitly approved before this assignment is considered complete.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

### Detailed Steps

#### 1. Resolve and Read the Invoking Dynamic Workflow

1. Identify the dynamic workflow file that invoked this assignment.
   - Typically located at `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/<workflow-name>.md`
   - If the workflow name was not passed as input, ask the orchestrator or check the session context for the active workflow.

2. Read the dynamic workflow file completely.
   - Note the ordered list of assignments in the script.
   - Note any events declared (e.g., `pre-assignment-begin`, `post-assignment-complete`, `on-assignment-failure`).
   - Note any input variables declared and their expected sources.
   - Record the workflow name and all assignment short IDs in the order they will execute.

3. Log the resolved workflow file path and its list of assignments.

#### 2. Trace and Read Each Workflow Assignment

For each assignment short ID discovered in Step 1, in execution order:

1. Resolve the assignment file path:
   - Local path: `ai_instruction_modules/ai-workflow-assignments/<assignment-id>.md`
   - Remote canonical RAW URL: `https://raw.githubusercontent.com/nam20485/agent-instructions/main/ai_instruction_modules/ai-workflow-assignments/<assignment-id>.md`
   - Prefer the local file if present; fall back to the remote canonical URL.

2. Read the full assignment file.
   - Record the assignment's **Goal**, **Prerequisites**, **Acceptance Criteria**, and **Detailed Steps**.
   - Note any events declared within the assignment.
   - Note any sub-assignments the assignment itself invokes.

3. Log the resolution trace: file path or URL used, and a one-sentence summary of the assignment's purpose.

#### 3. Read All Planning Documents

1. List all files in the `plan_docs/` directory.

2. Start with the primary app spec:
   - Look for a file named `new app spec.md`, `ai-new-app-template.md`, `app-spec.md`, or the closest equivalent.
   - Read it completely.

3. Read each remaining file in `plan_docs/` in the order that makes most logical sense (e.g., architecture before tech stack, tech stack before feature specifics).
   - Summarize the key facts from each document that are relevant to workflow execution (project name, technology stack, key constraints, repository name, special requirements, etc.).

4. Compile a **project context summary**: a short structured summary of the most important project facts that will influence how each assignment should be executed.

- This information will not be as relevant to this workflow planning assignment, since it contains actual application implementation details. But we are creating it now to ensure a shared understanding of the project context before any work begins. It will be critical for later assignments that execute the actual work.

#### 4. Produce the Workflow Execution Plan

Create a structured workflow execution plan document with the following sections:

---

**1. Overview**
- Workflow name and file reference
- Project name and brief description (from `plan_docs/`)
- Total number of assignments
- High-level summary of what the workflow accomplishes

**2. Project Context Summary**
- Key facts extracted from `plan_docs/` that are relevant to execution
- Technology stack, repository details, special constraints, known risks

**3. Assignment Execution Plan**

For each assignment (in execution order), document:

| Field | Content |
|---|---|
| **Assignment** | `<short-id>`: Title |
| **Goal** | One-sentence goal |
| **Key Acceptance Criteria** | Bulleted list of the most critical criteria |
| **Project-Specific Notes** | How this project's context affects execution of this assignment |
| **Prerequisites** | What must be complete before this assignment starts |
| **Dependencies** | Outputs from prior assignments this assignment relies on |
| **Risks / Challenges** | Known risks or potential issues specific to this project |
| **Events** | Any `pre-`/`post-`/`on-failure` events that will fire |

**4. Sequencing Diagram** (optional, text-based)
- A simple ordered flow showing assignment dependencies

**5. Open Questions**
- Any ambiguities in the planning docs or workflow that need stakeholder input before execution begins

---

#### 5. Present Plan to Stakeholder and Iterate

1. Post the completed workflow execution plan in the conversation.
2. Ask the stakeholder:
   > "Does this workflow execution plan look correct? Are there any changes needed, or do you approve it?"
3. If changes are requested:
   - Make the requested revisions to the plan.
   - Re-present the updated plan.
   - Repeat until the stakeholder explicitly approves the plan.
4. Record stakeholder approval in the session context before proceeding.

#### 6. Commit the Approved Plan

1. Save the approved plan as `plan_docs/workflow-plan.md` in the repository.
2. Commit the file with a descriptive message:
   ```
   docs: add workflow execution plan for <workflow-name>
   ```
3. Push the commit to the current working branch (create one if none exists yet, following the branch naming convention `dynamic-workflow-<workflow-name>`).
4. Verify the file is accessible in the repository.

### Completion

1. **Verify the Assignment is Complete:**
   - The dynamic workflow has been fully read and all assignments traced.
   - All `plan_docs/` files have been read and summarized.
   - The workflow execution plan covers every assignment in execution order.
   - The plan has been presented to and approved by the stakeholder.
   - `plan_docs/workflow-plan.md` has been committed and pushed.

2. **Present to Stakeholder:**
   - Confirm that `plan_docs/workflow-plan.md` is committed and available.
   - Summarize any open questions that still need resolution before later assignments begin.

3. **Notify Orchestrator:**
   - Report completion to the orchestrator with the path to the committed plan file.
   - Include the stakeholder's explicit approval statement.
   - Surface any open questions that the orchestrator should address before dispatching subsequent assignments.

### Notes

- This assignment reads and plans; it does **not** execute any other assignments.
- All canonical assignment files must be resolved from the remote repository (`nam20485/agent-instructions`) using RAW URLs when not available locally. Never use cached or stale local mirrors.
- If a `plan_docs/` directory does not exist, notify the stakeholder and ask them to provide planning documents before proceeding.
- The plan document (`workflow-plan.md`) will be referenced by subsequent assignments for project context; keep it accurate and up to date.
- If the dynamic workflow declares events (e.g., `post-assignment-complete`), include those event assignments in the trace and plan.
