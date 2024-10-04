@echo off

:: Variables
if not defined NETWORK set NETWORK=testnet

:: Function to detect OS
:get_os
    echo windows
exit /b

:: Function to detect CPU architecture
:get_arch
    set "arch_result=unknown"
    for /f "tokens=2 delims=:" %%a in ('systeminfo ^| find "System Type"') do (
        echo %%a | find "x64" > nul
        if not errorlevel 1 set "arch_result=amd64"
        echo %%a | find "ARM" > nul
        if not errorlevel 1 set "arch_result=arm64"
    )
    if "%arch_result%"=="unknown" (
        echo Unsupported architecture: %PROCESSOR_ARCHITECTURE%
        exit /b 1
    )
    set "%1=%arch_result%"
exit /b

:: Function to get IP
:get_ip
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
        set "%1=%%a"
        set "%1=!%1: =!"
        goto :break
    )
    :break
exit /b
