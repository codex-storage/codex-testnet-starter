@echo off
setlocal enabledelayedexpansion

call utils.bat

:: Set variables
set "OS=windows"
call :get_arch ARCH
set "ARCHIVE_EXT=.zip"
set "EXE_EXT=.exe"
set "VERSION=v0.1.3"
set "BASE_URL=http://192.168.88.253:8080"
set "EXTRACT_DIR=.\"
set "BINARY_NAMES=codex"

:: Download, verify, and extract each binary
for %%B in (%BINARY_NAMES%) do (
    set "FILE_NAME=%%B-%VERSION%-%OS%-%ARCH%%ARCHIVE_EXT%"
    set "DOWNLOAD_URL=%BASE_URL%/!FILE_NAME!"
    set "CHECKSUM_URL=%BASE_URL%/!FILE_NAME!.sha256"

    echo Downloading !FILE_NAME!...
    powershell -Command "& {Invoke-WebRequest -Uri '!DOWNLOAD_URL!' -OutFile '!FILE_NAME!'}"
    if errorlevel 1 (
        echo Download failed for !FILE_NAME!
        echo Try download-online.bat instead
        exit /b 1
    )

    echo Downloading SHA256 checksum for !FILE_NAME!...
    powershell -Command "& {Invoke-WebRequest -Uri '!CHECKSUM_URL!' -OutFile '!FILE_NAME!.sha256'}"
    if errorlevel 1 (
        echo Checksum download failed for !FILE_NAME!
        echo Try download-online.bat instead
        exit /b 1
    )

    echo Verifying checksum for !FILE_NAME!...
    for /f "tokens=1" %%a in (!FILE_NAME!.sha256) do set "EXPECTED_SHA256=%%a"
    for /f "tokens=* usebackq" %%a in (`powershell -Command "& {Get-FileHash '!FILE_NAME!' -Algorithm SHA256 | Select-Object -ExpandProperty Hash}"`) do set "ACTUAL_SHA256=%%a"

    if /I not "!ACTUAL_SHA256!" == "!EXPECTED_SHA256!" (
        echo Checksum verification failed for !FILE_NAME!. Expected: !EXPECTED_SHA256!, Got: !ACTUAL_SHA256!
        exit /b 1
    )

    echo Extracting !FILE_NAME!...
    powershell -Command "& {Expand-Archive -Path '!FILE_NAME!' -DestinationPath '!EXTRACT_DIR!' -Force}"
    if errorlevel 1 (
        echo Extraction failed for !FILE_NAME!
        exit /b 1
    )

    :: Cleanup
    del !FILE_NAME!
    del !FILE_NAME!.sha256
)

echo Setup completed successfully!
exit /b 0

:get_arch
    set "arch_result=unknown"
    for /f "tokens=2 delims=:" %%a in ('systeminfo ^| find "System Type"') do (
        echo %%a | find "x64" > nul
        if not errorlevel 1 set "arch_result=amd64"
        echo %%a | find "ARM" > nul
        if not errorlevel 1 set "arch_result=arm64"
    )
    set "%1=%arch_result%"
exit /b
