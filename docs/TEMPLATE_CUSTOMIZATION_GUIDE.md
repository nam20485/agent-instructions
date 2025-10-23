# Template Customization Guide

**Version**: 1.0  
**Last Updated**: 2025-10-21  
**Status**: Active

---

## Overview

This guide explains how to customize the three workflow assignment templates (BEFORE_STARTING, PROGRESS_REPORTING, ERROR_RECOVERY) for different assignments. These templates enhance workflow execution by providing structured preparation, progress tracking, and error handling.

## Template Locations

All three templates are located in `ai_instruction_modules/ai-workflow-assignments/`:

- `BEFORE_STARTING_TEMPLATE.md` - Pre-execution preparation checklist
- `PROGRESS_REPORTING_TEMPLATE.md` - Progress tracking for long-running assignments
- `ERROR_RECOVERY_TEMPLATE.md` - Error handling and troubleshooting

## When to Use Each Template

### BEFORE_STARTING Template

**Use for**: ALL workflow assignments

**Purpose**: Ensures agents are properly prepared before starting work

**Benefits**:
- Reduces false starts and wasted effort
- Ensures prerequisites are met
- Provides clear context about the task
- Sets realistic expectations

**Placement**: After "Assignment" section, before "Detailed Steps"

---

### PROGRESS_REPORTING Template

**Use for**: Long-running assignments (>30 minutes estimated time)

**Purpose**: Provides visibility into progress and enables early issue detection

**Benefits**:
- Tracks progress through multi-step workflows
- Enables early detection of problems
- Provides stakeholders with status updates
- Helps agents stay organized

**Placement**: After "Detailed Steps" section, before "Error Recovery"

**Time Threshold**: Use for assignments estimated at >30 minutes

---

### ERROR_RECOVERY Template

**Use for**: ALL workflow assignments

**Purpose**: Provides structured error handling and troubleshooting guidance

**Benefits**:
- Reduces downtime from errors
- Provides clear recovery paths
- Documents common problems
- Ensures consistent error handling

**Placement**: After "Detailed Steps" (or "Progress Reporting" if present), before "Completion"

---

## Customization Approach

### General Principles

1. **Start with base template** - Copy the template content as-is
2. **Identify assignment-specific elements** - Look for placeholders and generic content
3. **Customize systematically** - Work through each section
4. **Validate completeness** - Ensure all placeholders are replaced
5. **Test readability** - Ensure customizations make sense in context

### Customization Process

#### Step 1: Copy Base Template

Copy the entire template content from the template file into your assignment file at the appropriate location.

#### Step 2: Identify Placeholders

Look for these common placeholders:
- `[ESTIMATED_TIME]` - Assignment duration estimate
- `[MILESTONE_NAME]` - Checkpoint/phase names
- `[Task X]` - Specific tasks for checkpoints
- Generic examples that need assignment-specific details

#### Step 3: Customize Section-by-Section

Work through each section systematically, replacing placeholders and generic content with assignment-specific details.

---

## BEFORE_STARTING Customization

### Section 1: Read Assignment Completely

**No customization needed** - This section is generic and applies to all assignments.

### Section 2: Gather Context

**Minor customization needed** - Keep generic checklist, optionally add assignment-specific context items.

**Example customization**:
```markdown
- Review project documentation
  - Read README and setup guides
  - Check architecture documentation
  - Review coding standards
  - **[CUSTOM]** Review API documentation for integration points
```

### Section 3: Verify Prerequisites

**Moderate customization needed** - Replace generic tool requirements with assignment-specific tools.

**Template**:
```markdown
- Check that required tools are installed
  - Runtime environment (Node.js, Python, etc.)
  - Build tools
  - Package managers
  - Development tools
```

**Customized example** (from `create-app-plan.md`):
```markdown
- Check that required tools are installed
  - GitHub CLI for issue/milestone creation
  - Git for repository access
  - Markdown editor/viewer
```

**Key customizations**:
- List specific tools needed for this assignment
- Identify specific versions if critical
- Note any optional tools that enhance experience

### Section 4: Create Task List

**Moderate customization needed** - Add assignment-specific task breakdown and time estimates.

**Template**:
```markdown
- Break down steps into specific tasks
  - List all major tasks
  - Identify subtasks
  - Estimate time for each
```

**Customized example** (from `create-app-plan.md`):
```markdown
- Break down steps into specific tasks
  - Review application template (~15 min)
  - Analyze supporting documents (~15 min)
  - Design plan structure (~20 min)
  - Create issue from template (~10 min)
  - Create milestones (~10 min)
  - Iterate on feedback (~variable)
```

