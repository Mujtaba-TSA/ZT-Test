@echo off
setlocal
cd /d "%~dp0"

REM =====================================================================
REM  EDIT THE THREE LINES BELOW, then save and double-click this file.
REM  Get a read-only key at:
REM    WooCommerce > Settings > Advanced > REST API > Add key (Read)
REM =====================================================================
set "STORE_URL=https://zerotech.com.au"
set "WC_KEY=ck_PASTE_YOUR_KEY_HERE"
set "WC_SECRET=cs_PASTE_YOUR_SECRET_HERE"
REM =====================================================================

where node >nul 2>nul
if errorlevel 1 (
  echo.
  echo Node.js is not installed. Get the "LTS" installer from https://nodejs.org
  echo run it clicking Next through the defaults, then double-click this file again.
  echo.
  pause
  exit /b 1
)

node scripts\fetch-skus.mjs
echo.
echo ---------------------------------------------------------------
echo If it finished OK, look for skus.csv and skus.md in this folder.
echo ---------------------------------------------------------------
pause
