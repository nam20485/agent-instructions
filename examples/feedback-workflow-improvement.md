### Example: Handling a Workflow Improvement

**Feedback from PROJECT_SETUP_DEBRIEF.md:**
> "Assignment Granularity - Issue: Some assignments were quite large and complex (e.g., create-project-structure). Suggestion: Consider breaking down large assignments into smaller, more focused tasks. Benefit: Smaller assignments are easier to test, debug, and reuse."

**Step 1: Extract and Categorize**
- **FB-023**: Assignment too large and complex
- **Category**: Process & Workflow Improvements
- **Priority**: P2 (Medium - improves future workflows)
- **Effort**: Medium (requires restructuring workflow file)

**Step 2: Create Workflow Change Documentation**
```markdown
### Change: Split create-project-structure Assignment

**File**: `nam20485/agent-instructions/ai_instruction_modules/ai-workflow-assignments/create-project-structure.md`
**Change Type**: Split Assignment into Multiple Assignments

**Current Issue:**
The create-project-structure assignment is too large and complex, covering:
- Package.json and dependencies
- TypeScript configuration
- Build tool setup (Vite)
- React components
- Three.js integration
- Docker configuration
- CI/CD workflows
- Setup scripts

This makes the assignment difficult to test, debug, and complete in one session.

**Proposed Change:**
Split into 4 separate, focused assignments:

1. **create-project-foundation.md**
   - package.json and dependencies
   - TypeScript configuration
   - Build tool setup (Vite)
   - Basic file structure

2. **create-application-components.md**
   - React components
   - Component structure
   - Basic styling setup

3. **create-rendering-layer.md**
   - Three.js integration
   - React Three Fiber setup
   - Shape components

4. **create-infrastructure.md**
   - Docker configuration
   - CI/CD workflows
   - Setup scripts

**Rationale:**
- Each assignment is 30-60 minutes vs. 2-3 hours
- Easier to validate each step
- More reusable across projects
- Better failure isolation
- Clearer acceptance criteria per assignment

Reference: FB-023 from PROJECT_SETUP_DEBRIEF.md

**Impact:**
- Reduced cognitive load per assignment
- Better progress tracking
- Easier debugging if something fails
- More granular testing
- Estimated 25% time savings through better focus

**Implementation:**
1. Create 4 new assignment files
2. Extract relevant sections from original
3. Update dependencies between assignments
4. Update orchestrate-new-project workflow to use new assignments
5. Test with sample project
6. Archive old create-project-structure.md

**Testing:**
Run orchestrate-new-project workflow with new assignments and verify:
- All 4 assignments complete successfully
- Output matches original workflow
- Time per assignment is <60 minutes
- Failure in one assignment doesn't cascade
```

**Step 3: Save to Workflow Changes Document**
Save in current repo as `docs/FEEDBACK_WORKFLOW_CHANGES.md`

**Step 4: Create Issue in agent-instructions Repo**
```bash
gh issue create \
  --repo nam20485/agent-instructions \
  --title "[Workflow]: Split create-project-structure into 4 focused assignments" \
  --label "workflow-improvement,process-improvement" \
  --body "## Proposal
Split the create-project-structure assignment into 4 smaller, focused assignments.

## Background
Feedback FB-023 from PROJECT_SETUP_DEBRIEF.md identified that this assignment is too large and complex.

## Detailed Changes
See: [link to FEEDBACK_WORKFLOW_CHANGES.md]

## Benefits
- Easier to test and debug
- Better progress tracking
- More reusable
- Reduced cognitive load

## Files to Create
1. create-project-foundation.md
2. create-application-components.md
3. create-rendering-layer.md
4. create-infrastructure.md

## Files to Update
- orchestrate-new-project.md (update to use new assignments)

## Files to Archive
- create-project-structure.md"
```

**Step 5: Add to Feedback Response Summary**
```markdown
### Workflow Improvement Documented

**FB-023: Split Large Assignment**
- Documented detailed workflow change
- Created issue in agent-instructions repo: nam20485/agent-instructions#XX
- Change document: docs/FEEDBACK_WORKFLOW_CHANGES.md
- Will improve future project setups by 25% time savings
```
