# Codex Testnet Starter
Hit the ground running with Codex.

1. [Overview](#overview)
2. [How to start](#how-to-start)
3. [How to get ready](#how-to-get-ready)
4. [How to use](#how-to-use)
5. [How to stop](#how-to-stop)
6. [How to stop and delete everything](#how-to-stop-and-delete-everything)
7. [Troubleshooting](#troubleshooting)


## [Overview](#codex-testnet-starter)
![Overview](/docs/overview.png)
Using the Testnet Starter, you can run a (mostly preconfigured) Codex node on your machine. You always have the option to build and run Codex from sources [Here](https://github.com/codex-storage/nim-codex/).


## [How to start](#codex-testnet-starter)
 1. [Have Docker with compose installed](https://docs.docker.com/engine/install/)

 2. Clone this repo
    ```shell
    git clone https://github.com/codex-storage/codex-testnet-starter && cd codex-testnet-starter
    ```

 3. Create an Ethereum public/private key pair
    <details>
    <summary>Use Docker</summary>

    ```shell
    # Generate keypair
    docker run --rm gochain/web3 account create
    ```
    </details>

    <details>
    <summary>Use metamask</summary>

    1. [Accounts and Addresses](https://support.metamask.io/hc/en-us/sections/4471975962907-Accounts-and-Addresses)
    2. [How to export an account's private key](https://support.metamask.io/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key)
    </details>

    <details>
    <summary>Use Python code</summary>

    1. Create a venv
       ```shell
       pip3 install virtualenv

       venv=codex-eth-key
       mkdir $venv && cd $venv

       python3 -m venv env
       source env/bin/activate
       ```

    2. Install required packages
       ```shell
       pip3 install web3
       ```

    3. Create a script
       ```shell
       vi eth-keys.py
       ```
       ```python
        from eth_account import Account

        def generate_ethereum_keypair():
            # Generate a new Ethereum account
            account = Account.create()

            # Get the private key
            private_key = account._private_key.hex()

            # Get the public key (Ethereum address)
            public_key = account.address

            return private_key, public_key

        # Generate the Ethereum key pair
        private_key, public_key = generate_ethereum_keypair()

        # Print the keys
        print("Private Key:", private_key)
        print("Public Key (Ethereum Address):", public_key)
       ```

    4. Generate the keys
       ```shell
       python3 eth-keys.py
       ```
    5. Cleanup
       ```shell
       deactivate
       cd .. && rm -rf $venv
       ```
    </details>

    ```
    # Example
    Private key: 0xacec4df7549199708a9f66b151aea7bf41b4d30bd325b96b26f017246226e1a3
    Public address: 0x1C408C8572ce7d5E79a3a6D353e5FC2E8E2c49ce
    ```

 4. Define variables
    ```shell
    export PRIV_KEY=0xacec4df7549199708a9f66b151aea7bf41b4d30bd325b96b26f017246226e1a3
    export CODEX_LISTEN_ADDRS=/ip4/0.0.0.0/tcp/8070
    export CODEX_DISC_PORT=8090

    # export CODEX_ETH_PROVIDER=https://rpc.testnet.codex.storage
    # export CODEX_LOG_LEVEL=TRACE
    #
    # export GETH_DISCOVERY_PORT=8547
    # export GETH_PORT=8548
    # export GETH_NAT=extip:1.1.1.1
    # export GETH_VERBOSITY=3
    ```

 5. Run local nodes
    ```shell
    docker-compose up
    ```

 6. Setup port forwarding on your router for Codex, based on defined values
    ```
    TCP - CODEX_LISTEN_ADDRS=/ip4/0.0.0.0/tcp/8070
    UDP - CODEX_DISC_PORT=8090
    ```


## [How to get ready](#codex-testnet-starter)
When starting the Testnet Starter for the first time, (or restarting after a long pause) please keep in mind:
- Your local Geth node will need time to sync.
- Codex should automatically wait until Geth is ready. However, in some situations Codex will attempt to start too soon and promptly crash. This is a known issue. When this happens, please manually restart Codex's container when your Geth node is synced.

Before you can use the marketplace functionality of Codex, you will need to obtain some tokens in the testnet.
1. Join the [Codex Discord server](https://discord.gg/codex-storage)
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
