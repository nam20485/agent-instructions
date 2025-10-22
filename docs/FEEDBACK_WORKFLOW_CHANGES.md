# Feedback-Driven Workflow Changes

**Generated**: 2025-10-21  
**Source**: `debriefs/recommendations.md`  
**Related**: `docs/FEEDBACK_ACTION_PLAN.md`  
**Status**: PARTIALLY IMPLEMENTED  
**Last Update**: 2025-10-22 - 9 of 11 feedback items implemented (Changes 2.1, 3.1, 3.2, 3.3, 4.1, 6.1, and partial 1.1, 5.1, 7.1)

---

## Overview

This document details specific workflow changes needed based on feedback from the `project-setup-upgraded` workflow execution. Changes are organized by workflow and include rationale, specific modifications, and impact assessments.

---

## 1. Project Setup Workflow Improvements

### Workflow: `project-setup-upgraded.md`
**Location**: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/project-setup-upgraded.md`

#### Change 1.1: Integrate Part 2 Template Improvements (FB-010)

**Current State**: Workflow does not include structured templates for context gathering, error recovery, and progress reporting introduced in Part 2.

**Proposed Changes**:
1. **Add BEFORE_STARTING phase** at workflow initialization
   - Import: `ai_instruction_modules/ai-workflow-assignments/templates/BEFORE_STARTING_TEMPLATE.md`
   - Location: Before Step 1 (context gathering)
   - Purpose: Standardize initial context gathering and requirement clarification

2. **Add ERROR_RECOVERY protocol** throughout workflow
   - Import: `ai_instruction_modules/ai-workflow-assignments/templates/ERROR_RECOVERY_TEMPLATE.md`
   - Location: Reference in each major step
   - Purpose: Consistent error handling and recovery patterns

3. **Add PROGRESS_REPORTING checkpoints** at key milestones
   - Import: `ai_instruction_modules/ai-workflow-assignments/templates/PROGRESS_REPORTING_TEMPLATE.md`
   - Location: After each major step completion
   - Purpose: Clear progress tracking and stakeholder communication

**Implementation Approach**:
```markdown
# project-setup-upgraded.md

## Before Starting
**Template**: Follow [BEFORE_STARTING_TEMPLATE.md](../templates/BEFORE_STARTING_TEMPLATE.md)

### context-gathering
[existing context gathering steps...]

## Error Recovery
**Protocol**: Follow [ERROR_RECOVERY_TEMPLATE.md](../templates/ERROR_RECOVERY_TEMPLATE.md) for any errors

## Progress Reporting
**Checkpoints**: Report progress using [PROGRESS_REPORTING_TEMPLATE.md](../templates/PROGRESS_REPORTING_TEMPLATE.md) after each major step
```

**Rationale**:
- Improves workflow robustness and error handling
- Standardizes progress communication
- Reduces ambiguity in execution
- Aligns with Part 2 enhancements

**Impact Assessment**:
- **Effort**: Medium (4-6 hours)
- **Risk**: Low - Templates are additive, don't change core workflow
- **Benefits**: Increased execution reliability, better progress visibility
- **Testing Required**: Execute workflow in sandbox environment

**Dependencies**:
- Template files must exist in `ai_instruction_modules/ai-workflow-assignments/templates/`
- Orchestrator must understand template reference syntax

---

## 2. PR Creation Workflow Enhancement

### Workflow: All workflows creating PRs (e.g., `implement-story.md`)
**Reference**: `ai_instruction_modules/ai-workflow-assignments/dynamic-workflows/implement-story.md`

#### Change 2.1: After PR was created needed manual reviewer assignment (FB-008)

**Current State**: PRs created without automatic reviewer assignment, requiring manual intervention.

**Proposed Changes**:
1. **Add reviewer assignment to PR creation step**
   - Use `gh pr create --reviewer <username>` flag
   - Configure default reviewers in workflow configuration
   - Support team-based reviewer assignment if applicable

**Implementation Approach**:
```markdown
### create-pull-request
$pr_url = create PR with:
  - title: "$story_title"
  - body: "$pr_description"
  - base: development (or main)
  - reviewers: @nam20485 (or configured reviewer list)

Command example:
gh pr create \
  --title "$story_title" \
  --body "$pr_description" \
  --base development \
  --reviewer nam20485 \
  --label "enhancement"
