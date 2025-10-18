# AI Workflow Development Guide

## Purpose
Use this guide when creating, modifying, or troubleshooting workflow assignments and dynamic workflows. This is the comprehensive reference for workflow system developers and orchestrators.

## When to Use This Guide
- Creating new workflow assignment files
- Creating new dynamic workflow scripts
- Modifying existing assignments or workflows
- Adding event-driven behaviors to workflows
- Troubleshooting workflow execution issues
- Understanding workflow system architecture
- Validating workflow syntax and structure

## Core Workflow System Files (Essential References)

Before developing workflows, familiarize yourself with these foundational files:

1. **[ai-workflow-assignments.md](./ai-workflow-assignments.md)**
   - Master index of all available workflow assignments
   - Assignment-based workflow overview
   - Authoritative execution requirements
   - Non-negotiable behaviors and guardrails
   - Dynamic workflow event system documentation

2. **[ai-workflow-config.md](./ai-workflow-config.md)**
   - Core workflow configuration and tool usage patterns
   - Event lifecycle points and orchestrator requirements
   - Sequential thinking and memory tool integration
   - Quality checklists and success metrics

3. **[orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)**
   - Complete orchestration assignment specification
   - Dynamic workflow file conventions
   - Script and event execution requirements
   - Guardrails, acceptance criteria, and run reports
   - Execution algorithm (intake → plan → execute → verify → report)

4. **[dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)**
   - Canonical DSL syntax specification
   - Variables, functions, control flow, and orchestration directives
   - Event declaration and execution rules
   - Complete workflow examples with events
   - Output recording conventions

5. **[validate-dynamic-workflow-script.md](./ai-workflow-assignments/validate-dynamic-workflow-script.md)**
   - Validation assignment for workflow scripts
   - Syntax and logical correctness checks
   - Event validation requirements
   - Quick DSL validation checklist

## Workflow Assignment Files Structure

### Location
```
ai_instruction_modules/
  ai-workflow-assignments/
    <assignment-short-id>.md           # Individual assignment files
    ai-workflow-assignment-empty-template.md  # Template for new assignments
    dynamic-workflows/
      <workflow-name>.md                # Dynamic workflow scripts
      dynamic-workflow-template.md      # Template for new dynamic workflows
      dynamic-workflow-syntax.md        # Canonical DSL reference
```

### Assignment Definition Format
Every workflow assignment file MUST contain these sections:
1. **Title** - Descriptive title
2. **Short ID** - Unique identifier in parentheses (e.g., `(create-epic)`)
3. **Goal** - Clear objective statement
4. **Acceptance Criteria** - Numbered list of completion requirements
5. **Assignment** - Detailed description
6. **Detailed Steps** - Step-by-step execution guide
7. **Completion** - Finalization instructions

### Key Assignment Files by Category

#### Planning & Setup
- **[create-app-plan.md](./ai-workflow-assignments/create-app-plan.md)** - Creating application development plans
- **[create-epic.md](./ai-workflow-assignments/create-epic.md)** - Creating epic sub-issues from plan phases
- **[create-story.md](./ai-workflow-assignments/create-story.md)** - Creating story sub-issues from epics
- **[create-project-structure.md](./ai-workflow-assignments/create-project-structure.md)** - Setting up project scaffolding

#### Initialization
- **[init-existing-repository.md](./ai-workflow-assignments/init-existing-repository.md)** - Initializing existing repos
- **[create-application.md](./ai-workflow-assignments/create-application.md)** - Creating new applications

#### Execution & Implementation
- **[perform-task.md](./ai-workflow-assignments/perform-task.md)** - Executing specific tasks
- **[continue-task-work.md](./ai-workflow-assignments/continue-task-work.md)** - Resuming in-progress work

#### Review & Quality
- **[pr-review-comments.md](./ai-workflow-assignments/pr-review-comments.md)** - Addressing PR comments
- **[pr-approval-and-merge.md](./ai-workflow-assignments/pr-approval-and-merge.md)** - PR approval workflow
- **[request-approval.md](./ai-workflow-assignments/request-approval.md)** - Stakeholder approval process
- **[create-test-cases.md](./ai-workflow-assignments/create-test-cases.md)** - Test case creation

#### Analysis & Documentation
- **[analyze-plan-issue.md](./ai-workflow-assignments/analyze-plan-issue.md)** - Plan fitness analysis
- **[analyze-progress-doc.md](./ai-workflow-assignments/analyze-progress-doc.md)** - Progress analysis
- **[update-plan-issue.md](./ai-workflow-assignments/update-plan-issue.md)** - Plan updates from analysis
- **[debrief-and-document.md](./ai-workflow-assignments/debrief-and-document.md)** - Post-workflow debriefs

