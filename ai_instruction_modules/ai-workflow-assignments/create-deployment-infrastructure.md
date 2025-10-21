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
