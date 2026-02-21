@echo off
setlocal enabledelayedexpansion

REM Create bin directory if it doesn't exist
if not exist "backend\bin" mkdir backend\bin

REM Compile all Java files (collect sources recursively from backend/src and ai-engine)
set "SRC_LIST=%~dp0backend_sources.txt"
if exist "%SRC_LIST%" del /f /q "%SRC_LIST%"

for /R "backend\src" %%f in (*.java) do (
    echo %%f>> "%SRC_LIST%"
)
for /R "ai-engine" %%f in (*.java) do (
    echo %%f>> "%SRC_LIST%"
)

if not exist "%SRC_LIST%" (
    echo No Java source files found under backend\src or ai-engine
    exit /b 1
)

javac -d backend\bin -cp "backend\\lib\\*;." @"%SRC_LIST%"

if %errorlevel% == 0 (
    echo Compilation successful!
) else (
    echo Compilation failed with error code %errorlevel%
    exit /b %errorlevel%
)
