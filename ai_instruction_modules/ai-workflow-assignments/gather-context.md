# Assignment: Gather Context Before Workflow Assignment Execution

## (gather-context)

### Goal

Prepare for workflow assignment execution by completing comprehensive preparation steps including reading the assignment, gathering context, verifying prerequisites, creating task lists, estimating time, and preparing the environment.

### Prerequisites

- Workflow orchestrator is about to execute a dynamic workflow assignment
- Access to previous assignment outputs and project documentation
- Required tools and dependencies are installed in the environment
- Network connectivity is available for checking related issues or PRs

### Acceptance Criteria

1. Assignment has been read completely with understanding of goals, steps, and dependencies
2. Context has been gathered from previous assignments, related issues, and project documentation
3. All prerequisites have been verified including tools, dependencies, and environment setup
4. Task list has been created with breakdown of steps, potential challenges, and uncertainties
5. Time has been estimated with appropriate buffer for unexpected issues
6. Environment has been prepared with workspace setup, resources gathered, and backups created

### Assignment

This assignment implements the pre-assignment-begin event handler functionality as a standardized workflow assignment. When executed, it handles all preparation steps that should occur before any workflow assignment execution begins.

The assignment ensures that:
- All necessary preparation steps are completed before assignment execution
- Context is properly gathered from previous work and project documentation
- Prerequisites are verified to prevent execution failures
- Task lists are created to guide execution and identify potential challenges
- Time is properly estimated with buffers for unexpected issues
- The environment is prepared for optimal execution

### Detailed Steps

#### 1. Read Assignment Completely

1. Read through all detailed steps of the upcoming assignment
   - Identify the main sections and their purposes
   - Understand the expected outcomes
   - Note any complex or unfamiliar concepts

2. Understand the overall goal of the assignment
   - Clarify what success looks like
   - Identify the primary deliverables
   - Understand how this assignment fits into the larger workflow

3. Review acceptance criteria for the upcoming assignment
   - List each criterion that must be met
   - Understand how each will be verified
   - Note any criteria that may require special attention

4. Note any dependencies on other assignments
   - Identify which previous assignments must be complete
   - Check if any outputs from other assignments are required
   - Verify that dependent work is available and accessible

5. Identify potential challenges in the upcoming assignment
   - Flag technical areas that may be complex
   - Note any unfamiliar tools or technologies
   - Identify integration points that may be tricky

#### 2. Gather Context

1. Review previous assignment outputs
   - Check what files were created in the last assignment
   - Understand current project state based on previous work
   - Verify previous work is complete and accessible

2. Check for related issues or PRs
   - Search for similar work that has been done before
   - Review any existing discussions that might be relevant
   - Check for known issues that might affect this assignment

3. Review project documentation
   - Read README and setup guides for any recent updates
   - Check architecture documentation for relevant patterns
   - Review coding standards to ensure compliance

4. Understand current state
   - Document what's already been done in the project
   - Identify what's left to do in the overall workflow
   - Note any blockers or dependencies that might affect execution

#### 3. Verify Prerequisites

1. Check that required tools are installed
   - Verify runtime environment (Node.js, Python, etc.) is correct version
   - Confirm build tools are available and functional
   - Check that package managers are installed and configured
   - Ensure development tools are accessible

2. Verify previous assignments completed
   - Check that acceptance criteria were met in previous assignments
   - Verify that outputs are available and accessible
   - Confirm no blockers exist from previous work

3. Ensure dependencies are met
   - Verify external services are available and accessible
   - Confirm required credentials are accessible
   - Check that network connectivity is working properly

4. Confirm environment is ready
   - Verify correct versions of tools are installed
   - Confirm environment variables are set correctly
   - Ensure permissions are configured properly

#### 4. Create Task List

1. Break down steps into specific tasks
   - List all major tasks required for the assignment
   - Identify subtasks for complex steps
   - Estimate time for each task based on complexity

2. Identify potential challenges
   - Flag technical challenges that may arise
   - Note integration points that require careful attention
   - Identify unknown areas that may require research

3. Note any questions or uncertainties
   - Document what needs clarification from stakeholders
   - Note what might need additional research
   - Identify what could go wrong during execution

4. Plan the approach
   - Determine order of operations for tasks
   - Identify opportunities for parallel work
   - Plan checkpoints for validation of progress

#### 5. Estimate Time

1. Review estimated time for assignment
   - Understand the baseline estimate provided
   - Consider assignment complexity relative to experience
   - Factor in any unique aspects of this specific assignment

2. Consider your specific context
   - Assess your familiarity with the tech stack
   - Consider the complexity of the project
   - Account for any unique challenges in this assignment

3. Add buffer for unexpected issues
   - Add 20-30% buffer for typical assignments
   - Add more buffer for unfamiliar territory
   - Add less buffer for well-known tasks

4. Plan accordingly
   - Schedule uninterrupted time for focused work
   - Plan for breaks to maintain productivity
   - Set realistic expectations with stakeholders

#### 6. Prepare Environment

1. Set up workspace
   - Close unnecessary applications to minimize distractions
   - Open required tools and applications
   - Prepare terminal/IDE with necessary configurations

2. Gather required resources
   - Collect documentation links that may be needed
   - Gather reference materials for complex topics
   - Prepare example code or templates if needed

3. Create backup if needed
   - Commit current state to version control
   - Tag important points for easy reference
   - Document starting point for rollback if needed