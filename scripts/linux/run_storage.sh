LOCALIP=192.168.178.138
BOOTSPR="spr:CiUIAhIhA7hDRTkU9Pb_Wt4qdoN_IsRGuDL6bucyvMqbE3F7UmFREgIDARo8CicAJQgCEiEDuENFORT09v9a3ip2g38ixEa4Mvpu5zK8ypsTcXtSYVEQ1uHFswYaCwoJBMCosoqRAh-aKkcwRQIhAKdz-V1ne8GB-QlUmXnA4_EO1WIisy6PPBJDzRRLn02UAiB4QmAVgBgJ94OxnrTo7c_zgsjDJXL_E0_KlBb2KaFzPw"

# Quota = 11 GB
# Availability = 10 GB

./codex-v0.1.0-prover-linux-amd64 \
  --data-dir=data_storage \
  --circuit-dir=circuit \
  --storage-quota=11811160064 \
  --nat=${LOCALIP} \
  --api-port=8180 \
  --disc-port=8190 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8170 \
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage \
  --marketplace-address=0x4cBDfab37baB0AA3AC69A7b12C4396907dfF5227 \
  prover \
  &

sleep 30

curl http://localhost:8180/api/codex/v1/debug/info

sleep 5

curl --request POST   --url http://localhost:8180/api/codex/v1/sales/availability   --header "Content-Type: application/json"   --data "{\"totalSize\": \"10737418240\",	\"duration\": \"86400\",	\"minPrice\": \"1\",	\"maxCollateral\": \"9999999999\"}"


