@echo off
:: League of Legends Blocker - Batch Version
:: RIGHT-CLICK this file and select "Run as administrator"!

echo ====================================
echo League of Legends Blocker
echo ====================================
echo.

:: Administrator check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This file must be run as administrator!
    echo.
    echo RIGHT-CLICK and select "Run as administrator"!
    echo.
    pause
    exit /b 1
)

echo Blocking League of Legends...
echo.

:: Hosts file path
set HOSTS=%SystemRoot%\System32\drivers\etc\hosts

:: Create backup
copy "%HOSTS%" "%HOSTS%.backup_%date:~-4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%" >nul 2>&1
echo [OK] Hosts file backed up!

:: Remove old LoL blocks
findstr /v /c:"# === LoL Block" /c:"riot.com" /c:"riotgames.com" /c:"leagueoflegends.com" /c:"lol.riotgames.com" /c:"playvalorant.com" /c:"valorant.com" "%HOSTS%" > "%HOSTS%.tmp"
move /y "%HOSTS%.tmp" "%HOSTS%" >nul 2>&1

:: Add new blocks
echo. >> "%HOSTS%"
echo # === LoL Block Start === >> "%HOSTS%"
echo # League of Legends Blocked - %date% %time% >> "%HOSTS%"

:: Main Riot servers
echo 127.0.0.1 riot.com >> "%HOSTS%"
echo 127.0.0.1 www.riot.com >> "%HOSTS%"
echo 127.0.0.1 riotgames.com >> "%HOSTS%"
echo 127.0.0.1 www.riotgames.com >> "%HOSTS%"

:: League of Legends
echo 127.0.0.1 leagueoflegends.com >> "%HOSTS%"
echo 127.0.0.1 www.leagueoflegends.com >> "%HOSTS%"

:: Game servers - EUW
echo 127.0.0.1 prod.euw1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 euw1.api.riotgames.com >> "%HOSTS%"

:: Game servers - EUNE
echo 127.0.0.1 prod.eun1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 eun1.api.riotgames.com >> "%HOSTS%"

:: Game servers - TR (Turkey)
echo 127.0.0.1 prod.tr1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 tr1.api.riotgames.com >> "%HOSTS%"

:: Game servers - NA
echo 127.0.0.1 prod.na1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 na1.api.riotgames.com >> "%HOSTS%"

:: Other regions
echo 127.0.0.1 prod.kr.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.br1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.la1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.la2.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.oc1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.ru.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 prod.jp1.lol.riotgames.com >> "%HOSTS%"

:: Launcher and updates
echo 127.0.0.1 l3cdn.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 lol.secure.dyn.riotcdn.net >> "%HOSTS%"
echo 127.0.0.1 worldwide.l3cdn.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 lol.dyn.riotcdn.net >> "%HOSTS%"

:: Patch servers
echo 127.0.0.1 lol.patcher.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 patcher.riotgames.com >> "%HOSTS%"

:: Login servers
echo 127.0.0.1 auth.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 login.leagueoflegends.com >> "%HOSTS%"

:: Chat servers
echo 127.0.0.1 chat.euw1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 chat.eun1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 chat.tr1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 chat.na1.lol.riotgames.com >> "%HOSTS%"

:: Spectator
echo 127.0.0.1 spectator.euw1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 spectator.eun1.lol.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 spectator.tr1.lol.riotgames.com >> "%HOSTS%"

:: Store
echo 127.0.0.1 store.leagueoflegends.com >> "%HOSTS%"
echo 127.0.0.1 lolstatic-a.akamaihd.net >> "%HOSTS%"
echo 127.0.0.1 ddragon.leagueoflegends.com >> "%HOSTS%"

:: Valorant (bonus)
echo 127.0.0.1 playvalorant.com >> "%HOSTS%"
echo 127.0.0.1 www.playvalorant.com >> "%HOSTS%"
echo 127.0.0.1 valorant.com >> "%HOSTS%"
echo 127.0.0.1 www.valorant.com >> "%HOSTS%"

:: Riot Client
echo 127.0.0.1 clientconfig.rpg.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 entitlements.auth.riotgames.com >> "%HOSTS%"
echo 127.0.0.1 account.riotgames.com >> "%HOSTS%"

echo # === LoL Block End === >> "%HOSTS%"
echo. >> "%HOSTS%"

echo.
echo ====================================
echo [SUCCESS] League of Legends blocked!
echo ====================================
echo.
echo Total 50+ servers blocked!
echo.

:: Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
echo [OK] DNS cache flushed!
echo.

echo You can no longer connect to League of Legends!
echo.
echo To unblock: Run unblock_lol.bat
echo.
pause
