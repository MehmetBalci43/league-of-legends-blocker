# League of Legends Unblock Script
# This script removes LoL blocking
# MUST BE RUN AS ADMINISTRATOR!

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "League of Legends Unblock" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Administrator check
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: This script must be run as administrator!" -ForegroundColor Red
    Write-Host "Right-click and select 'Run as administrator'." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit
}

# Hosts file path
$hostsPath = "$env:SystemRoot\System32\drivers\etc\hosts"

Write-Host "Removing League of Legends block..." -ForegroundColor Yellow
Write-Host ""

# Backup hosts file
$backupPath = "$hostsPath.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
Copy-Item -Path $hostsPath -Destination $backupPath -Force
Write-Host "[OK] Hosts file backed up: $backupPath" -ForegroundColor Green

# Read current hosts content
$hostsContent = Get-Content -Path $hostsPath

# LoL block start and end markers
$startMarker = "# === LoL Block Start ==="
$endMarker = "# === LoL Block End ==="

# Remove LoL blocks - improved version
$newContent = @()
$skipLines = $false
$removedCount = 0

# List of LoL-related domains to remove
$lolDomains = @(
    "riot", "riotgames", "leagueoflegends", "lol\.", "valorant", 
    "riotcdn", "akamaihd\.net", "playvalorant"
)

foreach ($line in $hostsContent) {
    # Check if this is a marker line
    if ($line -eq $startMarker) {
        $skipLines = $true
        Write-Host "  [Found] LoL Block Start marker" -ForegroundColor DarkGray
        continue
    }
    elseif ($line -eq $endMarker) {
        $skipLines = $false
        Write-Host "  [Found] LoL Block End marker" -ForegroundColor DarkGray
        continue
    }
    
    # Skip lines between markers
    if ($skipLines) {
        if ($line -match "^127\.0\.0\.1\s+") {
            $removedCount++
            Write-Host "  [-] Removed: $line" -ForegroundColor DarkGray
        }
        continue
    }
    
    # Check for LoL-related comments (Turkish or English)
    if ($line -match "League of Legends|LoL Block|Riot Games") {
        Write-Host "  [-] Removed comment: $line" -ForegroundColor DarkGray
        continue
    }
    
    # Check for LoL-related domain entries (even outside markers)
    $isLolEntry = $false
    foreach ($domain in $lolDomains) {
        if ($line -match $domain) {
            $isLolEntry = $true
            break
        }
    }
    
    if ($isLolEntry -and ($line -match "^127\.0\.0\.1\s+" -or $line -match "^0\.0\.0\.0\s+")) {
        $removedCount++
        Write-Host "  [-] Removed orphan entry: $line" -ForegroundColor DarkGray
        continue
    }
    
    # Keep all other lines
    $newContent += $line
}

# Update hosts file
Set-Content -Path $hostsPath -Value $newContent -Force

Write-Host ""
Write-Host "==================================" -ForegroundColor Green
Write-Host "SUCCESS: League of Legends unblocked!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""
Write-Host "Total $removedCount server blocks removed." -ForegroundColor Cyan
Write-Host ""

# Auto flush DNS cache
Write-Host "Flushing DNS cache..." -ForegroundColor Yellow
ipconfig /flushdns | Out-Null
Write-Host "[OK] DNS cache flushed!" -ForegroundColor Green
Write-Host ""
Write-Host "You can now connect to League of Legends again." -ForegroundColor Yellow
Write-Host ""

Read-Host "Done! Press Enter to exit"
