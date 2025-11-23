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

# Remove LoL blocks
$newContent = @()
$skipLines = $false
$removedCount = 0

foreach ($line in $hostsContent) {
    if ($line -eq $startMarker) {
        $skipLines = $true
        continue
    }
    elseif ($line -eq $endMarker) {
        $skipLines = $false
        continue
    }
    
    if ($skipLines) {
        if ($line -match "^127\.0\.0\.1\s+") {
            $removedCount++
        }
    }
    else {
        $newContent += $line
    }
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