**Key customizations**:
- List major tasks from "Detailed Steps"
- Add time estimates for each task
- Include iteration/feedback cycles if applicable
- Identify assignment-specific challenges

### Section 5: Estimate Time

**Moderate customization needed** - Provide realistic time estimate and context-specific factors.

**Template**:
```markdown
- Review estimated time for assignment
  - Understand the baseline estimate
  - Consider assignment complexity
- Consider your specific context
  - Your familiarity with tech stack
  - Complexity of the project
  - Any unique challenges
```

**Customized example** (from `create-app-plan.md`):
```markdown
- Review estimated time for assignment
  - Baseline: 45-60 minutes
  - Consider assignment complexity
- Consider your specific context
  - Familiarity with application domain
  - Complexity of requirements
  - Number of supporting documents
  - Stakeholder availability for feedback
```

**Key customizations**:
- Provide baseline time estimate (e.g., "45-60 minutes", "2-3 hours")
- List assignment-specific complexity factors
- Account for external dependencies (reviewers, stakeholders, etc.)

### Section 6: Prepare Environment

**Moderate customization needed** - List assignment-specific workspace setup and resources.

**Template**:
```markdown
- Set up workspace
  - Close unnecessary applications
  - Open required tools
  - Prepare terminal/IDE
- Gather required resources
  - Documentation links
  - Reference materials
  - Example code
```

**Customized example** (from `create-app-plan.md`):
```markdown
- Set up workspace
  - Open `plan_docs/` directory
  - Have application template ready
  - Open issue template file
  - Prepare note-taking tool
- Gather required resources
  - Reference examples (GitHub issues linked)
  - GitHub issue template location
  - Milestone naming conventions
  - Tech stack documentation
```

**Key customizations**:
- List specific directories/files to open
- Identify assignment-specific tools
- Link to reference examples
- Note any required templates

---

## PROGRESS_REPORTING Customization

### Overall Structure

The template provides 4 checkpoints by default:
- Checkpoint 1: 25% complete
- Checkpoint 2: 50% complete
- Checkpoint 3: 75% complete
- Final Checkpoint: 100% complete

### Customization Steps

#### Step 1: Replace [ESTIMATED_TIME]

In the header, replace `[ESTIMATED_TIME]` with your assignment's time estimate.

**Before**:
```markdown
This assignment has multiple steps and may take [ESTIMATED_TIME] minutes.
```

**After**:
```markdown
This assignment has multiple steps and may take 45-60 minutes.
```

#### Step 2: Name Your Milestones

Replace `[MILESTONE_NAME]` with descriptive names based on your assignment's phases.

**Before**:
```markdown
### Checkpoint 1: [MILESTONE_NAME] (25% complete)
```

**After**:
```markdown
### Checkpoint 1: Template Analysis Complete (25% complete)
```

**Naming tips**:
- Use outcome-focused names ("Analysis Complete", "Foundation Built")
- Make names specific to your assignment
- Keep names concise (3-5 words)

#### Step 3: Define Tasks for Each Checkpoint

Replace `[Task 1]`, `[Task 2]`, etc. with specific tasks from your "Detailed Steps".

**Before**:
```markdown
**Tasks**:
- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]
```

**After**:
```markdown
**Tasks**:
- [ ] Application template reviewed and understood
- [ ] Supporting documents analyzed
- [ ] Requirements identified and documented
- [ ] Ambiguities identified for clarification
```

**Task definition tips**:
- Use action-oriented task descriptions
- Make tasks specific and measurable
- Group related tasks together
- Aim for 3-5 tasks per checkpoint

#### Step 4: Customize Example Reports

Update the example report templates to reflect assignment-specific outputs.

**Before**:
```markdown
**Example Report**:
\```
✅ Checkpoint 1 Complete (25%)
- Completed: [list completed tasks]
- Issues: [any issues or none]
- Time remaining: ~[X] minutes
- Next: [next checkpoint name]
\```
```

**After**:
```markdown
**Example Report**:
\```
✅ Checkpoint 1 Complete (25%)
- Completed: Reviewed ai-new-app-template.md and 3 supporting docs
- Issues: Found 2 ambiguous requirements, need stakeholder clarification
- Time remaining: ~40 minutes
- Next: Design plan structure
\```
```

**Example customization tips**:
- Use realistic examples from actual execution
- Show common issues that might arise
- Provide meaningful time estimates
- Reference specific artifacts/deliverables

#### Step 5: Adjust Number of Checkpoints

If your assignment is significantly shorter or longer, adjust checkpoint count:

