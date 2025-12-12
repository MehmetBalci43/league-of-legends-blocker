@echo off
:: League of Legends Unblock - Batch Version
:: RIGHT-CLICK this file and select "Run as administrator"!

echo ====================================
echo League of Legends Unblock
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

echo Removing League of Legends block...
echo.

:: Hosts file path
set HOSTS=%SystemRoot%\System32\drivers\etc\hosts

:: Create backup
copy "%HOSTS%" "%HOSTS%.backup_%date:~-4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%" >nul 2>&1
echo [OK] Hosts file backed up!

:: Remove LoL blocks (improved - removes all LoL-related entries)
findstr /v /i /c:"# === LoL Block" /c:"League of Legends" /c:"riot.com" /c:"riotgames.com" /c:"leagueoflegends.com" /c:"lol.riotgames.com" /c:"lol.secure.dyn.riotcdn.net" /c:"lol.dyn.riotcdn.net" /c:"lolstatic-a.akamaihd.net" /c:"playvalorant.com" /c:"valorant.com" /c:"riotcdn" "%HOSTS%" > "%HOSTS%.tmp"
move /y "%HOSTS%.tmp" "%HOSTS%" >nul 2>&1

echo.
echo ====================================
echo [SUCCESS] Block removed!
echo ====================================
echo.

:: Flush DNS cache
echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
echo [OK] DNS cache flushed!
echo.

echo You can now connect to League of Legends again.
echo.
echo BUT DON'T! Stay strong! :)
echo.
pause
