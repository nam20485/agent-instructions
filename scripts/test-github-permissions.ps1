# Test-GitHubPermissions.ps1
# Script to verify GitHub authentication and permissions required for workflow assignments

param(
    [Parameter(Mandatory = $false)]
    [string]$Owner = $env:GITHUB_USERNAME,
    
    [Parameter(Mandatory = $false)]
    [string]$TestRepoName = "test-repo-permissions-$(Get-Date -Format 'yyyyMMdd-HHmmss')",
    
    [Parameter(Mandatory = $false)]
    [string]$TestProjectName = "Test Project $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')",
    
    [Parameter(Mandatory = $false)]
    [switch]$Cleanup = $true,
    
    [Parameter(Mandatory = $false)]
    [switch]$AutoFixAuth = $false
)

# Function to write colored output
function Write-Status {
    param(
        [string]$Message,
        [string]$Status = 'INFO'
    )
    
    $color = switch ($Status) {
        'SUCCESS' { 'Green' }
        'ERROR' { 'Red' }
        'WARNING' { 'Yellow' }
        'INFO' { 'Cyan' }
        default { 'White' }
    }
    
    Write-Host "[$Status] $Message" -ForegroundColor $color
}

# Function to test a command and return success/failure
function Test-Command {
    param(
        [string]$Command,
        [string]$Description
    )
    
    Write-Host "`nTesting: $Description" -ForegroundColor Yellow
    Write-Host "Command: $Command" -ForegroundColor Gray
    
    try {
        $result = Invoke-Expression $Command
        if ($LASTEXITCODE -eq 0) {
            Write-Status "SUCCESS - $Description" 'SUCCESS'
            return $true
        }
        else {
            Write-Status "ERROR - $Description" 'ERROR'
            return $false
        }
    }
    catch {
        Write-Status "ERROR - $Description : $($_.Exception.Message)" 'ERROR'
        return $false
    }
}

# Function to check for specific auth scopes by testing actual API access
function Test-AuthScopes {
    Write-Host "`nChecking GitHub authentication scopes..." -ForegroundColor Yellow
    
    # Check basic authentication first
    $authCheck = & gh auth status 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Status 'Authentication check failed' 'ERROR'
        return $false
    }
    
    # Define required scopes and their associated test commands
    $scopeTests = @{
        'user:email,read:user' = @{
            TestCommand = "gh api user --jq '.login'"
            Description = 'User profile access'
        }
        'repo'                 = @{
            TestCommand = "gh api user/repos?per_page=1 --jq '.[0].name' 2>null"
            Description = 'Repository access'
        }
        'project,read:project' = @{
            TestCommand = "gh api user/projects?per_page=1 --jq '.[0].name' 2>null"
            Description = 'Project access'
        }
    }
    
    $allScopesOk = $true
    
    # Test each scope requirement
    foreach ($scope in $scopeTests.Keys) {
        $testInfo = $scopeTests[$scope]
        Write-Host "Testing $($testInfo.Description)..." -ForegroundColor Gray
        
        # Execute the specific test command for this scope
        $result = Invoke-Expression $testInfo.TestCommand 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Status "Missing scope for: $($testInfo.Description) (requires: $scope)" 'ERROR'
            $allScopesOk = $false
            
            if ($AutoFixAuth) {
                Write-Host "`nAttempting to add missing scope: $scope..." -ForegroundColor Yellow
                $refreshResult = & gh auth refresh -h github.com -s $scope 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Write-Status "Successfully added scope: $scope" 'SUCCESS'
                    # Test again to confirm it worked
                    $result = Invoke-Expression $testInfo.TestCommand 2>$null
                    if ($LASTEXITCODE -eq 0) {
                        Write-Status 'Scope verification successful' 'SUCCESS'
                    }
                    else {
                        Write-Status 'Scope was added but verification failed' 'WARNING'
                    }
                }
                else {
                    Write-Status "Failed to add scope ${scope}: $refreshResult" 'ERROR'
                }
            }
            else {
                Write-Status "To add this scope, run: gh auth refresh -s $scope" 'WARNING'
            }
        }
        else {
            Write-Status "OK - $($testInfo.Description)" 'SUCCESS'
        }
    }
    
    # If we get here, we at least have basic access to try the required operations
    if ($allScopesOk) {
        Write-Status 'All required scopes appear to be present' 'SUCCESS'
    }
    else {
        Write-Status 'Some scopes are missing - see above for details' 'WARNING'
    }
    
    return $allScopesOk
}

# Main script execution
Write-Host 'GitHub Permissions Verification Script' -ForegroundColor Green
Write-Host '=====================================' -ForegroundColor Green
if ($AutoFixAuth) {
    Write-Host 'Auto-fix authentication enabled' -ForegroundColor Cyan
}

