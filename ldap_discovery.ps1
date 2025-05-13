param (
    [string]$serverList
)

$servers = $serverList -split "," | ForEach-Object { $_.Trim() }
$data = @()

foreach ($server in $servers) {
    $data += @{ "{#LDAPSERVER}" = $server }
}

Write-Output (@{ data = $data } | ConvertTo-Json -Compress)
