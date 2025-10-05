# Assignment: Create App from Plan Issue

## (create-application-from-plan-issue)

### Goal

Given an initialized git repo and fill development plan issue, create a new application based on the filled-out application template, including setting up the project structure, configuring necessary components, and ensuring the application meets specified requirements.

### Input

1. An initialized git repository
1. A filled-out application template
1. A filled-out development plan issue

### Acceptance Criteria

1. Application template has been thoroughly analyzed and understood
2. Plan's project structure has been created according to established guidelines and plan
3. Template from Appendix A has been used as a template for the plan.
4. Plan contains detailed breakdown of all phases required to achieve complete implementation.
5. All phases list important steps required to achieve completion of that phase.
6. All required components and dependencies have been planned.
7. Application plan follows the specified technology stack and design principles
8. All mandatory application requirements have been addressed in plan. (testing, documentation, containerization, etc.)
9. All acceptance criteria from the template have been addressed in the plan.
10. All risks and mitigations identified.
11. Code quality standards and best practices have been followed.
12. Application plan is ready for development and implementation.
13. Application plan has been documented in an issue using the template in #Appendix A.
14. Epic sub-issue have been created for each and every phase. (Use template in #Appendix B)
15. Phase sub-issues have been assigned to milestones.
16. All required components and dependencies have been implemented
17. Application follows the specified technology stack and design principles
18. All mandatory application requirements have been implemented (testing, documentation, containerization, etc.)
19. Application builds and runs successfully
20. All acceptance criteria from the template have been satisfied
21. Code quality standards and best practices have been followed
22. Application is ready for deployment and use

### Assignment

Your assignment is to create a complete new application based on a filled-out application template. This involves systematic analysis of requirements, careful implementation following established guidelines, and delivery of a production-ready application that meets all specified criteria.

**IMPORTANT**: Always follow instructions exactly as listed here.

It is important to the final quality of our product for everyone to perform their assignment exactly as specified.

**IF YOU DO NOT COMPLETE ANY OF THE ACCEPTANCE CRITERIA AND MANDATORY REQUIREMENTS, YOUR WORK WILL NOT BE APPROVED.**

**MANDATORY**: You must use the filled-out development plan issue as the authoritative source for your implementation. Follow the plan exactly as specified, and ensure that all phases and steps are completed as outlined in the plan.

### Detailed Steps

Given the following, implement the application as per the filled-out development plan issue:

1. Initialized Git repo
2. Filled-out application template
3. Filled-out development plan issue
4. Created project structure

4. **Technology Stack Implementation**
   1. Implement the backend services using ASP.NET Core Web API
   2. Set up the frontend using Blazor WebAssembly
   3. Configure dependency injection and service registration
   4. Implement data access layer with appropriate database choices
   5. Set up authentication and authorization if required
   6. Configure logging using Serilog with structured logging

5. **Core Functionality Development**
   1. Implement all required business logic and features
   2. Create necessary controllers, services, and models
   3. Implement data persistence and retrieval functionality
   4. Add input validation and error handling
   5. Implement any required integrations or external API connections
   6. Follow SOLID principles and established design patterns

6. **Testing Implementation**
   1. Create comprehensive unit tests using xUnit and FluentAssertions
   2. Implement integration tests for critical application paths
   3. Use Moq for mocking dependencies in tests
   4. Ensure substantial test coverage (aim for >80%)
   5. Set up automated test execution in CI/CD pipeline
   6. Create test data and fixtures as needed

7. **Documentation and API Design**
   1. Implement Swagger/OpenAPI documentation for all APIs
   2. Create comprehensive README.md with setup and usage instructions
   3. Document all configuration options and environment variables
   4. Create API documentation and examples
   5. Document deployment procedures and requirements
   6. Add inline code documentation following XML documentation standards

8. **Containerization and Deployment**
   1. Create Docker images for all application components
   2. Set up Docker Compose for local development and testing
   3. Configure environment-specific settings and secrets management
   4. Create deployment scripts and automation
   5. Set up health checks and monitoring endpoints
   6. Configure for deployment to Google Cloud services

9. **CI/CD Pipeline Setup**
   1. Create GitHub Actions workflows for automated builds
   2. Set up automated testing on pull requests
   3. Configure Docker image building and pushing to GitHub registry
   4. Implement automated deployment to staging/production environments
   5. Set up code quality checks and static analysis
   6. Configure notifications and reporting

10. **Quality Assurance and Validation**
    1. Perform comprehensive testing of all application features
    2. Validate that all requirements from the template are met
    3. Ensure application follows established design principles
    4. Verify security best practices are implemented
    5. Test deployment and infrastructure setup
    6. Validate performance and scalability requirements

### Completion

1. **Final Application Review**
   1. Conduct final testing of all application functionality
   2. Verify all mandatory requirements are implemented:
      - Automated testing with substantial coverage
      - Comprehensive documentation
      - Docker containerization
      - CI/CD pipeline setup
      - Structured logging implementation
      - Security best practices
   3. Ensure code quality standards are met with warnings as errors
   4. Validate that application builds and runs successfully

2. **Documentation and Handoff**
   1. Complete all documentation including:
      - Comprehensive README.md
      - API documentation via Swagger
      - Deployment and configuration guides
      - Architecture and design documentation
   2. Create user guides and getting-started documentation
   3. Document any known issues or limitations
   4. Provide troubleshooting guides and common solutions

3. **Stakeholder Delivery**
   1. Demonstrate the completed application to stakeholders
   2. Walk through all implemented features and capabilities
   3. Provide training or documentation for application usage
   4. Address any feedback or change requests
   5. Confirm that all acceptance criteria are satisfied
   6. Get final approval and sign-off from stakeholders

4. **Repository and Project Finalization**
   1. Ensure all code is committed and pushed to the main repository
   2. Create final release tags and version documentation
   3. Update any project tracking or management systems
   4. Clean up temporary branches and development artifacts
   5. Archive or organize development notes and resources

Ask the orchestrator for your next assignment once the application has been successfully created, tested, and delivered to stakeholder satisfaction.
