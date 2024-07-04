# Start script for bootstrap node on local network NUC

./codex-v0.1.3-linux-amd64 \
  --data-dir=data_bootstrap \
  --nat=192.168.88.253 \
  --api-port=8078 \
  --disc-port=8090 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  &

sleep 5

curl http://localhost:8078/api/codex/v1/debug/info > bootstrap.info

