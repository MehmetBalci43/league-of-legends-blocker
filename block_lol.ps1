# League of Legends Blocker Script
# This script blocks LoL servers by modifying the hosts file
# MUST BE RUN AS ADMINISTRATOR!

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "League of Legends Blocker" -ForegroundColor Cyan
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

# League of Legends servers (Riot Games servers)
$lolServers = @(
    # Main Riot servers
    "riot.com",
    "www.riot.com",
    "riotgames.com",
    "www.riotgames.com",
    
    # League of Legends main servers
    "leagueoflegends.com",
    "www.leagueoflegends.com",
    
    # Game servers - EUW (Europe West)
    "prod.euw1.lol.riotgames.com",
    "euw1.api.riotgames.com",
    
    # Game servers - EUNE (Europe Nordic & East)
    "prod.eun1.lol.riotgames.com",
    "eun1.api.riotgames.com",
    
    # Game servers - TR (Turkey)
    "prod.tr1.lol.riotgames.com",
    "tr1.api.riotgames.com",
    
    # Game servers - NA (North America)
    "prod.na1.lol.riotgames.com",
    "na1.api.riotgames.com",
    
    # Game servers - Other regions
    "prod.kr.lol.riotgames.com",
    "prod.br1.lol.riotgames.com",
    "prod.la1.lol.riotgames.com",
    "prod.la2.lol.riotgames.com",
    "prod.oc1.lol.riotgames.com",
    "prod.ru.lol.riotgames.com",
    "prod.jp1.lol.riotgames.com",
    
    # Launcher and update servers
    "l3cdn.riotgames.com",
    "lol.secure.dyn.riotcdn.net",
    "worldwide.l3cdn.riotgames.com",
    "lol.dyn.riotcdn.net",
    
    # Patch servers
    "lol.patcher.riotgames.com",
    "patcher.riotgames.com",
    
    # Login servers
    "auth.riotgames.com",
    "login.leagueoflegends.com",
    
    # Chat servers
    "chat.euw1.lol.riotgames.com",
    "chat.eun1.lol.riotgames.com",
    "chat.tr1.lol.riotgames.com",
    "chat.na1.lol.riotgames.com",
    
    # Spectator servers
    "spectator.euw1.lol.riotgames.com",
    "spectator.eun1.lol.riotgames.com",
    "spectator.tr1.lol.riotgames.com",
    
    # Store and content servers
    "store.leagueoflegends.com",
    "lolstatic-a.akamaihd.net",
    "ddragon.leagueoflegends.com",
    
    # Valorant and other Riot games (bonus)
    "playvalorant.com",
    "valorant.com",
    "valorant-api.com"
)

Write-Host "Blocking League of Legends servers..." -ForegroundColor Yellow
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

# Remove old LoL blocks
$newContent = @()
$skipLines = $false

foreach ($line in $hostsContent) {
    if ($line -eq $startMarker) {
        $skipLines = $true
    }
    elseif ($line -eq $endMarker) {
        $skipLines = $false
        continue
    }
    
    if (-not $skipLines) {
        $newContent += $line
    }
}

# Add new LoL blocks
$newContent += ""
$newContent += $startMarker
$newContent += "# League of Legends Blocked - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"

foreach ($server in $lolServers) {
    $newContent += "127.0.0.1 $server"
    Write-Host "  [+] Blocked: $server" -ForegroundColor DarkGray
}

$newContent += $endMarker
$newContent += ""

# Update hosts file
Set-Content -Path $hostsPath -Value $newContent -Force

Write-Host ""
Write-Host "==================================" -ForegroundColor Green
Write-Host "SUCCESS: League of Legends blocked!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""
Write-Host "Total $($lolServers.Count) servers blocked." -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTE: To unblock, run 'unblock_lol.ps1' script." -ForegroundColor Yellow
Write-Host ""
Write-Host "To flush DNS cache, run this command:" -ForegroundColor Yellow
Write-Host "  ipconfig /flushdns" -ForegroundColor White
Write-Host ""

# Auto flush DNS cache
Write-Host "Flushing DNS cache..." -ForegroundColor Yellow
ipconfig /flushdns | Out-Null
Write-Host "[OK] DNS cache flushed!" -ForegroundColor Green
Write-Host ""

Read-Host "Done! Press Enter to exit"
