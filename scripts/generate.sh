#!/usr/bin/env bash
set -e

echo "Generating private key..."

response=$(curl -sX POST https://api.blockcypher.com/v1/eth/main/addrs)
echo -n "${response}" | grep -o '"private":.*"' | cut -d'"' -f4 > ./eth.key
echo -n "${response}" | grep -o '"address":.*"' | cut -d'"' -f4 > ./eth.address
chmod 600 ./eth.key

echo " * your private key has been saved to ${PWD}/eth.key"
echo " * your ethereum address has been saved to ${PWD}/eth.address"
echo " * your ethereum address is 0x${address}"
