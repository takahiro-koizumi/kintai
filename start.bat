@echo off
chcp 65001 > nul
cd /d "%~dp0"
title 勤怠管理 サーバ (localhost)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0serve.ps1"
pause
