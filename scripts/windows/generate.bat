@echo off
setlocal enabledelayedexpansion

echo Generating private key...

:: Use PowerShell to make the API call and process the response
powershell -Command "& { $response = Invoke-RestMethod -Uri 'https://api.blockcypher.com/v1/eth/main/addrs' -Method Post; $privateKey = $response.private; $address = $response.address;  $privateKey | Out-File -Encoding ASCII -FilePath '.\eth.key'; $address | Out-File -Encoding ASCII -FilePath '.\eth.address'; Write-Host ' * your private key has been saved to %cd%\eth.key'; Write-Host ' * your address has been saved to %cd%\eth.address'; Write-Host (' * your ethereum address is 0x' + $address); }"

:: Set file permissions to read-only for the current user
icacls .\eth.key /inheritance:r
icacls .\eth.key /grant:r %USERNAME%:F

exit /b 0