# Check if gh CLI is installed
if (!(Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Status 'ERROR - GitHub CLI (gh) is not installed or not in PATH' 'ERROR'
    exit 1
}

Write-Status 'GitHub CLI is installed' 'SUCCESS'

# Test 1: Authentication status
$authTest = Test-Command 'gh auth status' 'GitHub Authentication Status'
if (-not $authTest) {
    if ($AutoFixAuth) {
        Write-Host "`nAttempting to authenticate..." -ForegroundColor Yellow
        # Dot source the gh-auth script to use its function
        try {
            . "$PSScriptRoot/gh-auth.ps1"
            Initialize-GitHubAuth -Token $env:GITHUB_AUTH_TOKEN
            Write-Status 'Authentication initialized' 'SUCCESS'
        }
        catch {
            Write-Status "Failed to initialize authentication: $($_.Exception.Message)" 'ERROR'
        }
    }
    else {
        Write-Status "Authentication check failed. Please run 'gh auth login' to authenticate." 'ERROR'
        Write-Status 'Or use the -AutoFixAuth parameter to attempt automatic authentication.' 'WARNING'
        exit 1
    }
}

# Test 2: Authentication scopes
$scopeTest = Test-AuthScopes

# Test 3: Repository creation/deletion permissions
$repoTest = Test-Command "gh repo create $TestRepoName --public --confirm" 'Repository Creation'
if ($repoTest) {
    # Clean up the test repository
    if ($Cleanup) {
        $deleteTest = Test-Command "gh repo delete $TestRepoName --confirm" 'Repository Deletion'
    }
}
else {
    Write-Status 'Repository creation test failed' 'ERROR'
}

# Test 4: Project creation (requires project and read:project scopes)
if ($Owner) {
    $projectTest = Test-Command "gh project create --title '$TestProjectName' --owner $Owner --format json" 'Project Creation'
    if ($projectTest -and $Owner) {
        # Clean up the test project - note: gh cli doesn't have a direct delete project command
        Write-Status "Note: Created test project '$TestProjectName'. Manual cleanup may be needed." 'WARNING'
    }
}
else {
    Write-Status 'Owner parameter not provided, skipping project creation test. Pass -Owner parameter or set GITHUB_USERNAME environment variable.' 'WARNING'
}

# Test 5: Label management (requires an existing repo)
if ($Owner) {
    # Try to list labels on a common repository to test permissions
    $labelTest = Test-Command "gh label list --repo $Owner/$TestRepoName 2>`$null || gh label list --repo $Owner/`$(gh repo list --limit 1 --json nameWithOwner | ConvertFrom-Json).nameWithOwner.split('/')[1]" 'Label Management'
    if (-not $labelTest) {
        Write-Status 'Label management test failed, possibly because the test repo was not created successfully.' 'WARNING'
    }
}
else {
    Write-Status 'Owner parameter not provided, skipping label management test.' 'WARNING'
}

# Test 6: Milestone creation (requires an existing repo)
if ($Owner) {
    # We'll use the test repo if it was created successfully, otherwise try to find another repo
    $milestoneTest = $false
    if ($repoTest) {
        $milestoneTest = Test-Command "gh milestone create 'Test Milestone' --repo $Owner/$TestRepoName 2>`$null || true" 'Milestone Creation'
        # Clean up milestone if created
        if ($milestoneTest -and $Cleanup) {
            Test-Command "gh milestone close 'Test Milestone' --repo $Owner/$TestRepoName 2>`$null || true" 'Milestone Closure'
        }
    }
    if (-not $milestoneTest) {
        Write-Status 'Milestone creation test failed or skipped (requires existing repo)' 'WARNING'
    }
}
else {
    Write-Status 'Owner parameter not provided, skipping milestone creation test.' 'WARNING'
}

# Test 7: Branch/PR creation workflow (requires cloning a repo)
if ($Owner -and $repoTest) {
    Write-Host "`nTesting: Branch/PR Creation Workflow" -ForegroundColor Yellow
    
    # Clone the test repository
    try {
        Write-Host "Cloning $Owner/$TestRepoName..." -ForegroundColor Gray
        Invoke-Expression "gh repo clone $Owner/$TestRepoName .tmp-test-repo"
        
        # Change directory to the cloned repo
        Push-Location .tmp-test-repo
        
        # Create a test branch
        $branchResult = git checkout -b "test-permissions-$(Get-Date -Format 'HHmmss')" 2>$null
        if ($?) {
            Write-Status 'SUCCESS - Branch Creation' 'SUCCESS'
            
            # Create a dummy file to have something to commit
            'Test file for permissions verification' | Out-File -FilePath 'test-permissions.txt' -Encoding utf8
            
            # Add and commit the file
            git add . 2>$null
            git commit -m 'Test commit for permissions verification' 2>$null
            
            # Try to push the branch
            $pushResult = git push origin "test-permissions-$(Get-Date -Format 'HHmmss')" 2>$null
            if ($?) {
                Write-Status 'SUCCESS - Branch Push' 'SUCCESS'
            }
            else {
                Write-Status 'ERROR - Branch Push' 'ERROR'
            }
        }
        else {
            Write-Status 'ERROR - Branch Creation' 'ERROR'
        }
        
        # Clean up
        Pop-Location
        if ($Cleanup) {
            Remove-Item -Path .tmp-test-repo -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
    catch {
        Write-Status "ERROR - Branch/PR Creation Workflow : $($_.Exception.Message)" 'ERROR'
    }
}
else {
    Write-Status 'Owner parameter not provided or test repo not created, skipping branch/PR creation test.' 'WARNING'
}

Write-Host "`nGitHub Permissions Verification Complete" -ForegroundColor Green
Write-Host '=====================================' -ForegroundColor Green
Write-Host 'Note: Some tests may show warnings if prerequisites (like Owner parameter) were not met.' -ForegroundColor Yellow

# Summary
$allTestsPassed = $authTest -and $scopeTest -and $repoTest
if ($allTestsPassed) {
    Write-Status 'All critical tests passed!' 'SUCCESS'
}
else {
    Write-Status 'Some tests failed. Please address the issues before proceeding with workflow assignments.' 'ERROR'
}