#!/usr/bin/env bash
set -e

# Variables
key_file="eth.key"
address_file="eth.address"

# Generate
echo "Generating private key..."

response=$(curl -s https://key.codex.storage)
awk -F ': ' '/private/ {print $2}' <<<"${response}" >"${key_file}"
awk -F ': ' '/address/ {print $2}' <<<"${response}" >"${address_file}"

# Permissions
chmod 600 "${key_file}"

# Show
address=$(cat ${address_file})
echo " * your private key has been saved to ${PWD}/${key_file}"
echo " * your ethereum address has been saved to ${PWD}/${address_file}"
echo " * your ethereum address is ${address}"
