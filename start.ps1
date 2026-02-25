# Civic Issues Reporting and Resolution System - Quick Start Script
# Run this script to start the application automatically

# Use the script's own directory as the base path
$BaseDir = $PSScriptRoot
if (!$BaseDir) { $BaseDir = "." }

Write-Host "================================================" -ForegroundColor Green
Write-Host "  Civic Issues Reporting and Resolution System" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Step 1: Create virtual environment if it doesn't exist
if (!(Test-Path "$BaseDir\backend\venv")) {
    Write-Host "[1/3] Creating Virtual Environment..." -ForegroundColor Cyan
    python -m venv "$BaseDir\backend\venv"
}
else {
    Write-Host "[1/3] Virtual Environment found (skipping)" -ForegroundColor Cyan
}

Write-Host ""

# Step 2: Activate virtual environment and install dependencies
Write-Host "[2/3] Installing Dependencies..." -ForegroundColor Cyan
& "$BaseDir\backend\venv\Scripts\Activate.ps1"
pip install -q -r "$BaseDir\backend\requirements.txt"

Write-Host ""

# Step 3: Initialize database
Write-Host "[3/3] Initializing Database..." -ForegroundColor Cyan
Set-Location "$BaseDir\backend"
python init_db.py

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "  Starting Application..." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Application will open at: http://localhost:5000" -ForegroundColor Yellow
Write-Host "Press Ctrl+C in terminal to stop the server" -ForegroundColor Yellow
Write-Host ""

# Open browser after 2 seconds
Start-Sleep -Seconds 2
Start-Process "http://localhost:5000"

# Start Flask application
python app.py
Set-Location "$BaseDir"
