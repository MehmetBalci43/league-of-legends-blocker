@echo off
:: LoL Block Status Checker - Batch Version
:: This script checks if LoL is currently blocked
:: NO ADMIN RIGHTS NEEDED!

echo ===================================
echo LoL Block Status Checker
echo ===================================
echo.

:: Hosts file path
set HOSTS=%SystemRoot%\System32\drivers\etc\hosts

:: Check if hosts file exists
if not exist "%HOSTS%" (
    echo [ERROR] Hosts file not found!
    echo.
    pause
    exit /b 1
)

echo Checking hosts file for LoL blocks...
echo.

:: Count blocked entries
set BLOCKED_COUNT=0

:: Check for LoL-related entries
findstr /i /c:"riot.com" /c:"riotgames.com" /c:"leagueoflegends.com" /c:"lol.riotgames.com" /c:"lol.secure.dyn.riotcdn.net" /c:"lol.dyn.riotcdn.net" /c:"lolstatic-a.akamaihd.net" /c:"valorant" /c:"riotcdn" "%HOSTS%" > nul 2>&1

if %errorLevel% equ 0 (
    echo ===================================
    echo [BLOCKED] LoL IS BLOCKED
    echo ===================================
    echo.
    echo Found LoL-related entries in hosts file.
    echo.
    echo Blocked entries:
    echo ----------------
    findstr /i /c:"riot.com" /c:"riotgames.com" /c:"leagueoflegends.com" /c:"lol.riotgames.com" /c:"lol.secure.dyn.riotcdn.net" /c:"lol.dyn.riotcdn.net" /c:"lolstatic-a.akamaihd.net" /c:"valorant" /c:"riotcdn" "%HOSTS%"
    echo.
    echo ===================================
    echo.
    echo To unblock, run: unblock_lol.bat
    echo ^(Right-click and "Run as administrator"^)
) else (
    echo ===================================
    echo [OK] LoL is NOT blocked
    echo ===================================
    echo.
    echo You can connect to League of Legends.
    echo.
    echo To block, run: block_lol.bat
    echo ^(Right-click and "Run as administrator"^)
)

echo.
echo ===================================
echo.
echo To view full hosts file:
echo   notepad %HOSTS%
echo.
pause
