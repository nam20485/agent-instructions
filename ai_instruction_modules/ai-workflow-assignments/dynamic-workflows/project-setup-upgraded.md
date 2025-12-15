# Dynamic Workflow: Project Setup (Upgraded)

Modern project setup across all tech stacks with validation.

## Script

### initiate-new-repository

`$assignments` = [  
   `init-existing-repository`,
   `create-app-plan`,
   `create-application-foundation`,
   `create-application-structure`,
   `create-testing-infrastructure`,
   `create-deployment-infrastructure`,
   `pr-approval-and-merge`,
   `debrief-and-document`
]

For each `$assignment_name` in `$assignments`, you will:
   - assign the agent the `$assignment_name` assignment
   - wait until agent finishes
   - review and approve
   - record as `#initiate-new-repository.$assignment_name`

### Events

#### `pre-assignment-begin`
- assign agent `gather-context`
- record as `#events.pre-assignment-begin`

#### `on-assignment-failure`
- assign agent `recover-from-error`
- record as `#events.on-assignment-failure`

#### `post-assignment-complete`
- assign agent `validate-assignment-completion`
- if validation failed: halt workflow
- assign agent `create-repository-summary`
- assign agent `report-progress`
- record as `#events.post-assignment-complete`

## Assignment Summary

| Assignment | Purpose |
|------------|---------|
| `init-existing-repository` | Git setup, structure |
| `create-app-plan` | Architecture, scope |
| `create-application-foundation` | Dependencies, build, linting |
| `create-application-structure` | Entry point, architecture |
| `create-testing-infrastructure` | Test framework, smoke tests |
| `create-deployment-infrastructure` | Docker, CI/CD, IaC |
| `debrief-and-document` | Final report, lessons learned |

**Total time:** ~90-120 min
