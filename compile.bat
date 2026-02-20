@echo off
setlocal enabledelayedexpansion

REM Create bin directory if it doesn't exist
if not exist "backend\bin" mkdir backend\bin

REM Compile all Java files
javac -d backend\bin -cp backend\lib\*;. -sourcepath backend\src;ai-engine ^
       backend\src\com\skillgap\db\*.java ^
       backend\src\com\skillgap\model\*.java ^
       backend\src\com\skillgap\servlet\*.java ^
       backend\src\com\skillgap\util\*.java ^
       ai-engine\*.java

if %errorlevel% == 0 (
    echo Compilation successful!
) else (
    echo Compilation failed with error code %errorlevel%
    exit /b %errorlevel%
)