#### Orchestration
- **[orchestrate-new-project.md](./ai-workflow-assignments/orchestrate-new-project.md)** - End-to-end project orchestration
- **[orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)** - Dynamic workflow orchestration

### Available Dynamic Workflows
- **[implement-by-stories.md](./ai-workflow-assignments/dynamic-workflows/implement-by-stories.md)** - Story-based implementation
- **[implement-epic.md](./ai-workflow-assignments/dynamic-workflows/implement-epic.md)** - Single epic implementation
- **[analyze-plan.md](./ai-workflow-assignments/dynamic-workflows/analyze-plan.md)** - Plan analysis workflow
- **[breakdown-plan.md](./ai-workflow-assignments/dynamic-workflows/breakdown-plan.md)** - Breaking plans into epics
- **[breakdown-epic.md](./ai-workflow-assignments/dynamic-workflows/breakdown-epic.md)** - Breaking epics into stories
- **[design-app-outline.md](./ai-workflow-assignments/dynamic-workflows/design-app-outline.md)** - Application design workflow

## Dynamic Workflow DSL Quick Reference

### Variables
```markdown
`$variable` = <value>                    # Define variable
`${variable}` = <value>                  # Define variable (brace format)
const `$VARIABLE`: <value>               # Define constant
`$variable`                              # Use variable
${variable}                              # Use variable (brace format)
```

### Step References
```markdown
#<step>                                  # Reference output of a step
#<step>.<substep>                        # Reference output of substep/assignment
#events.<event-name>                     # Reference event output (singular)
#events.<event-name>.$assignment_name    # Reference event output (loop)
```

### Functions and Data Structures
```markdown
get-function-name(<parameters>)          # Call a function
[ item1, item2, item3 ]                  # Define a list
$object_variable->property               # Access object property
```

### Control Flow
```markdown
For each $item in $list, you will:       # Iterate over a list
  - indented action 1
  - indented action 2
  
if $variable is true:                    # Conditional (true)
  - indented action
  
if $variable is false:                   # Conditional (false)
  - indented action
```

### Orchestration Directives (Standard Pattern)
```markdown
- assign the agent the 'assignment-id' assignment with input $variable
- wait until the agent finishes the task
- review the work and approve it
- record output as #step.substep
```

## Dynamic Workflow Event System

### Event Types and Lifecycle Points

**Pre-Execution Events:**
- `pre-script-begin` - Executes once before any workflow steps begin
  - Use for: environment validation, prerequisite checks, initialization
- `pre-assignment-begin` - Executes before each assignment in a loop iteration starts
  - Use for: per-assignment setup, context preparation, logging

**Post-Execution Events:**
- `post-assignment-completion` - Executes after each assignment in a loop completes successfully
  - Use for: cleanup, documentation updates, notifications, summary generation
- `post-script-complete` - Executes once after all workflow steps complete successfully
  - Use for: final reporting, stakeholder notification, workflow metrics

**Failure-Handling Events:**
- `on-assignment-failure` - Executes when an assignment fails
  - Use for: error logging, partial rollback, diagnostic collection
- `on-script-failure` - Executes when the entire script fails
  - Use for: full rollback, cleanup, failure notification

### Event Declaration Syntax

Events are declared as fourth-level headings under a third-level "Events" step:

```markdown
### Events

#### `pre-script-begin`
- validate environment prerequisites
- ensure authentication is configured
- record validation results as `#events.pre-script-begin`

#### `post-assignment-completion`

`$cleanup_assignments` = [`create-repository-summary`, `update-documentation`]

For each `$assignment_name` in `$cleanup_assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until the agent finishes the task
   - review the work and approve it
   - record output as `#events.post-assignment-completion.$assignment_name`
```

### Event Execution Rules

1. **Timing is Mandatory**: Events MUST execute at their exact lifecycle point
   - Orchestrators must check for event definitions and execute them at the correct time
   - Missing or delayed event execution violates the workflow contract

2. **Scope and Context**:
   - Events have access to all script variables, outputs, and current state
   - Loop events (pre/post-assignment) can access the current `$assignment_name` and iteration context
   - Singular events (pre/post-script) access the entire workflow context

3. **Execution Order**:
   ```
   1. pre-script-begin (once)
   2. For each main step:
      a. pre-assignment-begin (if loop, per iteration)
      b. assignment execution
      c. post-assignment-completion (if loop, per iteration)
   3. post-script-complete (once, if all succeed)
      OR
      on-script-failure (once, if any fail)
   ```

4. **Failure Handling**:
   - If an event fails, the entire workflow fails (except for `on-*-failure` events)
   - `on-assignment-failure` and `on-script-failure` should be defensive and not throw errors
   - Use failure events for cleanup, logging, and notification only—not for additional work

5. **Output Recording**:
   - Loop events: `#events.<event-name>.$assignment_name`
   - Singular events: `#events.<event-name>`
   - Event outputs must be included in the Run Report

