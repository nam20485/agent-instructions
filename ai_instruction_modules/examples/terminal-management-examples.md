# Terminal Management Examples

## Correct Usage
```powershell
# Sequential commands (reuse terminal)
# Use isBackground=false (default) for standard operations
dotnet build
dotnet test
git status

# Background service (new terminal)
# Use isBackground=true ONLY for long-running processes
dotnet run --project WebApp
```

## Incorrect Usage
```powershell
# WRONG: Using isBackground=true for sequential commands
# This creates unnecessary terminal instances
dotnet build # Should be isBackground=false
dotnet test  # Should be isBackground=false
```

## Cleanup Strategy
```powershell
# Monitor running processes
Get-Process | Where-Object { $_.ProcessName -like "*powershell*" }

# Check for resource usage
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10
```