```

**Configuration Approach**:
- Add reviewer configuration to `ai-workflow-config.md`
- Support per-workflow reviewer overrides
- Default to repository owner if not specified

**Rationale**:
- Reduces manual overhead
- Ensures timely code reviews
- Aligns with `implement-story` workflow pattern
- Improves workflow automation completeness

**Impact Assessment**:
- **Effort**: Small (2-3 hours)
- **Risk**: Very Low - Standard GitHub feature
- **Benefits**: Reduced manual steps, faster review cycles
- **Testing Required**: Test with sample PR in development environment

**Dependencies**:
- GitHub repository must have defined reviewers
- `gh` CLI authenticated with appropriate permissions

---

## 3. Issue Creation Workflow Enhancement

### Workflow: Next assignment execution (applies to multiple workflows)
**Context**: Recommendations for next assignment (FB-004, FB-005, FB-006)

#### Change 3.1: Project Linkage Integration (FB-004)

**Current State**: Issues created without explicit project linkage.

**Proposed Changes**:
1. **Add project assignment to issue creation**
   - Use `gh issue create --project <project-number>` flag
   - Configure project number in workflow configuration
   - Verify project linkage after creation

**Implementation Approach**:
```markdown
### create-issue
$issue_url = create issue with:
  - title: "$issue_title"
  - body: "$issue_description"
  - project: 37 (or configured project number)
  - milestone: "$milestone_name"
  - labels: "$label_list"

Command example:
gh issue create \
  --title "$issue_title" \
  --body "$issue_description" \
  --project 37 \
  --milestone "Phase 1" \
  --label "enhancement,workflow"
```

**Rationale**:
- Establishes explicit project-repository linkage
- Automates project board management
- Addresses Project-Repository Link Verification from FB-003

**Impact Assessment**:
- **Effort**: Small (1-2 hours)
- **Risk**: Very Low - Standard GitHub feature
- **Benefits**: Automated project tracking, clear verification path
- **Testing Required**: Verify issue appears in project board

---

#### Change 3.2: Milestone Assignment (FB-005)

**Current State**: Issues created without milestone assignment.

**Proposed Changes**:
1. **Add milestone assignment to issue creation**
   - Use phase-based naming: Phase 1, Phase 2, Phase 3, ..., Phase n
   - Create milestones if they don't exist
   - Document milestone strategy in workflow config

**Implementation Approach**:
```markdown
### assign-milestones
Before creating issues:
  - Check if milestone exists: gh api repos/:owner/:repo/milestones
  - Create if missing: gh api repos/:owner/:repo/milestones -f title="Phase 1"
  - Assign to issues during creation: --milestone "Phase 1"
```

**Milestone Strategy**:
- **Phase 1**: Project setup and foundation
- **Phase 2**: Core application features
- **Phase 3**: Advanced features and polish
- **Phase n**: Additional phases as needed

**Rationale**:
- Improves project organization
- Enables progress tracking by phase
- Aligns with sprint/release planning

**Impact Assessment**:
- **Effort**: Small (1-2 hours)
- **Risk**: Very Low - Standard GitHub feature
- **Benefits**: Better project organization, clear progress visibility
- **Testing Required**: Verify milestone creation and assignment

---

#### Change 3.3: Label Application (FB-006)

**Current State**: Labels available but not consistently applied during issue creation.

**Proposed Changes**:
1. **Add label assignment to issue creation**
   - Use imported labels (15 labels available)
   - Document label taxonomy
   - Apply appropriate labels based on issue type

**Available Labels** (from setup):
- `bug` - Something isn't working
- `documentation` - Documentation improvements
- `enhancement` - New feature or request
- `epic` - Large initiative spanning multiple stories
- `story` - User story or feature
- `task` - Development task
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed
- `question` - Further information requested
- `wontfix` - Will not be worked on
- `duplicate` - Already exists
- `invalid` - Doesn't seem right
- `workflow` - Workflow-related changes
- `infrastructure` - Infrastructure/DevOps changes
- `priority:high` - High priority items

**Implementation Approach**:
```markdown
### create-issue-with-labels
Determine appropriate labels based on issue type:
  - Story → ["story", "enhancement"]
  - Task → ["task"]
  - Bug → ["bug"]
  - Epic → ["epic"]
  - Documentation → ["documentation"]
  - Workflow → ["workflow"]

Apply during creation:
gh issue create \
  --title "$issue_title" \
  --body "$issue_description" \
  --label "enhancement,workflow,priority:high"