## Orchestrator Responsibilities

### Pre-Execution (Mandatory)
1. **Resolution Trace** - Print dereference chain with URLs/SHAs:
   - `orchestrate-dynamic-workflow → dynamic-workflows/$workflow_name → assignments → ai-workflow-assignments/<assignment>.md`
   - Refuse to proceed if any file is unreadable

2. **Parse Events** - If workflow contains "Events" section:
   - Identify all event definitions and their types
   - Validate event names against standard types
   - Plan event execution at correct lifecycle points

### During Execution (Non-Negotiable)
1. **Assignment-First Execution** - Execute steps ONLY from resolved assignment files
   - Do not infer or synthesize steps from dynamic workflow files
   - Do not use close-but-not-exact matches for assignment names

2. **Event Execution** - At each lifecycle point:
   - Check for corresponding event definition
   - Execute event script with full context access
   - Record event outputs per convention
   - Gate on event success (workflow fails if event fails, except failure events)

3. **Acceptance Criteria Gating** - Treat as Definition of Done:
   - Extract criteria from each assignment file
   - No partial completion - all criteria must pass
   - Record PASS/FAIL with evidence links

4. **Template & Preflight Enforcement**:
   - Verify template/source-of-truth requirements
   - Check environment prerequisites
   - Respect branch protection (use feature branch + PR for code changes)

### Post-Execution (Required)
1. **Run Report** - Produce comprehensive report containing:
   - Resolution trace (files + URLs/SHAs)
   - Actions executed (mirroring Detailed Steps)
   - **Event executions** (all events executed with outputs)
   - Acceptance Criteria: PASS/FAIL per item with evidence
   - Deviations (if any) with rationale
   - Outcome: Success only if all criteria PASS

2. **Run Log** - Maintain detailed log of:
   - Actions taken at dynamic workflow level
   - Actions taken at individual assignment level
   - All agent delegation events
   - Decisions made and issues encountered

## Common Workflows for Modification

### Adding a New Workflow Assignment

1. **Create Assignment File**:
   - Copy template: `ai-workflow-assignment-empty-template.md`
   - Place in: `ai_instruction_modules/ai-workflow-assignments/`
   - Name format: `<short-id>.md` (e.g., `perform-analysis.md`)

2. **Complete All Sections**:
   - Title: Descriptive name
   - Short ID: Unique kebab-case identifier in parentheses
   - Goal: Clear, concise objective
   - Acceptance Criteria: Specific, measurable requirements (numbered list)
   - Assignment: Detailed description
   - Detailed Steps: Step-by-step instructions with sub-bullets
   - Completion: Finalization and next steps

3. **Add to Master Index**:
   - Update `ai-workflow-assignments.md`
   - Add to appropriate category section
   - Include link with short description

4. **Validate**:
   - Ensure all template sections are complete
   - Verify acceptance criteria are measurable
   - Check that steps are unambiguous
   - Test by running assignment end-to-end

### Adding a New Dynamic Workflow

