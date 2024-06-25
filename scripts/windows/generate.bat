@echo off
setlocal enabledelayedexpansion

echo Generating private key...

:: Use PowerShell to make the API call and process the response
powershell -Command "& {
    $response = Invoke-RestMethod -Uri 'https://api.blockcypher.com/v1/eth/main/addrs' -Method Post
    $privateKey = $response.private
    $address = $response.address
    $privateKey | Out-File -FilePath '.\eth.key' -NoNewline
    Write-Host ' * your private key has been saved to %cd%\eth.key'
    Write-Host (' * your ethereum address is 0x' + $address)
}"

:: Set file permissions to read-only for the current user
icacls .\eth.key /inheritance:r
icacls .\eth.key /grant:r %USERNAME%:R

exit /b 0