**Short assignments (30-45 minutes)**: Use 3 checkpoints (33%, 66%, 100%)

**Medium assignments (45-90 minutes)**: Use 4 checkpoints (default: 25%, 50%, 75%, 100%)

**Long assignments (>90 minutes)**: Use 5-6 checkpoints (20%, 40%, 60%, 80%, 100%)

### Full Customization Example

See `create-app-plan.md` lines 176-310 for a complete example of customized progress reporting.

---

## ERROR_RECOVERY Customization

### Section 1: Common Errors

**Heavy customization needed** - Replace generic errors with assignment-specific errors.

The template provides common errors:
- Dependency Installation Fails
- Build Fails
- Type Checking Fails
- Linter/Formatter Fails
- Tests Fail
- Container Build Fails
- CI/CD Pipeline Fails

**Customization approach**:

1. **Keep relevant errors** - If your assignment involves building/testing, keep those sections
2. **Remove irrelevant errors** - If no containers involved, remove "Container Build Fails"
3. **Add assignment-specific errors** - Add errors unique to this assignment

**Example assignment-specific error** (from `create-app-plan.md`):

```markdown
#### Error: Issue Creation Fails
- **Symptoms**: GitHub CLI errors, permission denied, API rate limits
- **Possible Causes**:
  - Not authenticated with GitHub CLI
  - Insufficient repository permissions
  - API rate limiting
  - Invalid issue template syntax
- **Solutions**:
  1. Run `gh auth login` to authenticate
  2. Verify you have write access to repository
  3. Wait and retry if rate limited
  4. Validate issue template markdown syntax
  5. Check repository settings allow issue creation
```

**Customization tips**:
- Focus on errors specific to your assignment's domain
- Include common pitfalls from past executions
- Provide actionable, step-by-step solutions
- Reference assignment-specific tools/commands

### Section 2: Escalation Procedure

**Minor customization needed** - Adjust issue labels and assignment references.

**Template**:
```markdown
2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug" and "needs-investigation"
   - Link to this assignment
```

**Customized**:
```markdown
2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug", "needs-investigation", and "planning"
   - Link to this assignment (create-app-plan)
```

**Key customizations**:
- Add assignment-specific labels
- Reference the assignment by name/ID

### Section 3: Rollback Procedure

**No customization needed** - Generic rollback procedure applies to all assignments.

Optionally, add assignment-specific rollback notes:

```markdown
**Assignment-Specific Rollback Notes**:
- Delete created GitHub issues
- Remove created milestones
- Delete generated plan documentation files
```

### Section 4: Prevention Tips

**No customization needed** - Generic prevention tips apply to all assignments.

Optionally, add assignment-specific prevention tips at the end.

---

## Complete Customization Examples

### Example 1: create-app-plan.md

**Assignment type**: Planning/Documentation (no code)  
**Duration**: 45-60 minutes  
**Templates used**: All three

**Key customizations**:
- **BEFORE_STARTING**: 
  - Tools: GitHub CLI, Git, Markdown editor
  - Task breakdown with time estimates
  - Workspace: `plan_docs/` directory, issue templates
- **PROGRESS_REPORTING**:
  - 4 checkpoints aligned with analysis→design→creation→approval flow
  - Examples reference issue creation and stakeholder feedback
- **ERROR_RECOVERY**:
  - Custom error: "Issue Creation Fails"
  - Assignment-specific labels: "planning"

**Full file**: `ai_instruction_modules/ai-workflow-assignments/create-app-plan.md`

### Example 2: init-existing-repository.md

**Assignment type**: Repository setup and configuration  
**Duration**: 15-20 minutes  
**Templates used**: All three

**Key customizations**:
- **BEFORE_STARTING**:
  - Tools: Git, GitHub CLI
  - Prerequisites: Repository URL, local workspace
  - Short task list (5 tasks, 3-5 min each)
- **PROGRESS_REPORTING**:
  - 3 checkpoints (33%, 66%, 100%) - assignment is shorter
  - Examples reference git commands and configuration
- **ERROR_RECOVERY**:
  - Custom errors: "Git Clone Fails", "Permission Errors"
  - Repository-specific rollback notes

**Full file**: `ai_instruction_modules/ai-workflow-assignments/init-existing-repository.md`

### Example 3: validate-assignment-completion.md

**Assignment type**: Validation and verification  
**Duration**: 10-15 minutes  
**Templates used**: All three

**Key customizations**:
- **BEFORE_STARTING**:
  - Tools: Testing frameworks, validation scripts
  - Prerequisites: Assignment to validate must be complete
  - Simple task list (validation-focused)
