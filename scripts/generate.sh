#!/usr/bin/env bash
set -e

echo "Generating private key..."

response=$(curl -sX POST https://api.blockcypher.com/v1/eth/main/addrs)
echo -n "${response}" | grep -o '"private":.*"' | cut -d'"' -f4 > ./eth.key
address=$(echo -n "${response}" | grep -o '"address":.*"' | cut -d'"' -f4)
chmod 600 ./eth.key

echo " * your private key has been saved to ${PWD}/eth.key"
echo " * your ethereum address is 0x${address}"
