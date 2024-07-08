#!/bin/bash
set -e

source ./utils.sh

if [ -z "$LOCALIP" ]; then
  LOCALIP=$(get_ip)
fi
echo "LOCAL IP: ${LOCALIP}"

if [ -z "$BOOTSPR" ]; then
  # Local network SPR (Workshop NUC):
  BOOTSPR="spr:CiUIAhIhAnBsex_7L5xKJQpmAuOtubQEtKsgCOXE2vaJoTJXrprbEgIDARo8CicAJQgCEiECcGx7H_svnEolCmYC4625tAS0qyAI5cTa9omhMleumtsQ6dCutAYaCwoJBMCoWP2RAh-aKkcwRQIhAI1d-q3yzFh2uuTuTkF7XCNUJ1yXNWqH7jLwssM3AZRLAiBK7UxQ1e0pg8ILFVih4Aix4y_87Q3cdxxEktfcNnVU-g"
  # Cloud-Node-01 SPR:
  # BOOTSPR="spr:CiUIAhIhAiJvIcA_ZwPZ9ugVKDbmqwhJZaig5zKyLiuaicRcCGqLEgIDARo8CicAJQgCEiECIm8hwD9nA9n26BUoNuarCEllqKDnMrIuK5qJxFwIaosQ3d6esAYaCwoJBJ_f8zKRAnU6KkYwRAIgM0MvWNJL296kJ9gWvfatfmVvT-A7O2s8Mxp8l9c8EW0CIC-h-H-jBVSgFjg3Eny2u33qF7BDnWFzo7fGfZ7_qc9P"
fi

if [ ! -f eth.key ]; then
  echo "eth.key does not exist. Please run generate.sh to create it."
  exit 1
fi

# Set variables
VERSION="v0.1.3"
OS=$(get_os)
ARCH=$(get_arch)
DATA_DIR="data_client"

mkdir -p ${DATA_DIR}
chmod 0700 ${DATA_DIR}

./codex-${VERSION}-${OS}-${ARCH} \
  --data-dir=${DATA_DIR} \
  --storage-quota=11811160064 \
  --nat=${LOCALIP} \
  --api-port=8080 \
  --disc-port=8090 \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage \
  --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA
