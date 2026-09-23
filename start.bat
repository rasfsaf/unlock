@echo off
chcp 65001 >nul
title Antigravity Unlocker

:: Переходим в каталог расположения скрипта
cd /d "%~dp0"

:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [INFO] Запуск требует прав администратора для сетевого патча.
    echo [INFO] Запрос прав UAC...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Проверка наличия исполняемого файла
if exist "bin\AG_2.5.0.exe" (
    "bin\AG_2.5.0.exe"
) else if exist "release\AG_2.5.0.exe" (
    "release\AG_2.5.0.exe"
) else (
    echo [ОШИБКА] Исполняемый файл не найден в папке bin!
    pause
    exit /b 1
)

exit /b 0
