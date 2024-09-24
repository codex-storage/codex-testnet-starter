#!/bin/bash
set -e

# Set variables
DATA_DIR="data_client"
ETHKEY="eth.key"
BOOTSPR="spr:CiUIAhIhA7E4DEMer8nUOIUSaNPA4z6x0n9Xaknd28Cfw9S2-cCeEgIDARo8CicAJQgCEiEDsTgMQx6vydQ4hRJo08DjPrHSf1dqSd3bwJ_D1Lb5wJ4Qt_CesAYaCwoJBEDhWZORAnVYKkYwRAIgFNzhnftocLlVHJl1onuhbSUM7MysXPV6dawHAA0DZNsCIDRVu9gnPTH5UkcRXLtt7MLHCo4-DL-RCMyTcMxYBXL0"
PUBLICIP=1.2.3.4

mkdir -p ${DATA_DIR}
chmod 0700 ${DATA_DIR}

./codex \
  --data-dir=${DATA_DIR} \
  --storage-quota=11811160064 \
  --nat=${PUBLICIP} \
  --api-port=8080 \
  --disc-port=8090 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=${ETHKEY} \
  --eth-provider=https://rpc.testnet.codex.storage