- **PROGRESS_REPORTING**:
  - 3 checkpoints for short validation workflow
  - Examples reference test execution and report generation
- **ERROR_RECOVERY**:
  - Custom errors: "Validation Fails", "Acceptance Criteria Not Met"
  - Assignment-specific escalation for validation failures

**Full file**: `ai_instruction_modules/ai-workflow-assignments/validate-assignment-completion.md`

---

## Customization Checklist

Use this checklist when customizing templates for a new assignment:

### BEFORE_STARTING
- [ ] Section 3: Replaced generic tools with assignment-specific tools
- [ ] Section 3: Listed assignment-specific dependencies
- [ ] Section 4: Broken down major tasks with time estimates
- [ ] Section 4: Identified assignment-specific challenges
- [ ] Section 5: Provided baseline time estimate
- [ ] Section 5: Listed context-specific complexity factors
- [ ] Section 6: Specified workspace setup (directories/files)
- [ ] Section 6: Listed assignment-specific resources

### PROGRESS_REPORTING
- [ ] Replaced [ESTIMATED_TIME] with assignment time estimate
- [ ] Named all checkpoint milestones appropriately
- [ ] Defined 3-5 specific tasks for each checkpoint
- [ ] Customized example reports with realistic outputs
- [ ] Adjusted number of checkpoints based on duration
- [ ] Validated checkpoint percentages match task distribution

### ERROR_RECOVERY
- [ ] Kept relevant generic errors
- [ ] Removed irrelevant generic errors
- [ ] Added 2-3 assignment-specific errors
- [ ] Provided actionable solutions for each error
- [ ] Customized issue labels in escalation procedure
- [ ] Added assignment-specific rollback notes (if applicable)
- [ ] Added assignment-specific prevention tips (if applicable)

---

## Best Practices

### Time Estimation

**How to estimate assignment duration:**

1. **Break down major steps** - List all major activities from "Detailed Steps"
2. **Estimate per step** - Assign time to each step (optimistic estimate)
3. **Add buffer** - Add 20-30% buffer for unknowns
4. **Round up** - Round to nearest 5 or 15 minutes
5. **Provide range** - Express as range (e.g., "45-60 minutes" not "52 minutes")

**Example calculation**:
```
Step 1: Review template (10 min)
Step 2: Analyze docs (10 min)
Step 3: Design structure (15 min)
Step 4: Create issue (5 min)
Step 5: Create milestones (5 min)
Subtotal: 45 minutes
Buffer (20%): +9 minutes
Rounded total: 45-60 minutes
```

### Checkpoint Distribution

**How to distribute checkpoints:**

- **25% checkpoint**: Complete initial analysis/setup
- **50% checkpoint**: Complete core work/implementation
- **75% checkpoint**: Complete refinement/integration
- **100% checkpoint**: Complete validation/documentation

**Balance checkpoint workload:**
- Each checkpoint should have roughly equal effort
- If one checkpoint has 10 tasks and others have 3, rebalance
- Aim for 3-5 tasks per checkpoint

### Error Scenario Selection

**Prioritize these error types:**

1. **High probability** - Errors that commonly occur in this type of assignment
2. **High impact** - Errors that block progress completely
3. **Non-obvious** - Errors where the solution isn't immediately clear
4. **Assignment-specific** - Errors unique to this assignment's domain

**Don't include:**
- Extremely rare edge cases
- Errors covered by generic categories
- Errors with obvious solutions

---

## Reference Examples

All four completed assignment files serve as customization examples:

1. **`create-app-plan.md`**
   - Medium-length planning assignment
   - Stakeholder interaction
   - Documentation focus

2. **`init-existing-repository.md`**
   - Short setup assignment
   - Git/GitHub focus
   - Configuration emphasis

3. **`validate-assignment-completion.md`**
   - Short validation assignment
   - Testing focus
   - Quality gates

4. **`debrief-and-document.md`**
   - Medium-length documentation assignment
   - Retrospective focus
   - Knowledge capture

---

## Related Documentation

- **Template files**: `ai_instruction_modules/ai-workflow-assignments/*_TEMPLATE.md`
- **Workflow syntax**: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md`
- **Assignment structure**: See any assignment file in `ai_instruction_modules/ai-workflow-assignments/`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-10-21 | Initial guide created with examples from 4 completed assignments |

---

**Next Steps**: After customizing templates for a new assignment, test the assignment execution to validate:
- Time estimates are realistic
- Checkpoints align with actual workflow
- Error scenarios are complete
- Examples are accurate
