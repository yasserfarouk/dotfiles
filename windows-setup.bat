@echo off
REM Windows Setup Bootstrap Script
REM This script runs the PowerShell setup script with proper execution policy

echo ========================================
echo Windows Development Environment Setup
echo ========================================
echo.
echo This script will install development tools using Scoop, winget, and other package managers.
echo.
echo Press Ctrl+C to cancel, or
pause

REM Check if running as Administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as Administrator
) else (
    echo WARNING: Not running as Administrator
    echo Some installations may require administrator privileges
    echo.
)

REM Run the PowerShell script with appropriate execution policy
powershell -ExecutionPolicy Bypass -File "%~dp0windows-setup.ps1"

echo.
echo Setup script completed!
pause
