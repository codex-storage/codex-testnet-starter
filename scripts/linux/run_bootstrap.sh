LOCALIP="192.168.178.138"

./codex-v0.1.0-linux-amd64 \
  --data-dir=data_bootstrap \
  --nat=${LOCALIP} \
  --api-port=8080 \
  --disc-port=8090 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  &

sleep 5

curl http://localhost:8080/api/codex/v1/debug/info
