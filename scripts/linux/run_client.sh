#!/bin/env bash
set -e

if [ -z "$LOCALIP" ]; then
  echo "LOCALIP is not defined. Please set it to your IP address."
  exit 1
fi

if [ -z "$BOOTSPR" ]; then
  echo "BOOTSPR is not defined. Please set it to the bootstrap node SPR."
  exit 1
fi

if [ ! -f eth.key ]; then
  echo "eth.key does not exist. Please run generate.sh to create it."
  exit 1
fi

BOOTSPR=spr:CiUIAhIhA7dVYM0xcaXtsXiHmXWN1l2Irg_82sMFC6UochS0u7x2EgIDARo8CicAJQgCEiEDt1VgzTFxpe2xeIeZdY3WXYiuD_zawwULpShyFLS7vHYQ09LpswYaCwoJBMCoWP2RAh-aKkcwRQIhAK38tfXLaKKudMeJq9BEH-uMW0CxJ3lRdY0f1BfuKzZ9AiAwMLy5LijnR0qtne9KgVkjxCQWsqmv3meN9B5rd7yXSA

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
  --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA
