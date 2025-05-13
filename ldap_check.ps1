param (
    [string]$serverList
)

$servers = $serverList -split "," | ForEach-Object { $_.Trim() }
$port = 389
$baseDN = "DC=domain,DC=local"
$filter = "(sAMAccountName=Administrator)"

foreach ($server in $servers) {
    $bindTime = $searchTime = -1
    $bindSuccess = $false

    try {
        $bindTimer = [System.Diagnostics.Stopwatch]::StartNew()
        $entry = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$($server):$($port)")
        $null = $entry.NativeObject
        $bindTimer.Stop()
        $bindTime = $bindTimer.ElapsedMilliseconds
        $bindSuccess = $true
    } catch {
        $bindTimer.Stop()
    }

    if ($bindSuccess) {
        try {
            $searchTimer = [System.Diagnostics.Stopwatch]::StartNew()
            $searcher = New-Object System.DirectoryServices.DirectorySearcher($entry)
            $searcher.Filter = $filter
            $searcher.SearchScope = "Subtree"
            $searcher.BaseDN = $baseDN
            $null = $searcher.FindOne()
            $searchTimer.Stop()
            $searchTime = $searchTimer.ElapsedMilliseconds
        } catch {}
    }

    Write-Output "$server|$bindTime|$searchTime"
}
