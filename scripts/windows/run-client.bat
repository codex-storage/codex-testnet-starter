@echo off
setlocal enabledelayedexpansion

call utils.bat

if not defined LOCALIP (
    call :get_ip LOCALIP
)
echo LOCAL IP: %LOCALIP%

if not defined BOOTSPR (
    set "BOOTSPR=spr:CiUIAhIhA4bDuZcAmHjxteBfi1fMZ3XQbhIAkAoFJDj6VK9xmDQoEgIDARo8CicAJQgCEiEDhsO5lwCYePG14F-LV8xnddBuEgCQCgUkOPpUr3GYNCgQsrCJtAYaCwoJBMCoWP2RAh-aKkcwRQIhAIYaV9SBGR1Z0Q9lblZn70f4G5mL1089WEee-g_o-LZTAiAlVPiPtFN3WfH6WcqH2c-NWEGHV7y-8xsZdmy7y_gTlw"
)

if not exist eth.key (
    echo eth.key does not exist. Please run generate.bat to create it.
    exit /b 1
)

:: Set variables
set "VERSION=v0.1.3"
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
    --bootstrap-node=%BOOTSPR% ^
    persistence ^
    --eth-private-key=eth.key ^
    --eth-provider=https://rpc.testnet.codex.storage ^
    --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA

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

:get_ip
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
        set "%1=%%a"
        set "%1=!%1: =!"
        goto :break
    )
    :break
exit /b
