set LOCALIP="192.168.178.138"
set BOOTSPR="UPDATE ME FROM BOOTSTRAP NODE"

@REM Quota = 11 GB
@REM Availability = 10 GB

start /b codex-v0.1.0-prover-windows-amd64.exe ^
  --data-dir=data_host ^
  --circuit-dir=circuit ^
  --storage-quota=11811160064 ^
  --nat=%LOCALIP% ^
  --api-port=8180 ^
  --disc-port=8190 ^
  --listen-addrs=/ip4/0.0.0.0/tcp/8170 ^
  --bootstrap-node=%BOOTSPR% ^
  persistence ^
  --eth-private-key=eth.key ^
  --eth-provider=https://rpc.testnet.codex.storage ^
  --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA ^
  prover

timeout 30

cls

curl http://localhost:8180/api/codex/v1/debug/info

timeout 5

curl --request POST   --url http://localhost:8180/api/codex/v1/sales/availability   --header "Content-Type: application/json"   --data "{\"totalSize\": \"10737418240\",	\"duration\": \"86400\",	\"minPrice\": \"1\",	\"maxCollateral\": \"9999999999\"}"
