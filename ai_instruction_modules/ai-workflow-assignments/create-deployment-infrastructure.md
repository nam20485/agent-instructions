# Assignment: Create Deployment Infrastructure

## (create-deployment-infrastructure)

### Goal

Set up containerization, CI/CD, and deployment infrastructure to automate building, testing, and deploying the application.

### Prerequisites

* Application Foundation completed
* Application Structure completed
* Testing Infrastructure completed (tests should be passing)
* Understanding of deployment target (cloud, on-prem, serverless, etc.)

### Applicability

Works with various deployment approaches:
- **Containerization**: Docker, Podman
- **CI/CD Platforms**: GitHub Actions, GitLab CI, Jenkins, CircleCI, Travis CI, Azure DevOps, AWS CodePipeline, Google Cloud Build
- **Deployment Targets**: Cloud platforms, on-premises, serverless, edge

### Acceptance Criteria

1. Container builds successfully (if applicable)
2. docker-compose works for local development (if applicable)
3. CI/CD workflows created and passing
4. Deployment scripts functional
5. Setup scripts work on clean environment
6. DEPLOYMENT.md created with comprehensive documentation
7. All automation is tested and working

### Assignment

You will set up the deployment infrastructure including containerization (if applicable), CI/CD pipelines, and deployment automation. This ensures consistent, automated, and reliable deployments.

**Always follow instructions exactly as listed here.**

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

## Before Starting

Before beginning this assignment, complete these preparation steps:

### 1. Read Assignment Completely

- Read through all detailed steps
- Understand the overall goal
- Review acceptance criteria
- Note any dependencies on other assignments
- Identify potential challenges

### 2. Gather Context

- Review previous assignment outputs
  - Check what files were created
  - Understand current project state
  - Verify previous work is complete
- Check for related issues or PRs
  - Search for similar work
  - Review any existing discussions
  - Check for known issues
- Review project documentation
  - Read README and setup guides
  - Check architecture documentation
  - Review coding standards
- Understand current state
  - What's already been done
  - What's left to do
  - Any blockers or dependencies

### 3. Verify Prerequisites

- Check that required tools are installed
  - Runtime environment (Node.js, Python, etc.)
  - Build tools
  - Package managers
  - Development tools
- Verify previous assignments completed
  - Check acceptance criteria were met
  - Verify outputs are available
  - Confirm no blockers exist
- Ensure dependencies are met
  - External services available
  - Required credentials accessible
  - Network connectivity working
- Confirm environment is ready
  - Correct versions installed
  - Environment variables set
  - Permissions configured

### 4. Create Task List

- Break down steps into specific tasks
  - List all major tasks
  - Identify subtasks
  - Estimate time for each
- Identify potential challenges
  - Technical challenges
  - Integration points
  - Unknown areas
- Note any questions or uncertainties
  - What needs clarification
  - What might need research
  - What could go wrong
- Plan the approach
  - Order of operations
  - Parallel vs sequential work
  - Checkpoints for validation

### 5. Estimate Time

- Review estimated time for assignment
  - Understand the baseline estimate
  - Consider assignment complexity
- Consider your specific context
  - Your familiarity with tech stack
  - Complexity of the project
  - Any unique challenges
- Add buffer for unexpected issues
  - 20-30% buffer recommended
  - More for unfamiliar territory
  - Less for well-known tasks
- Plan accordingly
  - Schedule uninterrupted time
  - Plan for breaks
  - Set realistic expectations

### 6. Prepare Environment

- Set up workspace
  - Close unnecessary applications
  - Open required tools
  - Prepare terminal/IDE
- Gather required resources
  - Documentation links
  - Reference materials
  - Example code
- Create backup if needed
  - Commit current state
  - Tag important points
  - Document starting point

**Only proceed once all preparation steps are complete.**

### Detailed Steps

#### 1. Create Containerization (if applicable)

**Note**: Not all applications need containers. Skip this section if containerization is not part of the deployment strategy.

1. Create Dockerfile with multi-stage build:
   ```dockerfile
   # Example multi-stage Dockerfile
   # Stage 1: Build
   FROM node:18-alpine AS builder
   WORKDIR /app
   COPY package*.json ./
   RUN npm ci
   COPY . .
   RUN npm run build
   
   # Stage 2: Production
   FROM node:18-alpine
   WORKDIR /app
   COPY --from=builder /app/dist ./dist
   COPY --from=builder /app/package*.json ./
   RUN npm ci --omit=dev
   EXPOSE 3000
   CMD ["node", "dist/main.js"]
   ```

2. Create .dockerignore:
   - Exclude node_modules, build artifacts
   - Exclude .git, .env files
   - Exclude test files and documentation
   - Keep file minimal and focused

3. Create docker-compose.yml for local development:
   - Define application service
   - Define database service (if needed)
   - Define cache service (if needed)
   - Set up networking
   - Configure volumes for development
   - Set environment variables

4. Create container health check:
   - Add HEALTHCHECK to Dockerfile
   - Check application is responding
   - Check dependencies are available
   - Return appropriate exit codes

5. Document container usage:
   - How to build the image
   - How to run the container
   - How to use docker-compose
   - Environment variables needed
   - Port mappings
   - Volume mounts

6. Test containerization:
   - Build Docker image
   - Run container locally
   - Test with docker-compose
   - Verify health checks work
   - Test in clean environment

#### 2. Create CI/CD Workflows

Choose the appropriate CI/CD platform and create workflows:

**GitHub Actions** (.github/workflows/ci.yml):
```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run linter
        run: npm run lint
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
      
      - name: Upload coverage
        uses: codecov/codecov-action@v4
        if: success()
```

**GitLab CI** (.gitlab-ci.yml):
```yaml
stages:
  - test
  - build
  - deploy

test:
  stage: test
  image: node:18
  script:
    - npm ci
    - npm run lint
    - npm test
  coverage: '/Coverage: \d+\.\d+%/'

build:
  stage: build
  image: node:18
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
```

**Jenkins** (Jenkinsfile):
```groovy
pipeline {
    agent any
    
    stages {
        stage('Install') {
            steps {
                sh 'npm ci'
            }
        }
        
        stage('Lint') {
            steps {
                sh 'npm run lint'
            }
        }
        
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
}
```

1. Create CI configuration file for your platform
2. Configure trigger events (push, pull request, tags, etc.)
3. Set up build environment (OS, runtime versions)
4. Configure caching for dependencies
5. Set up matrix builds (if needed for multiple versions/platforms)

#### 3. Configure Automated Testing in CI

1. Add test execution step:
   - Run all tests
   - Run in CI environment
   - Use appropriate test reporter

2. Configure test result reporting:
   - JUnit XML format
   - Upload test results
   - Display in CI UI

3. Set up coverage reporting:
   - Generate coverage report
   - Upload to coverage service (Codecov, Coveralls, etc.)
   - Set coverage thresholds
   - Fail build if coverage drops

4. Configure test failure handling:
   - Fail build on test failure
   - Retry flaky tests (if needed)
   - Report test failures clearly

#### 4. Configure Code Quality Checks

1. Add linting step:
   - Run linter
   - Fail on errors
   - Report warnings

2. Add code formatting check:
   - Check code is formatted
   - Fail if not formatted
   - Provide fix command

3. Add type checking (if applicable):
   - Run type checker
   - Fail on type errors
   - Report type issues

4. Add security scanning (optional):
   - Dependency vulnerability scanning
   - Code security scanning
   - License compliance checking

#### 5. Configure Build Verification

1. Add build step:
   - Run build command
   - Verify build succeeds
   - Check for build warnings

2. Verify build artifacts are created:
   - Check output directory exists
   - Verify expected files are present
   - Check file sizes are reasonable

3. Configure build artifact upload (if needed):
   - Upload to artifact storage
   - Tag with version/commit
   - Set retention policy

4. Add build status reporting:
   - Update commit status
   - Post to PR comments
   - Send notifications

#### 6. Configure Deployment (if applicable)

1. Add deployment step for target environment:
   - Deploy to staging on merge to develop
   - Deploy to production on release tag
   - Manual approval for production (if needed)

2. Configure deployment conditions:
   - Branch restrictions
   - Tag patterns
   - Manual triggers
   - Approval gates

3. Set up deployment secrets/credentials:
   - Use platform secret management
   - Never commit secrets
   - Rotate secrets regularly
   - Limit secret access

4. Configure rollback mechanism:
   - Keep previous version
   - Automated rollback on failure
   - Manual rollback procedure
   - Health check after deployment

#### 7. Create Deployment Scripts

1. Create deployment script for target environment:
   - **deploy.sh** or **deploy.ps1**
   - Handle different environments (dev, staging, prod)
   - Validate prerequisites
   - Perform deployment steps
   - Verify deployment success

2. Create rollback script:
   - **rollback.sh** or **rollback.ps1**
   - Revert to previous version
   - Verify rollback success
   - Notify team

3. Create database migration script (if applicable):
   - **migrate.sh** or **migrate.ps1**
   - Run migrations
   - Rollback on failure
   - Backup before migration

4. Create environment setup script:
   - **setup.sh** or **setup.ps1**
   - Install dependencies
   - Configure environment
   - Verify setup

#### 8. Create Infrastructure as Code (if applicable)

If using cloud infrastructure, create IaC templates:

1. Create IaC templates:
   - **Terraform**: *.tf files
   - **CloudFormation**: *.yaml or *.json
   - **Pulumi**: Infrastructure code
   - **ARM Templates**: *.json

2. Define infrastructure resources:
   - Compute resources
   - Storage resources
   - Networking resources
   - Security resources

3. Configure networking and security:
   - VPC/VNet configuration
   - Security groups/NSGs
   - IAM roles and policies
   - Encryption settings

4. Document infrastructure setup:
   - Prerequisites
   - How to deploy infrastructure
   - How to update infrastructure
   - How to destroy infrastructure

#### 9. Create Setup and Installation Scripts

1. Create setup script for development environment:
   - **setup.sh** for Linux/Mac
   - **setup.ps1** for Windows
   - Install dependencies
   - Configure environment
   - Verify installation

2. Create installation verification script:
   - Check all tools are installed
   - Verify versions are correct
   - Test basic functionality
   - Report any issues

3. Create dependency installation script:
   - Install system dependencies
   - Install language runtime
   - Install development tools
   - Install optional tools

4. Document setup process:
   - Prerequisites
   - Step-by-step instructions
   - Troubleshooting common issues
   - Platform-specific notes

#### 10. Create Deployment Documentation

1. Create DEPLOYMENT.md with:
   - Overview of deployment process
   - Prerequisites
   - Deployment steps
   - Rollback procedure
   - Environment requirements
   - Troubleshooting

2. Document deployment process:
   - How to deploy to each environment
   - Required permissions
   - Deployment checklist
   - Post-deployment verification

3. Document rollback procedure:
   - When to rollback
   - How to rollback
   - Verification steps
   - Communication plan

4. Document environment requirements:
   - Infrastructure requirements
   - Environment variables
   - Secrets and credentials
   - External dependencies

5. Document troubleshooting steps:
   - Common deployment issues
   - How to debug failures
   - Where to find logs
   - Who to contact for help

#### 11. Create Status Badges

1. Add CI status badge to README:
   - Build status
   - Test status
   - Link to CI runs

2. Add coverage badge (if applicable):
   - Coverage percentage
   - Link to coverage report

3. Add other relevant badges:
   - Version badge
   - License badge
   - Dependencies status

## Progress Reporting

This assignment has multiple steps and may take 90-120 minutes. Report progress at these checkpoints:

### Checkpoint 1: Containerization (25% complete)

**Tasks**:
- [ ] Dockerfile created with multi-stage build (if applicable)
- [ ] .dockerignore created
- [ ] docker-compose.yml created for local development
- [ ] Container health check configured
- [ ] Container usage documented
- [ ] Containerization tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 1 Complete (25%)
- Completed: Dockerfile with multi-stage build, docker-compose.yml, health checks
- Issues: Had to adjust base image for smaller size
- Time remaining: ~85 minutes
- Next: Create CI/CD workflows
```

**Note**: If containerization is not applicable, skip to Checkpoint 2.

---

### Checkpoint 2: CI/CD Workflows (50% complete)

**Tasks**:
- [ ] CI configuration file created
- [ ] Trigger events configured
- [ ] Build environment configured
- [ ] Automated testing configured
- [ ] Code quality checks configured
- [ ] Build verification configured
- [ ] CI/CD pipeline tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 2 Complete (50%)
- Completed: GitHub Actions workflow with tests, linting, and build
- Issues: Had to configure caching for faster builds
- Time remaining: ~55 minutes
- Next: Create deployment scripts
```

