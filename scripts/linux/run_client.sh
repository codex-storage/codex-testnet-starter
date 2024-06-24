BOOTSPR=UPDATE ME

./codex-v0.1.0-linux-amd64 \
  --data-dir=data_client \
  --storage-quota=11811160064 \
  --nat=${LOCALIP} \
  --api-port=8080 \
  --disc-port=8090 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage \
  --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA \
  &

sleep 5

curl http://localhost:8180/api/codex/v1/debug/info
