@echo off
REM Civic Issues Reporting and Resolution System - Quick Start Script
REM Run this file to start the application automatically

title Civic Issues Reporting and Resolution System - Starting...
color 0A

echo.
echo ================================================
echo  Civic Issues Reporting and Resolution System
echo ================================================
echo.

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

REM Check if virtual environment exists
if not exist "backend\venv\" (
    echo [1/3] Creating Virtual Environment...
    python -m venv backend\venv
) else (
    echo [1/3] Virtual Environment found (skipping)
)

echo.
echo [2/3] Installing Dependencies...
call backend\venv\Scripts\activate.bat
pip install -q -r backend\requirements.txt

echo.
echo [3/3] Initializing Database...
pushd backend
python init_db.py
popd

echo.
echo ================================================
echo  Starting Application...
echo ================================================
echo.
echo Opening browser... (Press Ctrl+C in terminal to stop server)
echo.
timeout /t 2 /nobreak

REM Open browser
start http://localhost:5000

REM Start Flask application
pushd backend
python app.py
popd

pause