1. **Create Workflow File**:
   - Copy template: `dynamic-workflow-template.md`
   - Place in: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/`
   - Name format: `<workflow-name>.md` (e.g., `implement-feature.md`)

2. **Define Workflow Structure**:
   ```markdown
   # Dynamic Workflow: <Title>
   
   ## Overview
   Brief description of the workflow's purpose.
   
   ## Script
   
   ### Inputs
   - `$param1` (required/optional): Description
   - `$param2` (required/optional): Description
   
   ### step-one
   `$assignments` = [`assignment-id-1`, `assignment-id-2`]
   
   For each `$assignment_name` in `$assignments`, you will:
      - assign the agent the `$assignment_name` assignment
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#step-one.$assignment_name`
   ```

3. **Add Events (Optional but Recommended)**:
   ```markdown
   ### Events
   
   #### `pre-script-begin`
   - validate prerequisites
   - record results as `#events.pre-script-begin`
   
   #### `post-assignment-completion`
   `$cleanup_tasks` = [`create-repository-summary`]
   
   For each `$assignment_name` in `$cleanup_tasks`, you will:
      - assign the agent the `$assignment_name` assignment
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#events.post-assignment-completion.$assignment_name`
   
   #### `post-script-complete`
   - generate final report
   - record completion as `#events.post-script-complete`
   ```

4. **Validate Workflow**:
   - Run `validate-dynamic-workflow-script` assignment with `$workflow_name`
   - Check all referenced assignment short IDs exist
   - Verify event definitions (if present) use standard event types
   - Ensure DSL syntax is correct
   - Test by orchestrating the workflow end-to-end

5. **Add to Master Index**:
   - Update `ai-workflow-assignments.md` in "Available Dynamic Workflow Scripts" section
   - Include link with brief description

### Modifying Existing Assignments

1. **Read Current Assignment** - Understand existing structure and acceptance criteria
2. **Identify Changes** - Clearly define what needs to change and why
3. **Update Sections** - Modify only necessary sections:
   - If changing goals → update Goal, Acceptance Criteria, Assignment
   - If changing process → update Detailed Steps
   - If adding requirements → update Acceptance Criteria
4. **Maintain Consistency** - Ensure all sections remain aligned
5. **Test Changes** - Run assignment to verify modifications work as intended

### Modifying Dynamic Workflows

1. **Read Current Workflow** - Understand the existing script structure
2. **Identify Changes**:
   - Adding/removing assignment steps
   - Changing execution order
   - Adding/modifying events
   - Updating inputs or variables
3. **Update Script Section**:
   - Follow canonical DSL syntax from `dynamic-workflow-syntax.md`
   - Maintain proper indentation for control flow
   - Use correct quoting conventions (backticks for IDs, single quotes for strings)
4. **Update Events (if applicable)**:
   - Add new event definitions as fourth-level headings
   - Ensure event names match standard types
   - Follow DSL syntax within event scripts
5. **Validate** - Run `validate-dynamic-workflow-script` before using
6. **Test** - Orchestrate the workflow to verify changes

## Key Principles for Success

### Non-Negotiable Behaviors
1. **Resolution Trace Before Execution** - Always print files + URLs/SHAs
2. **Assignment-First Execution** - No step synthesis from higher-level files
3. **Acceptance-Criteria Gating** - Definition of Done, no partial completion
4. **Template and Preflight Enforcement** - Where specified by assignment
5. **Branch-Protection-Aware** - Feature branch + PR for code changes
6. **Required Run Report** - Mapped 1:1 to Acceptance Criteria with evidence

### Event System Principles
1. **Timing is Critical** - Events execute at exact lifecycle points
2. **Context Access** - Events have full access to variables and outputs
3. **Defensive Failure Events** - Failure handlers should not throw errors
4. **Complete Documentation** - All events recorded in Run Report

### Quality Checklist
Before finalizing any workflow or assignment:
- [ ] All referenced files exist and are readable
- [ ] All assignment short IDs referenced actually exist
- [ ] DSL syntax follows canonical specification
- [ ] Event definitions (if present) use standard event types
- [ ] Acceptance criteria are specific and measurable
- [ ] Detailed steps are unambiguous and executable
- [ ] Output recording follows conventions
- [ ] Resolution trace can be printed successfully
- [ ] Workflow validated using `validate-dynamic-workflow-script`

## Templates

### Assignment Template Location
```
ai_instruction_modules/ai-workflow-assignments/ai-workflow-assignment-empty-template.md
```

### Dynamic Workflow Template Location
```
ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-template.md
```

## Troubleshooting

### Common Issues and Solutions

**Issue**: Workflow fails with "assignment not found"
- **Solution**: Verify assignment short ID exists in `ai-workflow-assignments/` directory
- **Check**: Assignment file name matches short ID exactly (kebab-case)

**Issue**: Event not executing
- **Solution**: Verify event is declared as fourth-level heading under "Events" step
- **Check**: Event name matches standard types exactly (case-sensitive)

**Issue**: Output reference not working
- **Solution**: Verify output recording convention is correct
- **Check**: Loop events use `#events.<event-name>.$assignment_name`
- **Check**: Singular events use `#events.<event-name>`

**Issue**: Validation fails with syntax errors
- **Solution**: Compare against canonical syntax in `dynamic-workflow-syntax.md`
- **Check**: Variables defined before use
- **Check**: Proper quoting conventions (backticks for IDs, not for variables)
- **Check**: Indentation correct for control flow structures