---

### Checkpoint 3: Deployment Scripts and IaC (75% complete)

**Tasks**:
- [ ] Deployment script created
- [ ] Rollback script created
- [ ] Database migration script created (if applicable)
- [ ] Environment setup script created
- [ ] IaC templates created (if applicable)
- [ ] Scripts tested

**Report**: After completing these tasks, provide a brief status update including:
- What was completed
- Any issues encountered
- Estimated time remaining
- Next steps

**Example Report**:
```
✅ Checkpoint 3 Complete (75%)
- Completed: Deployment and rollback scripts, Terraform templates
- Issues: None
- Time remaining: ~25 minutes
- Next: Create documentation and status badges
```

---

### Final Checkpoint: Complete (100%)

**Tasks**:
- [ ] Setup and installation scripts created
- [ ] DEPLOYMENT.md documentation created
- [ ] Status badges added to README
- [ ] All validation passed
- [ ] Acceptance criteria verified

**Report**: Provide final summary including:
- All completed work
- Total time taken
- Any issues resolved
- Final status

**Example Report**:
```
✅ Assignment Complete (100%)
- Completed: Full deployment infrastructure with Docker, GitHub Actions, deployment scripts, and comprehensive documentation
- Total time: 105 minutes
- Issues resolved: Docker image size optimization, CI caching configuration
- Status: Ready for review
```

---

### How to Report Progress

After completing each checkpoint, provide a brief update including:

1. **What was completed**:
   - List specific tasks finished
   - Highlight major milestones
   - Note any deliverables created

2. **Any issues encountered**:
   - Describe problems faced
   - Explain how they were resolved
   - Note any ongoing concerns

3. **Estimated time remaining**:
   - Calculate based on progress
   - Adjust for complexity
   - Account for any delays

4. **Next steps**:
   - What comes next
   - Any dependencies
   - Expected timeline

### Progress Tracking Tips

- **Be honest about progress**: Don't overestimate completion
- **Report blockers immediately**: Don't wait until the end
- **Update estimates**: Adjust time estimates as you learn more
- **Document issues**: Keep notes on problems and solutions
- **Celebrate milestones**: Acknowledge progress at each checkpoint

## Error Recovery

If an error occurs during this assignment, follow these steps:

### Common Errors

#### Error: Container Build Fails
- **Symptoms**: Docker build errors, image creation failures
- **Possible Causes**:
  - Dockerfile syntax errors
  - Missing files referenced in Dockerfile
  - Base image issues
  - Network issues during build
- **Solutions**:
  1. Check Dockerfile syntax
  2. Verify all COPY/ADD paths are correct
  3. Try pulling base image manually
  4. Check Docker daemon is running
  5. Review build context (.dockerignore)
  6. Try building with --no-cache flag

#### Error: CI/CD Pipeline Fails
- **Symptoms**: CI workflow failures, deployment errors
- **Possible Causes**:
  - Configuration syntax errors
  - Missing secrets/credentials
  - Environment differences
  - Timeout issues
- **Solutions**:
  1. Check CI configuration file syntax
  2. Verify all required secrets are configured
  3. Review CI logs for specific errors
  4. Test commands locally before running in CI
  5. Check for environment-specific issues
  6. Verify timeout settings are appropriate

#### Error: Tests Fail in CI but Pass Locally
- **Symptoms**: Tests pass on local machine but fail in CI
- **Possible Causes**:
  - Environment differences
  - Missing dependencies in CI
  - Timing issues
  - File path differences
- **Solutions**:
  1. Compare local and CI environments
  2. Verify all dependencies are installed in CI
  3. Check for hardcoded paths
  4. Increase timeouts in CI
  5. Run tests in Docker locally to match CI environment

#### Error: Deployment Script Fails
- **Symptoms**: Deployment script errors, deployment failures
- **Possible Causes**:
  - Missing permissions
  - Invalid credentials
  - Network connectivity issues
  - Script syntax errors
- **Solutions**:
  1. Verify deployment permissions
  2. Check credentials are valid and accessible
  3. Test network connectivity to deployment target
  4. Validate script syntax
  5. Test script in staging environment first

