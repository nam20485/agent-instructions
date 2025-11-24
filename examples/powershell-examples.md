# PowerShell Development Examples

## Example 1: Naming Conventions

```powershell
function Get-UserProfile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Username,

        [Parameter()]
        [ValidateSet('Basic', 'Detailed')]
        [string]$ProfileType = 'Basic'
    )

    process {
        # Logic here
    }
}
```

## Example 2: Parameter Design

```powershell
function Set-ResourceConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        
        [Parameter()]
        [ValidateSet('Dev', 'Test', 'Prod')]
        [string]$Environment = 'Dev',
        
        [Parameter()]
        [switch]$Force,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]]$Tags
    )
    
    process {
        # Logic here
    }
}
```

## Example 3: Pipeline and Output (PassThru Pattern)

```powershell
function Update-ResourceStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('Active', 'Inactive', 'Maintenance')]
        [string]$Status,

        [Parameter()]
        [switch]$PassThru
    )

    begin {
        Write-Verbose "Starting resource status update process"
        $timestamp = Get-Date
    }

    process {
        # Process each resource individually
        Write-Verbose "Processing resource: $Name"
        
        $resource = [PSCustomObject]@{
            Name = $Name
            Status = $Status
            LastUpdated = $timestamp
            UpdatedBy = $env:USERNAME
        }

        # Only output if PassThru is specified
        if ($PassThru) {
            Write-Output $resource
        }
    }

    end {
        Write-Verbose "Resource status update process completed"
    }
}
```

## Example 4: Error Handling and Safety

```powershell
function Remove-UserAccount {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$Username,

        [Parameter()]
        [switch]$Force
    )

    begin {
        Write-Verbose "Starting user account removal process"
        $ErrorActionPreference = 'Stop'
    }

    process {
        try {
            # Validation
            if (-not (Test-UserExists -Username $Username)) {
                Write-Error "User account '$Username' not found"
                return
            }

            # Confirmation
            $shouldProcessMessage = "Remove user account '$Username'"
            if ($Force -or $PSCmdlet.ShouldProcess($Username, $shouldProcessMessage)) {
                Write-Verbose "Removing user account: $Username"
                
                # Main operation
                Remove-ADUser -Identity $Username -ErrorAction Stop
                Write-Warning "User account '$Username' has been removed"
            }
        }
        catch [Microsoft.ActiveDirectory.Management.ADException] {
            Write-Error "Active Directory error: $_"
            throw
        }
        catch {
            Write-Error "Unexpected error removing user account: $_"
            throw
        }
    }

    end {
        Write-Verbose "User account removal process completed"
    }
}
```

## Example 5: Module Manifest Creation

```powershell
$manifestParams = @{
  Path                  = '.\MyTools\MyTools.psd1'
  RootModule            = 'MyTools.psm1'
  ModuleVersion         = '1.0.0'
  Author                = 'Your Name'
  Description           = 'Utilities for working with Things'
  PowerShellVersion     = '7.2'
  CompatiblePSEditions  = @('Core')
  RequiredModules       = @('Microsoft.PowerShell.Management')
}
New-ModuleManifest @manifestParams
```

## Example 6: Module Export Pattern

```powershell
# MyTools.psm1
$public  = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter *.ps1 -ErrorAction SilentlyContinue
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') -Filter *.ps1 -ErrorAction SilentlyContinue

foreach ($file in @($public + $private)) { . $file.FullName }

# Export only the public functions
Export-ModuleMember -Function ($public | ForEach-Object { $_.BaseName })
```

## Example 7: Pester Tests (AAA Pattern)

```powershell
# Tests\Get-Thing.Tests.ps1
Describe 'Get-Thing' {
    Context 'when called with a valid name' {
        It 'returns a Thing object with the expected Name' {
            # Arrange
            $name = 'foo'

            # Act
            $result = Get-Thing -Name $name

            # Assert
            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Be $name
        }
    }
}
```

## Example 8: Mocking in Tests

```powershell
# Tests\Module.Tests.ps1
Import-Module (Resolve-Path './MyTools/MyTools.psd1') -Force

InModuleScope 'MyTools' {
    Describe 'New-Thing' {
        It 'calls Convert-Internal with correct parameters' {
            Mock -CommandName Convert-Internal -MockWith { return @{ Name = $args[0] } }

            $result = New-Thing -Name 'bar'

            Assert-MockCalled Convert-Internal -Times 1 -Exactly -ParameterFilter { $Name -eq 'bar' }
            $result.Name | Should -Be 'bar'
        }
    }
}
```

## Example 9: End-to-End Cmdlet Pattern

```powershell
function New-Resource {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [ValidateSet('Development', 'Production')]
        [string]$Environment = 'Development'
    )
    
    begin {
        Write-Verbose "Starting resource creation process"
    }
    
    process {
        try {
            if ($PSCmdlet.ShouldProcess($Name, "Create new resource")) {
                # Resource creation logic here
                Write-Output ([PSCustomObject]@{
                    Name = $Name
                    Environment = $Environment
                    Created = Get-Date
                })
            }
        }
        catch {
            Write-Error "Failed to create resource: $_"
        }
    }
    
    end {
        Write-Verbose "Completed resource creation process"
    }
}
```