**Issue**: Acceptance criteria not met
- **Solution**: Review assignment file's Acceptance Criteria section
- **Check**: All criteria addressed in detailed steps
- **Check**: Evidence can be provided for each criterion
- **Check**: No ambiguous or unmeasurable criteria

## Quick Start Examples

### Example 1: Orchestrate an Existing Dynamic Workflow
```markdown
1. Read the workflow file: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/breakdown-plan.md`
2. Read the orchestration assignment: `ai_instruction_modules/ai-workflow-assignments/orchestrate-dynamic-workflow.md`
3. Run validation: assign yourself `validate-dynamic-workflow-script` with $workflow_name=`breakdown-plan`
4. If validation passes, assign yourself `orchestrate-dynamic-workflow` with $workflow_name=`breakdown-plan`
5. Follow the orchestration assignment's detailed steps exactly
6. Execute all events at their designated lifecycle points
7. Produce the Run Report with evidence for all acceptance criteria
```

### Example 2: Create a New Simple Assignment
```markdown
1. Copy template: `ai_instruction_modules/ai-workflow-assignments/ai-workflow-assignment-empty-template.md`
2. Save as: `ai_instruction_modules/ai-workflow-assignments/my-new-task.md`
3. Fill in all sections:
   - Title: "Create Feature Documentation"
   - Short ID: (create-feature-docs)
   - Goal: "Create comprehensive documentation for a new feature"
   - Acceptance Criteria: List 5-10 specific, measurable criteria
   - Assignment: Detailed description of the task
   - Detailed Steps: Step-by-step instructions with sub-bullets
   - Completion: Finalization steps
4. Add to master index in `ai-workflow-assignments.md`
5. Test by running the assignment
```

### Example 3: Add Events to Existing Dynamic Workflow
```markdown
1. Read the existing workflow file
2. Add "Events" section as third-level heading under "Script":
   
   ### Events
   
   #### `pre-script-begin`
   - validate environment
   - record as `#events.pre-script-begin`
   
   #### `post-assignment-completion`
   `$summary_tasks` = [`create-repository-summary`]
   
   For each `$assignment_name` in `$summary_tasks`, you will:
      - assign the agent the `$assignment_name` assignment
      - wait until the agent finishes the task
      - review the work and approve it
      - record output as `#events.post-assignment-completion.$assignment_name`
   
3. Validate using `validate-dynamic-workflow-script`
4. Test by orchestrating the workflow
5. Verify events execute at correct lifecycle points
6. Confirm event outputs appear in Run Report
```

### Example 4: Validate Before Orchestrating
```markdown
1. Assign yourself: `validate-dynamic-workflow-script`
2. Provide input: $workflow_name=`implement-by-stories`
3. Check validation output:
   - Syntax correctness
   - All assignment IDs exist
   - Event definitions valid (if present)
   - Logical structure coherent
4. If validation passes: proceed to orchestration
5. If validation fails: fix issues and re-validate
```

## Additional Resources

### Agent Script Engine
For advanced workflow scripting concepts:
- **[agent-script-engine.md](./agent-script-engine.md)**
  - AOT vs JIT execution
  - Function declarations and script structure
  - Advanced examples

### Workflow Roles
For role-based workflow context:
- **[ai-workflow-roles.md](./ai-workflow-roles.md)**
  - Orchestrator role definition and responsibilities
  - Collaborator role definition and responsibilities
  - Role assignment process

### Core Instructions
For general development context:
- **[ai-core-instructions.md](./ai-core-instructions.md)**
  - Persona and technology scope
  - Hierarchy and conflict resolution
  - Core behaviors and constraints
  - Required and optional instruction modules

## Summary

This guide provides comprehensive reference material for developing and modifying AI workflow assignments and dynamic workflows. Key takeaways:

1. **Always read core files first** - Master index, config, orchestration, and syntax files
2. **Follow non-negotiable behaviors** - Resolution trace, assignment-first execution, acceptance gating
3. **Use templates** - Start with empty templates for new assignments and workflows
4. **Validate before executing** - Use `validate-dynamic-workflow-script` assignment
5. **Implement events properly** - Follow event lifecycle rules and execution order
6. **Produce Run Reports** - Document all actions, events, and acceptance criteria results
7. **Test thoroughly** - Run assignments and workflows end-to-end before considering complete

For questions or issues, refer back to the canonical reference files listed in the "Core Workflow System Files" section.

---

**Last Updated**: 2025-10-17  
**Maintainer**: AI Workflow System  
**Version**: 1.0