#### Error: Docker Compose Fails
- **Symptoms**: docker-compose up errors, service failures
- **Possible Causes**:
  - Invalid docker-compose.yml syntax
  - Port conflicts
  - Volume mount issues
  - Network configuration errors
- **Solutions**:
  1. Validate docker-compose.yml syntax
  2. Check for port conflicts with other services
  3. Verify volume paths exist and have correct permissions
  4. Review network configuration
  5. Check service dependencies are correct

#### Error: Secrets/Credentials Not Available
- **Symptoms**: Authentication failures, missing environment variables
- **Possible Causes**:
  - Secrets not configured in CI/CD platform
  - Incorrect secret names
  - Insufficient permissions to access secrets
  - Secrets not passed to deployment environment
- **Solutions**:
  1. Verify secrets are configured in CI/CD platform
  2. Check secret names match exactly
  3. Verify permissions to access secrets
  4. Ensure secrets are passed to deployment steps
  5. Test with dummy values first to verify flow

### Escalation Procedure

If errors persist after troubleshooting:

1. **Document the Error**:
   - Full error message and stack trace
   - Steps that led to the error
   - Environment details (OS, runtime version, etc.)
   - What solutions were attempted
   - Any relevant configuration files

2. **Create an Issue**:
   - Create GitHub issue with error details
   - Tag with "bug" and "needs-investigation"
   - Link to this assignment
   - Include reproduction steps

3. **Notify User**:
   - Report the error to the user
   - Provide error details and context
   - Request manual intervention
   - Suggest potential next steps

4. **Do Not Proceed**:
   - Do not mark assignment as complete
   - Do not proceed to next assignment
   - Wait for error resolution
   - Document the blocker

### Rollback Procedure

If changes need to be reverted:

1. **Assess Impact**:
   - Determine what changes were made
   - Identify what needs to be rolled back
   - Check for dependencies on the changes

2. **Perform Rollback**:
   - Use git to revert changes: `git checkout -- .` or `git reset --hard`
   - Delete generated files/directories
   - Restore from backup if available
   - Clean build artifacts
   - Remove deployed containers/services

3. **Verify Rollback**:
   - Confirm system is in previous state
   - Test that previous functionality still works
   - Verify no orphaned files remain
   - Check no containers/services are still running

4. **Document Rollback**:
   - Document what was rolled back and why
   - Record lessons learned
   - Update issue/ticket with rollback details
   - Plan next steps

### Prevention Tips

To avoid common errors:

1. **Before Starting**:
   - Read assignment completely
   - Verify prerequisites are met
   - Check environment is properly configured
   - Ensure you have necessary permissions

2. **During Execution**:
   - Follow steps exactly as specified
   - Verify each step before proceeding
   - Test incrementally (don't wait until the end)
   - Keep notes of what you've done

3. **After Completion**:
   - Run all verification commands
   - Check acceptance criteria are met
   - Document any deviations from plan
   - Create validation report

### Completion

1. **Verify Deployment Infrastructure is Complete:**
   - CI/CD pipeline runs successfully
   - All tests pass in CI
   - Build succeeds
   - Deployment works (if configured)
   - Documentation is complete

2. **Present to Stakeholder:**
   - Demonstrate CI/CD pipeline
   - Show successful build and test run
   - Walk through deployment process
   - Show deployment documentation

3. **Stakeholder Review Process:**
   - Ask if they approve the deployment infrastructure
   - Address any questions or requests for modifications
   - Make revisions if needed based on feedback

4. **Finalization:**
   - Commit all deployment infrastructure files
   - Mark the deployment infrastructure creation as complete once approved
   - Proceed to next assignment or begin feature development

### Notes

- **Platform-agnostic**: Adapt to your CI/CD platform and deployment target
- **Start simple**: Basic CI first, add complexity later
- **Fast feedback**: Optimize for fast CI runs (caching, parallelization)
- **Clear failures**: Make it easy to understand why CI failed
- **Security**: Never commit secrets, use platform secret management
- Not all projects need containers - use what makes sense
- CI/CD platform varies by organization - adapt accordingly
- Focus on automation and documentation
- Test deployment process in non-production environment first
