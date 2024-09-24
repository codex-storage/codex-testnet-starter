#!/bin/bash
set -e

source ./utils.sh

if [ -z "$LOCALIP" ]; then
  LOCALIP=$(get_ip)
fi
echo "LOCAL IP: ${LOCALIP}"

if [ -z "$BOOTSPR" ]; then
  # Local network SPR (Workshop NUC):
  BOOTSPR="spr:CiUIAhIhAnBsex_7L5xKJQpmAuOtubQEtKsgCOXE2vaJoTJXrprbEgIDARo8CicAJQgCEiECcGx7H_svnEolCmYC4625tAS0qyAI5cTa9omhMleumtsQnbm0tAYaCwoJBMCoWP2RAh-aKkcwRQIhANjwAV9DGFe4zcMUEHjuTsGWAPc7WB7uoSS86HATwouqAiA8dFhsALCSLsQbSOPF1j7NF643oEmPEJAwU9dIwjM6TA"
  # Cloud-Node-01 SPR:
  # BOOTSPR="spr:CiUIAhIhAiJvIcA_ZwPZ9ugVKDbmqwhJZaig5zKyLiuaicRcCGqLEgIDARo8CicAJQgCEiECIm8hwD9nA9n26BUoNuarCEllqKDnMrIuK5qJxFwIaosQ3d6esAYaCwoJBJ_f8zKRAnU6KkYwRAIgM0MvWNJL296kJ9gWvfatfmVvT-A7O2s8Mxp8l9c8EW0CIC-h-H-jBVSgFjg3Eny2u33qF7BDnWFzo7fGfZ7_qc9P"
fi

if [ ! -f eth.key ]; then
  echo "eth.key does not exist. Please run generate.sh to create it."
  exit 1
fi

# Set variables
VERSION="v0.1.4"
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
  --eth-provider=https://rpc.testnet.codex.storage
