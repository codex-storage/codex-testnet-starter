# Codex Testnet Starter
Hit the ground running with Codex.

## Overview
![Overview](/docs/overview.png)
Using the Testnet Starter, you can run a (mostly preconfigured) Codex node on your machine. You always have the option to build and run Codex from sources [Here](https://github.com/codex-storage/nim-codex/).

1. [How to start](#how-to-start)
1. [How to get ready](#how-to-get-ready)
1. [How to use](#how-to-use)
1. [How to stop](#how-to-stop)
1. [How to stop and delete everything](#how-to-stop-and-delete-everything)
1. [Troubleshooting](#troubleshooting)


## [How to start](#codex-testnet-starter)
- Create a public/private key pair.
- Have Docker installed.
- Have Discord installed.
- Clone this repo.
- Define variables:
  ```shell
  export PRIV_KEY=9721fb80cf32275ce80ae41927130adc767d435dbb1d80114dac2ef2d7c951f0

  # export CODEX_ETH_PROVIDER=https://rpc.testnet.codex.storage
  # export GETH_VERBOSITY=4
  ```
- `docker-compose up -d`


## [How to get ready](#codex-testnet-starter)
When starting the Testnet Starter for the first time, (or restarting after a long pause) please keep in mind:
- Your local Geth node will need time to sync.
- Codex should automatically wait until Geth is ready. However, in some situations Codex will attempt to start and promptly crash too soon. This is a known issue. When this happens, please manually restart Codex's container when your Geth node is synced.

Before you can use the marketplace functionality of Codex, you will need to obtain some tokens in the testnet.
1. Join the Codex Discord server: [Here](LINK PENDING)
1. Find the appropriate testnet channel.
1. Give your public key to the bot using `set` command.
![Bot-Set](/docs/bot-set.png)
1. Ask it politely to mint some tokens for you using `mint` command.
![Bot-Mint](/docs/bot-mint.png)
(It may or may not happen in the future that testnet participation will be rewarded automatically with Discord server roles.)


## [How to use](#codex-testnet-starter)
Once running, Codex exposes a web-api at the API port. (default: 8080)
To read more about how to use the API, go [Here](/USINGCODEX.md)


## [How to stop](#codex-testnet-starter)
- `docker-compose down`


## [How to stop and delete everything](#codex-testnet-starter)
- `docker-compose down --rmi all -v`


## [Troubleshooting](#codex-testnet-starter)


### Geth
```shell
# List peers
docker exec -it geth geth attach --exec net.peerCount /data/geth.ipc

# Connected peers
docker exec -it geth geth attach --exec admin.peers /data/geth.ipc

# Add a peer
docker exec -it geth geth attach --exec 'admin.addPeer("enode://cff0c44c62ecd6e00d72131f336bb4e4968f2c1c1abeca7d4be2d35f818608b6d8688b6b65a18f1d57796eaca32fd9d08f15908a88afe18c1748997235ea6fe7@159.223.243.50:40010")' /data/geth.ipc

# Sync status
docker exec -it geth geth attach --exec eth.syncing /data/geth.ipc

# Geth own enode
docker exec -it geth geth attach --exec admin.nodeInfo.enode /data/geth.ipc
```
