#!/usr/bin/env bash
set -e

# Variables
key_file="eth.key"
address_file="eth.address"
url=https://key.codex.storage

# Generate remote
generate_remote() {
echo "Generating private key from remote <${url}>..."

response=$(curl -s ${url})
awk -F ': ' '/private/ {print $2}' <<<"${response}" >"${key_file}"
awk -F ': ' '/address/ {print $2}' <<<"${response}" >"${address_file}"

# Permissions
chmod 600 "${key_file}"

# Show
address=$(cat ${address_file})
echo " * your private key has been saved to ${PWD}/${key_file}"
echo " * your ethereum address has been saved to ${PWD}/${address_file}"
echo " * your ethereum address is ${address}"
}

# Use user provided private key
user_private_key() {
  # Create file with required permissions
  echo "${ETH_PRIVATE_KEY}" >"${key_file}"
  chmod 600 "${key_file}"

  echo "Using provided private key..."
  echo " * your private key has been saved to ${PWD}/${key_file}"
  echo " * please use your key address to get the tokens"
}

# Save keyrair
if [[ -z "${ETH_PRIVATE_KEY}" ]]; then
  generate_remote
else
  user_private_key
fi
