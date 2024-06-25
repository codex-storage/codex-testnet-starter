set BOOTSPR="spr:CiUIAhIhA7dVYM0xcaXtsXiHmXWN1l2Irg_82sMFC6UochS0u7x2EgIDARo8CicAJQgCEiEDt1VgzTFxpe2xeIeZdY3WXYiuD_zawwULpShyFLS7vHYQ09LpswYaCwoJBMCoWP2RAh-aKkcwRQIhAK38tfXLaKKudMeJq9BEH-uMW0CxJ3lRdY0f1BfuKzZ9AiAwMLy5LijnR0qtne9KgVkjxCQWsqmv3meN9B5rd7yXSA"

start /b codex-v0.1.0-windows-amd64.exe ^
  --data-dir=data_client ^
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

timeout 5

cls

curl http://localhost:8080/api/codex/v1/debug/info
