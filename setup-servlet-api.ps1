#!/usr/bin/env powershell
<#
.SYNOPSIS
    Setup Servlet API configuration for VS Code Tomcat 9
.DESCRIPTION
    This script copies necessary JARs from Tomcat 9 installation to the project's backend/lib directory
.EXAMPLE
    .\setup-servlet-api.ps1
#>

param(
    [string]$TomcatPath = ""
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Servlet API VS Code Setup Script" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# If Tomcat path not provided as parameter, ask user
if (-not $TomcatPath) {
    $TomcatPath = Read-Host "Enter your Tomcat 9 installation path (e.g., C:\Program Files\Apache Tomcat 9.0)"
}

# Validate Tomcat path
if (-not (Test-Path $TomcatPath)) {
    Write-Host "`n❌ ERROR: Tomcat path not found: $TomcatPath" -ForegroundColor Red
    Write-Host "Please verify the path and try again.`n" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path "$TomcatPath\lib")) {
    Write-Host "`n❌ ERROR: Tomcat lib directory not found: $TomcatPath\lib" -ForegroundColor Red
    Write-Host "This doesn't look like a valid Tomcat installation.`n" -ForegroundColor Yellow
    exit 1
}

# Get project directory
$projectRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
$libDir = Join-Path $projectRoot "backend\lib"

Write-Host "Tomcat path: $TomcatPath" -ForegroundColor Green
Write-Host "Project lib directory: $libDir`n" -ForegroundColor Green

# Create lib directory if it doesn't exist
if (-not (Test-Path $libDir)) {
    New-Item -Path $libDir -ItemType Directory -Force | Out-Null
    Write-Host "Created $libDir`n"
}

# Define JARs to copy
$jarsTocopy = @(
    "servlet-api.jar",
    "jsp-api.jar",
    "el-api.jar",
    "catalina.jar",
    "catalina-util.jar"
)

Write-Host "Copying JAR files from Tomcat lib...`n" -ForegroundColor Cyan

$copiedCount = 0
$skippedCount = 0

foreach ($jar in $jarsTocopy) {
    $sourceJar = Join-Path $TomcatPath "lib\$jar"
    $destJar = Join-Path $libDir $jar
    
    if (Test-Path $sourceJar) {
        try {
            Copy-Item -Path $sourceJar -Destination $destJar -Force -ErrorAction Stop
            Write-Host "[✓] $jar" -ForegroundColor Green
            $copiedCount++
        } catch {
            Write-Host "[✗] $jar - Error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "[⊗] $jar (not found in Tomcat lib)" -ForegroundColor Yellow
        $skippedCount++
    }
}

# List copied files
Write-Host "`nVerifying JAR files in backend/lib:`n" -ForegroundColor Cyan
Get-ChildItem "$libDir\*.jar" | ForEach-Object {
    Write-Host "  ✓ $($_.Name)" -ForegroundColor Green
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
if ($copiedCount -gt 0 -and $skippedCount -eq 0) {
    Write-Host "[SUCCESS] Setup completed!" -ForegroundColor Green
    Write-Host "All JAR files copied successfully." -ForegroundColor Green
} elseif ($copiedCount -gt 0) {
    Write-Host "[SUCCESS] Setup completed!" -ForegroundColor Green
    Write-Host "Copied $copiedCount JAR files. Skipped $skippedCount (not in Tomcat lib)." -ForegroundColor Yellow
} else {
    Write-Host "[WARNING] No JAR files were copied" -ForegroundColor Yellow
    Write-Host "Please verify your Tomcat installation path." -ForegroundColor Yellow
}
Write-Host "========================================`n" -ForegroundColor Cyan

# Next steps
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Reload VS Code (Ctrl+Shift+P > Reload Window)" -ForegroundColor White
Write-Host "  2. Test compilation (Ctrl+Shift+B > Compile Java Project)" -ForegroundColor White
Write-Host "  3. Verify servlet imports are recognized" -ForegroundColor White
Write-Host "  4. Deploy compiled classes to Tomcat webapps" -ForegroundColor White
Write-Host "`n"

# Offer to open project in VS Code
$openVSCode = Read-Host "Open project in VS Code? (y/n)" 

if ($openVSCode -eq 'y' -or $openVSCode -eq 'Y') {
    code $projectRoot
}