```

**Rationale**:
- Leverages existing label infrastructure
- Improves issue discoverability and filtering
- Enables better project analytics

**Impact Assessment**:
- **Effort**: Small (1 hour)
- **Risk**: Very Low - Standard GitHub feature
- **Benefits**: Better issue organization, easier filtering
- **Testing Required**: Verify labels applied correctly

---

## 4. Assignment Clarification

### Workflow: `create-app-plan.md` vs `create-application-foundation.md`
**Context**: C# project files created in wrong assignment (FB-009)

#### Change 4.1: Assignment Responsibility Analysis

**Current State**: Ambiguity in which assignment should create C# project files led to creation in `create-app-plan` instead of `create-application-foundation`.

**Investigation Required**:
1. **Analyze `create-app-plan.md` instructions**
   - Review intended scope and deliverables
   - Identify any ambiguous language regarding project file creation
   - Determine if instructions explicitly forbid project file creation

2. **Analyze `create-application-foundation.md` instructions**
   - Review intended scope and deliverables
   - Verify explicit instructions for project file creation
   - Confirm this is the correct assignment for C# project setup

3. **Determine Root Cause**:
   - Assignment instruction ambiguity?
   - Execution error or misinterpretation?
   - Missing explicit guidance?

**Proposed Changes** (Pending Investigation):

**Option A - If Instructions Are Ambiguous**:
```markdown
# create-app-plan.md

## Out of Scope
**IMPORTANT**: This assignment is for PLANNING only.
- Do NOT create C# project files (.csproj, .sln)
- Do NOT create application code or structure
- Do NOT run dotnet new commands

Project file creation is handled in the `create-application-foundation` assignment.
```

```markdown
# create-application-foundation.md

## Responsibilities
**IMPORTANT**: This assignment creates the physical project structure.
- CREATE C# project files (.csproj, .sln)
- CREATE application folder structure
- RUN dotnet new commands
- SET UP initial project configuration

