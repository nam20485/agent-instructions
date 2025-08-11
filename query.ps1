<#
Resolves ALL unresolved review threads on a given Pull Request.

Usage (defaults to current repo and PR 3):
	pwsh ./query.ps1               # resolves all unresolved threads on PR 3
	pwsh ./query.ps1 -PrNumber 12  # different PR
	pwsh ./query.ps1 -DryRun       # list only (no mutation)
	pwsh ./query.ps1 -Owner user -Repo repo -PrNumber 7

Requires:
	- GitHub CLI (gh) authenticated (gh auth status)

Notes:
	- Idempotent: already resolved threads are skipped.
	- Paginates beyond 100 threads if needed.
	- Set GITHUB_TOKEN / GH_TOKEN or be logged in via gh.
#>

[CmdletBinding()]
param(
	[int]$PrNumber = 3,
	[string]$Owner,
	[string]$Repo,
	[switch]$DryRun,
	[switch]$VerboseLogging
)

function Write-Info($msg){ Write-Host "[info] $msg" -ForegroundColor Cyan }
function Write-Act($msg){ Write-Host "[act ] $msg" -ForegroundColor Green }
function Write-Warn($msg){ Write-Host "[warn] $msg" -ForegroundColor Yellow }
function Write-ErrMsg($msg){ Write-Host "[err ] $msg" -ForegroundColor Red }

# Discover owner/repo if not provided
if(-not $Owner -or -not $Repo){
	try {
		$nwo = gh repo view --json nameWithOwner --jq .nameWithOwner 2>$null
		if(-not $nwo){ throw "Cannot determine repository (are you in a git repo & logged in?)." }
		$parts = $nwo -split '/'
		$Owner = $parts[0]
		$Repo  = $parts[1]
	} catch {
		Write-ErrMsg $_
		exit 1
	}
}

Write-Info "Repository: $Owner/$Repo PR: #$PrNumber"

$query = @'
query($owner:String!,$name:String!,$number:Int!,$cursor:String){
	repository(owner:$owner,name:$name){
		pullRequest(number:$number){
			reviewThreads(first:100, after:$cursor){
				pageInfo{ hasNextPage endCursor }
				nodes{ id isResolved }
			}
		}
	}
}
'@

$threads = @()
$cursor = $null
do {
	$args = @('-f',"query=$query",'-f',"owner=$Owner",'-f',"name=$Repo",'-F',"number=$PrNumber")
	if($cursor){ $args += @('-f',"cursor=$cursor") }
	$respRaw = gh api graphql @args 2>$null
	if(-not $respRaw){ Write-ErrMsg "GraphQL query failed."; exit 2 }
	$resp = $respRaw | ConvertFrom-Json
	$chunk = $resp.data.repository.pullRequest.reviewThreads.nodes
	$threads += $chunk
	$pageInfo = $resp.data.repository.pullRequest.reviewThreads.pageInfo
	$cursor = if($pageInfo.hasNextPage){ $pageInfo.endCursor } else { $null }
} while($cursor)

$unresolved = $threads | Where-Object { -not $_.isResolved }
if(-not $unresolved){
	Write-Info "No unresolved threads found. Nothing to do."
	exit 0
}

Write-Info ("Found {0} unresolved thread(s)." -f $unresolved.Count)
if($DryRun){
	Write-Warn "DryRun specified. Listing thread IDs only:" 
	$unresolved | ForEach-Object { Write-Host "  $($_.id)" }
	exit 0
}

$mutation = 'mutation($id:ID!){resolveReviewThread(input:{threadId:$id}){thread{id isResolved}}}'

$resolvedCount = 0
foreach($t in $unresolved){
	Write-Act "Resolving $($t.id) ..."
	$res = gh api graphql -f query=$mutation -f id=$($t.id) 2>$null | ConvertFrom-Json
	if($res.data.resolveReviewThread.thread.isResolved){
		$resolvedCount++
		if($VerboseLogging){ Write-Info "Resolved: $($t.id)" }
	} else {
		Write-Warn "Thread $($t.id) did not report resolved."
	}
}

Write-Info "Resolved $resolvedCount thread(s). Done."

# Optional: show remaining (should be zero)
if($VerboseLogging){
	$remaining = ($unresolved.Count - $resolvedCount)
	Write-Info "Remaining unresolved (pre-fetch basis): $remaining"
}

# Original single-thread command (kept for reference):
# gh api graphql -f query='mutation($id:ID!){resolveReviewThread(input:{threadId:$id}){thread{id isResolved}}}' -f id="PRRT_kwDOO36Jxc5XFYix" -H "Accept: application/vnd.github+json"

# Source discussion example:
# https://github.com/nam20485/agent-instructions/pull/3
