#!/usr/bin/env bash
set -e

echo "Generating private key."

response=$(curl -sX POST https://api.blockcypher.com/v1/eth/main/addrs)
echo -n "${response}" | sed -n 's/^\s*"private": *"\(.*\)",$/\1/p' > ./eth.key
address=$(echo -n "${response}" | sed -n 's/^\s*"address": *"\(.*\)"$/0x\1/p')
chmod 600 ./eth.key

echo " * your private key has been saved to ${PWD}/eth.key"
echo " * your ethereum address is ${address}"
