# Codex Testnet Starter
Hit the ground running with Codex.

1. [How to start](#how-to-start)
2. [How to stop](#how-to-stop)
3. [How to stop and delete everything](#how-to-stop-and-delete-everything)
4. [Troubleshooting](#troubleshooting)


## [How to start](#codex-testnet-starter)
- Have docker installed.
- Clone this repo.
- Define variables
  ```shell
  export PRIV_KEY=9721fb80cf32275ce80ae41927130adc767d435dbb1d80114dac2ef2d7c951f0

  # export CODEX_ETH_PROVIDER=https://rpc.testnet.codex.storage
  # export GETH_VERBOSITY=4
  ```
- `docker-compose up -d`
- Open browser to `<GUI ENDPOINT HERE>`




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
