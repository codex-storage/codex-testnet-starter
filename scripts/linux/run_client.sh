LOCALIP=192.168.178.138
BOOTSPR=spr:CiUIAhIhAteA6IVIcN3egB_1rPz3HpFKVVO4emfRRcRzvyf0ES11EgIDARo8CicAJQgCEiEC14DohUhw3d6AH_Ws_PcekUpVU7h6Z9FFxHO_J_QRLXUQlcfKswYaCwoJBMCosquRAh-aKkcwRQIhAPzHOsoFmh96SeuFPzErNeck9C-vOkWp74HpddLmM4zLAiBwvbCZDaeMRkmVRVxh24J8OEGGuHFUTWPHAL8T7e8GyQ

./codex-v0.1.0-linux-amd64 \
  --data-dir=data_bootstrap \
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
