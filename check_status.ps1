# LoL Block Status Checker
# This script checks if LoL is currently blocked
# Can be run WITHOUT administrator rights

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "LoL Block Status Checker" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# Hosts file path
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"

# Read hosts file
try {
    $hostsContent = Get-Content -Path $hostsPath -ErrorAction Stop
}
catch {
    Write-Host "ERROR: Cannot read hosts file!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

# Check for LoL-related entries
$lolPatterns = @(
    "riot\.com",
    "riotgames\.com",
    "leagueoflegends\.com",
    "lol\..*riotgames\.com",
    "valorant",
    "riotcdn",
    "lolstatic"
)

$blockedEntries = @()
$foundMarkers = $false

foreach ($line in $hostsContent) {
    # Check for markers
    if ($line -match "LoL Block") {
        $foundMarkers = $true
    }
    
    # Check for blocked entries
    foreach ($pattern in $lolPatterns) {
        if ($line -match $pattern -and ($line -match "^127\.0\.0\.1" -or $line -match "^0\.0\.0\.0")) {
            $blockedEntries += $line.Trim()
            break
        }
    }
}

# Display results
Write-Host "Status Check Results:" -ForegroundColor Yellow
Write-Host ""

if ($blockedEntries.Count -eq 0 -and -not $foundMarkers) {
    Write-Host "[OK] LoL is NOT blocked" -ForegroundColor Green
    Write-Host "     You can connect to League of Legends." -ForegroundColor Gray
}
elseif ($blockedEntries.Count -gt 0) {
    Write-Host "[BLOCKED] LoL IS BLOCKED" -ForegroundColor Red
    Write-Host "          Found $($blockedEntries.Count) blocked entries:" -ForegroundColor Yellow
    Write-Host ""
    
    $displayCount = [Math]::Min(10, $blockedEntries.Count)
    for ($i = 0; $i -lt $displayCount; $i++) {
        Write-Host "   - $($blockedEntries[$i])" -ForegroundColor DarkGray
    }
    
    if ($blockedEntries.Count -gt 10) {
        Write-Host "   ... and $($blockedEntries.Count - 10) more entries" -ForegroundColor DarkGray
    }
}
else {
    Write-Host "[WARNING] Markers found but no active blocks" -ForegroundColor Yellow
    Write-Host "          This might indicate a partial unblock." -ForegroundColor Gray
}

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan

if ($foundMarkers) {
    Write-Host "[INFO] Block markers detected in hosts file" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "To view full hosts file, run:" -ForegroundColor Yellow
Write-Host "  notepad $hostsPath" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to exit"
