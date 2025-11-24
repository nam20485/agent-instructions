# Agent Script Engine Examples

## Example 1: Simple File Operations

This example demonstrates basic file operations like creating and reading files.

```markdown
# Simple File Operations Script

## Inputs
- filename: string - The name of the file to create
- content: string - The content to write to the file

## Declarations
function createFile(filename: string, content: string): void
function readFile(filename: string): string
function logMessage(message: string): void

## Script
logMessage("Creating file: " + filename)
createFile(filename, content)
logMessage("File created successfully")

result = readFile(filename)
logMessage("File contents: " + result)
```

## Example 2: Data Processing Pipeline

This example shows how to process data through multiple steps.

```markdown
# Data Processing Pipeline

## Inputs
- dataSource: string - The source of the data
- outputFormat: string - The desired output format

## Declarations
function fetchData(source: string): array
function filterData(data: array, condition: string): array
function transformData(data: array, format: string): object
function saveResults(data: object, destination: string): void

## Script
rawData = fetchData(dataSource)
filteredData = filterData(rawData, "status == active")
transformedData = transformData(filteredData, outputFormat)
saveResults(transformedData, "output/results.json")
```

## Example 3: Automated Testing Workflow

This example demonstrates a simple testing workflow.

```markdown
# Automated Testing Workflow

## Inputs
- testSuite: string - The test suite to run
- environment: string - The environment to test in

## Declarations
function setupEnvironment(env: string): void
function runTests(suite: string): object
function generateReport(results: object): string
function notifyTeam(message: string): void

## Script
setupEnvironment(environment)
testResults = runTests(testSuite)

if (testResults.failed > 0) {
    report = generateReport(testResults)
    notifyTeam("Tests failed! Report: " + report)
} else {
    notifyTeam("All tests passed successfully!")
}
```

## Example 4: Basic Code Analysis

This example shows how to analyze code files.

```markdown
# Code Analysis Script

## Inputs
- sourceDirectory: string - The directory containing source files

## Declarations
function listFiles(directory: string, pattern: string): array
function analyzeFile(filepath: string): object
function summarizeResults(results: array): object
function displayReport(summary: object): void

## Script
files = listFiles(sourceDirectory, "*.js")
results = []

for (file in files) {
    analysis = analyzeFile(file)
    results.append(analysis)
}

summary = summarizeResults(results)
displayReport(summary)
```

## Example 5: Simple Deployment Script

This example demonstrates a basic deployment workflow.

```markdown
# Simple Deployment Script

## Inputs
- applicationName: string - The name of the application
- targetEnvironment: string - The deployment target (dev, staging, prod)
- version: string - The version to deploy

## Declarations
function validateEnvironment(env: string): boolean
function buildApplication(app: string, ver: string): string
function deployToEnvironment(buildPath: string, env: string): boolean
function runHealthCheck(env: string): boolean
function rollback(env: string, previousVersion: string): void
function notifyDeployment(status: string, details: string): void

## Script
isValid = validateEnvironment(targetEnvironment)

if (!isValid) {
    notifyDeployment("failed", "Invalid environment: " + targetEnvironment)
    exit(1)
}

buildPath = buildApplication(applicationName, version)
deployed = deployToEnvironment(buildPath, targetEnvironment)

if (deployed) {
    healthy = runHealthCheck(targetEnvironment)
    if (healthy) {
        notifyDeployment("success", "Deployment completed successfully")
    } else {
        notifyDeployment("warning", "Deployment completed but health check failed")
        rollback(targetEnvironment, "previous")
    }
} else {
    notifyDeployment("failed", "Deployment failed")
}
```
