@echo off
chcp 65001 > nul
title 勤怠管理 サーバ (LAN/iPad対応)

REM 管理者権限で再実行
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 管理者権限で再起動します...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serve.ps1"
pause
