@echo off
setlocal enabledelayedexpansion

:: Variables
if not defined NETWORK set NETWORK=testnet

:: Check if LOCALIP is provided as an argument
if "%1" neq "" (
    set "LOCALIP=%1"
) else if not defined LOCALIP (
    if %NETWORK% == workshop (
        call :get_ip LOCALIP
    ) else (
        call :get_ip_public LOCALIP
    )
)
echo LOCAL IP: %LOCALIP%

if not defined BOOTSPR (
    if %NETWORK% == workshop (
        :: workshop
        set BOOTSPR="spr:CiUIAhIhAnBsex_7L5xKJQpmAuOtubQEtKsgCOXE2vaJoTJXrprbEgIDARo8CicAJQgCEiECcGx7H_svnEolCmYC4625tAS0qyAI5cTa9omhMleumtsQnbm0tAYaCwoJBMCoWP2RAh-aKkcwRQIhANjwAV9DGFe4zcMUEHjuTsGWAPc7WB7uoSS86HATwouqAiA8dFhsALCSLsQbSOPF1j7NF643oEmPEJAwU9dIwjM6TA"
    ) else if %NETWORK% == testnet (
        :: testnet
        set BOOTSPR="spr:CiUIAhIhAiJvIcA_ZwPZ9ugVKDbmqwhJZaig5zKyLiuaicRcCGqLEgIDARo8CicAJQgCEiECIm8hwD9nA9n26BUoNuarCEllqKDnMrIuK5qJxFwIaosQ3d6esAYaCwoJBJ_f8zKRAnU6KkYwRAIgM0MvWNJL296kJ9gWvfatfmVvT-A7O2s8Mxp8l9c8EW0CIC-h-H-jBVSgFjg3Eny2u33qF7BDnWFzo7fGfZ7_qc9P"
    )
)

if not exist eth.key (
    echo eth.key does not exist. Please run generate.bat to create it.
    exit /b 1
)

:: Set proper permissions for eth.key
echo Setting proper permissions for eth.key...
icacls eth.key /reset
icacls eth.key /inheritance:r
icacls eth.key /grant:r %USERNAME%:(R,F)
icacls eth.key /remove "Authenticated Users" "BUILTIN\Users"
icacls eth.key
if errorlevel 1 (
    echo Failed to set permissions for eth.key. Please run this script as administrator.
    exit /b 1
)

:: Set variables
set "VERSION=v0.1.8"
set "OS=windows"
call :get_arch ARCH
set "DATA_DIR=data_client"

if not exist %DATA_DIR% mkdir %DATA_DIR%
icacls %DATA_DIR% /inheritance:r
icacls %DATA_DIR% /grant:r %USERNAME%:(OI)(CI)F

codex-%VERSION%-%OS%-%ARCH%.exe ^
    --data-dir=%DATA_DIR% ^
    --storage-quota=11811160064 ^
    --nat=%LOCALIP% ^
    --api-port=8080 ^
    --disc-port=8090 ^
    --listen-addrs=/ip4/0.0.0.0/tcp/8070 ^
    --api-cors-origin="*" ^
    --block-ttl=30d ^
    --bootstrap-node=%BOOTSPR% ^
    persistence ^
    --eth-private-key=eth.key ^
    --eth-provider=https://rpc.testnet.codex.storage

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

:: Function to get IP
:get_ip
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
        set "%1=%%a"
        set "%1=!%1: =!"
        goto :break
    )
    :break
exit /b

:: Function to get Public IP using ip lookup service
:get_ip_public
    for /f "tokens=1" %%a in ('curl -m 5 -s --ssl-reqd ip.codex.storage') do set "%1=%%a"
exit /b
