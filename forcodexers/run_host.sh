# Start script for storage node on local network NUC

BOOTSPR=$(curl http://localhost:8078/api/codex/v1/spr | cut -d '"' -f4)

# Quota = 11 GB
# Availability = 10 GB

./codex-prover-v0.1.3-linux-amd64 \
  --data-dir=data_host \
  --circuit-dir=circuit \
  --storage-quota=11811160064 \
  --nat=192.168.88.253 \
  --api-port=8180 \
  --disc-port=8190 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8170 \
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage \
  --marketplace-address=0x5Bd66fA15Eb0E546cd26808248867a572cFF5706 \
  prover \
  &

sleep 30

curl http://localhost:8180/api/codex/v1/debug/info

sleep 5

curl --request POST   --url http://localhost:8180/api/codex/v1/sales/availability   --header "Content-Type: application/json"   --data "{\"totalSize\": \"10737418240\",	\"duration\": \"86400\",	\"minPrice\": \"1\",	\"maxCollateral\": \"9999999999\"}"