This follows the planning completed in `create-app-plan`.
```

**Option B - If Instructions Are Clear** (Execution Error):
- Document as anomaly
- Add verification checkpoint in orchestrator
- Increase monitoring for future executions
- No workflow changes required

**Rationale**:
- Prevent recurrence of misplaced artifacts
- Clarify assignment boundaries
- Improve workflow reliability

**Impact Assessment**:
- **Effort**: Small (2-4 hours analysis + 1-2 hours changes)
- **Risk**: Very Low - Clarification only
- **Benefits**: Clearer assignment boundaries, reduced confusion
- **Testing Required**: Execute both assignments in sequence to verify correct behavior

**Dependencies**:
- Root cause analysis must be completed first
- May require updates to multiple assignment files

---

## 5. Documentation Maintenance Process

### Workflow: All workflows
**Context**: Ongoing documentation maintenance (FB-001)

#### Change 5.1: Documentation Update Integration

**Current State**: Documentation updates are ad-hoc and may lag behind implementation.

**Proposed Changes**:
1. **Add documentation checkpoint to Definition of Done**
   - Include in all workflow assignments
   - Require README updates when functionality changes
   - Review planning docs at milestone completion

2. **Add Documentation Section to Workflows**
   ```markdown
   ## Documentation Updates (Required)
   Before marking complete:
   - [ ] Update README.md if functionality changed
   - [ ] Update planning documents if approach changed
   - [ ] Update workflow documentation if process changed
   - [ ] Update API documentation if interfaces changed
   ```

3. **Establish Documentation Review Cadence**
   - Review at end of each sprint/milestone
   - Update stale documentation
   - Archive deprecated documentation

**Rationale**:
- Keeps documentation in sync with implementation
- Reduces technical debt
- Improves onboarding and maintainability

**Impact Assessment**:
- **Effort**: Small (ongoing 2 hours/sprint)
- **Risk**: Very Low - Process improvement
- **Benefits**: Better documentation coverage, reduced knowledge gaps
- **Testing Required**: Monitor documentation freshness metrics

---

## 6. Build Configuration

### Workflow: Build and validation steps
**Context**: Build warning for missing workload (FB-007)

#### Change 6.1: Workload Restoration

**Current State**: Build emits warning for missing workload.

**Proposed Changes**:
1. **Add workload restoration step**
   ```markdown
   ### setup-development-environment
   Before build:
   - Run: dotnet workload restore
   - Verify: dotnet workload list
   - Document required workloads in README.md
   ```

2. **Update CI/CD Pipeline**
   - Add `dotnet workload restore` to build pipeline
   - Cache restored workloads for performance
   - Document required workloads in pipeline configuration

3. **Document Required Workloads**
   - Update `docs/DEVELOPMENT_ENVIRONMENT.md`
   - List all required workloads
   - Provide installation instructions

**Rationale**:
- Clean build output
- Prevent future workload issues
- Improve developer onboarding

**Impact Assessment**:
- **Effort**: Small (1-2 hours)
- **Risk**: Very Low - Standard .NET tooling
- **Benefits**: Clean builds, better documentation
- **Testing Required**: Verify build completes without warnings

---

## 7. Architecture Decision Records

### Workflow: New process to be established
**Context**: Track technical debt and architectural decisions (FB-002)

#### Change 7.1: ADR Process Introduction

**Current State**: No formal process for documenting architectural decisions.

**Proposed Changes**:
1. **Create ADR Structure**
   ```
   docs/adr/
   ├── 0000-adr-template.md
   ├── 0001-use-adr-for-architecture-decisions.md
   ├── 0002-[first-actual-decision].md
   └── README.md
   ```

2. **Create ADR Template** (Based on Michael Nygard format)
   ```markdown
   # [ADR-NNNN] Title

   **Status**: Proposed | Accepted | Deprecated | Superseded by [ADR-XXXX]
   **Date**: YYYY-MM-DD
   **Deciders**: [list of people involved]

   ## Context
   [Describe the situation and problem]

   ## Decision
   [Describe the decision and rationale]

   ## Consequences
   **Positive**:
   - [benefit 1]
   - [benefit 2]

   **Negative**:
   - [tradeoff 1]
   - [tradeoff 2]

   **Technical Debt**:
   - [any debt incurred]

   ## Alternatives Considered
   - [alternative 1]: [why not chosen]
   - [alternative 2]: [why not chosen]
   ```

3. **Integrate into Workflow**
   ```markdown
   ### architectural-decisions
   When making significant architectural choices:
   1. Create new ADR using template
   2. Document decision, context, and consequences
   3. Review with team
   4. Commit ADR with implementation
   5. Update ADR status when decision is implemented/changed
   ```

**Rationale**:
- Provides historical record of decisions
- Documents technical debt explicitly
- Aids future decision-making
- Improves knowledge transfer

**Impact Assessment**:
- **Effort**: Medium (4-8 hours initial setup, 1-2 hours per ADR)
- **Risk**: Low - Process addition, no code changes
- **Benefits**: Better decision documentation, technical debt visibility
- **Testing Required**: Create sample ADRs, gather team feedback

---

## Implementation Priority

### High Priority (Sprint 1)
1. **PR Reviewer Assignment** (Change 2.1) - Immediate value, small effort
2. **Project/Milestone/Label Integration** (Changes 3.1, 3.2, 3.3) - Part of next assignment
3. **Build Workload Fix** (Change 6.1) - Quick win, clean builds

### Medium Priority (Sprint 2)
4. **Assignment Clarification** (Change 4.1) - Requires investigation
5. **Documentation Process** (Change 5.1) - Ongoing improvement

### Lower Priority (Sprint 3)
6. **Part 2 Template Integration** (Change 1.1) - Significant enhancement
7. **ADR Process** (Change 7.1) - Long-term governance

---

## Testing Strategy

### Per-Change Testing
Each workflow change should be tested in a sandbox environment:
1. Create test repository or branch
2. Execute modified workflow
3. Verify expected behavior
4. Check for unintended side effects
5. Validate against acceptance criteria

### Integration Testing
After all changes implemented:
1. Execute full `project-setup-upgraded` workflow end-to-end
2. Monitor for new issues or regressions
3. Gather feedback from workflow executors
4. Iterate based on findings

### Validation Criteria
- All workflows execute without errors
- All intended features function as documented
- No new issues introduced
- Success metrics show improvement

---

## Rollback Plan

### If Issues Arise
1. **Identify problematic change** through testing or execution feedback
2. **Revert to previous workflow version** using git
3. **Document issue and root cause**
4. **Revise change approach** based on learnings
5. **Re-test before re-deployment**

### Version Control
- Tag workflow versions: `workflow-v1.0`, `workflow-v1.1`, etc.
- Maintain changelog in workflow documentation
- Enable easy rollback to known-good versions

---

## Change Log

| Date | Change | Impact | Status |
|------|--------|--------|--------|
| 2025-10-21 | Document created | N/A | PROPOSED |
| 2025-10-22 | Status updated to reflect implementation progress (9/11 items complete) | High | PARTIALLY IMPLEMENTED |

---

**Document Version**: 1.1  
**Last Updated**: 2025-10-22  
**Next Review**: After implementation of remaining changes (FB-001, FB-002)
