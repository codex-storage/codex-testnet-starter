@echo off
setlocal enabledelayedexpansion

:: Variables
set key_file="%cd%\eth.key"
set address_file="%cd%\eth.address"

:: Generate
echo Generating private key...

:: Use PowerShell to make the API call and process the response
powershell -Command "& { $response = Invoke-RestMethod -Uri 'https://key.codex.storage/json'; $privateKey = $response.private; $address = $response.address; $privateKey | Out-File -Encoding ASCII -FilePath '%key_file%'; $address | Out-File -Encoding ASCII -FilePath '%address_file%'; Write-Host ' * your private key has been saved to %key_file%'; Write-Host ' * your address has been saved to %address_file%'; Write-Host (' * your ethereum address is ' + $address); }"

:: Set file permissions to read-only for the current user
icacls %cd%\%key_file% /inheritance:r >nul 2>&1
icacls %cd%\%key_file% /grant:r %USERNAME%:F >nul 2>&1

exit /b 0
