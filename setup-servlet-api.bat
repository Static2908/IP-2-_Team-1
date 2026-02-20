@echo off
REM Setup Servlet API configuration for VS Code
REM This script copies necessary JARs from Tomcat 9 to the project lib directory

setlocal enabledelayedexpansion

echo.
echo ========================================
echo Servlet API VS Code Setup Script
echo ========================================
echo.

REM Ask user for Tomcat installation path
set /p tomcat_path="Enter your Tomcat 9 installation path (e.g., C:\Program Files\Apache Tomcat 9.0): "

if not exist "%tomcat_path%" (
    echo.
    echo ERROR: Tomcat path not found: %tomcat_path%
    echo Please verify the path and try again.
    pause
    exit /b 1
)

if not exist "%tomcat_path%\lib" (
    echo.
    echo ERROR: Tomcat lib directory not found: %tomcat_path%\lib
    echo This doesn't look like a valid Tomcat installation.
    pause
    exit /b 1
)

REM Get project directory
set "project_dir=%~dp0"
set "lib_dir=%project_dir%backend\lib"

echo.
echo Tomcat path: %tomcat_path%
echo Project lib directory: %lib_dir%
echo.

REM Create lib directory if it doesn't exist
if not exist "%lib_dir%" (
    mkdir "%lib_dir%"
    echo Created %lib_dir%
)

REM Copy essential JAR files
echo.
echo Copying JAR files from Tomcat lib...
echo.

set error=0

if exist "%tomcat_path%\lib\servlet-api.jar" (
    copy /Y "%tomcat_path%\lib\servlet-api.jar" "%lib_dir%\"
    if !errorlevel! equ 0 (
        echo [OK] servlet-api.jar
    ) else (
        echo [FAIL] servlet-api.jar
        set error=1
    )
) else (
    echo [SKIP] servlet-api.jar (not found)
)

if exist "%tomcat_path%\lib\jsp-api.jar" (
    copy /Y "%tomcat_path%\lib\jsp-api.jar" "%lib_dir%\"
    if !errorlevel! equ 0 (
        echo [OK] jsp-api.jar
    ) else (
        echo [FAIL] jsp-api.jar
        set error=1
    )
) else (
    echo [SKIP] jsp-api.jar (not found)
)

if exist "%tomcat_path%\lib\el-api.jar" (
    copy /Y "%tomcat_path%\lib\el-api.jar" "%lib_dir%\"
    if !errorlevel! equ 0 (
        echo [OK] el-api.jar
    ) else (
        echo [FAIL] el-api.jar
        set error=1
    )
) else (
    echo [SKIP] el-api.jar (not found)
)

if exist "%tomcat_path%\lib\catalina.jar" (
    copy /Y "%tomcat_path%\lib\catalina.jar" "%lib_dir%\"
    if !errorlevel! equ 0 (
        echo [OK] catalina.jar
    ) else (
        echo [FAIL] catalina.jar
        set error=1
    )
) else (
    echo [SKIP] catalina.jar (not found)
)

if exist "%tomcat_path%\lib\catalina-util.jar" (
    copy /Y "%tomcat_path%\lib\catalina-util.jar" "%lib_dir%\"
    if !errorlevel! equ 0 (
        echo [OK] catalina-util.jar
    ) else (
        echo [FAIL] catalina-util.jar
        set error=1
    )
) else (
    echo [SKIP] catalina-util.jar (not found)
)

echo.
echo Verifying JAR files...
echo.

dir "%lib_dir%\*.jar"

echo.
if !error! equ 0 (
    echo ========================================
    echo [SUCCESS] Setup completed!
    echo ========================================
    echo.
    echo Next steps:
    echo 1. Reload VS Code (Ctrl+Shift+P ^> Reload Window)
    echo 2. Test compilation (Ctrl+Shift+B)
    echo 3. Try importing javax.servlet.* 
    echo.
) else (
    echo ========================================
    echo [WARNING] Setup completed with errors
    echo ========================================
    echo.
    echo Some JARs could not be copied.
    echo Check the paths and try again.
    echo.
)

pause
