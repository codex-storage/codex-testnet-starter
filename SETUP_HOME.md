# Home Setup
With these instructions you can set up a Codex node on your machine at home. If you run into trouble, try the [docs](https://docs.codex.storage) or reach out via our Discord server: https://discord.gg/codex-storage

## Prerequisites for Home Setup
In order for Codex to work from your home machine, please make sure you know your public IP address and are able to forward ports on your router or modem. If you're planning to participate as a storage node, please keep in mind that storage nodes are expected to maintain uptime as soon as they are engaged in one or more storage contracts. Taking your storage node offline while it's hosting storage contracts may result in loss of tokens.

## Disclaimer
This [disclaimer](./DISCLAIMER.md) applies to everything found in this repository. Be sure to read it.

## Running Codex
This document assumes you have Codex installed and are able to run it. You can obtain Codex by building from sources, downloading binaries, or using a docker image. Need to install Codex? Go [here](https://docs.codex.storage).

## Port Forwarding
Codex requires you to forward two ports: One for data exchange, and one for discovery. These ports can be configured with the CLI parameters `--listen-addrs` and `--disc-port`. We proceed with 8070 for the listen port, and 8090 for the discovery port.

**Follow the instructions of your modem or router to configure the following port-forwards:**
- LAN port: 8070 - Public port: 8070 - Protocol: TCP
- LAN port: 8090 - Public port: 8090 - Protocol: UDP

> 📢 Running Codex from Docker?
> Be sure to expose the above ports and protocols in your docker-compose file. See example docker-compose file further down. Additionally, some users have reported connection issues on some platforms. If you encounter this issue, we recommend trying docker's `bridge network` driver for the Codex container. Example:
> In the the Codex node service, add:
> ```
>     networks:
>       - codex
> ```
> At the root level, add:
> ```
> networks:
>   codex:
>     name: codex
>     driver: transparent
> ```

## Public IP Address
It is important that your Codex node can be reached by others in the network. For this reason, Codex will announce your public IP address to the network. If the announced address is incorrect, other nodes will not be able to establish connections with yours. Here is a list of common issues and possible solutions.

- 1. ISP Sub-NAT<br>
Many ISPs (especially mobile carriers) are using a sub-NAT. In this setup, the IP address your modem receives as public address is not actually exposed to the internet. Rather it is another sub-net that is connected to the internet through another NAT. You can detect this issue by accessing your modem's admin interface and finding the reported public IP address. If it does not match with the IP address provided by services like whatsmyip.org, then you might be behind a sub-NAT. A possible solution: Contact your ISP and ask them to provide you a dynamic internet IP address. Many ISPs can switch you over with the push of a button.

- 2. VPNs<br>
We're all fans of privacy here, but if your uplink is routed through a VPN service, it is unlikely that you're able to get the forwarding working correctly. Some VPNs may try to block traffic that looks peer-to-peer. A solution is to not run a VPN, or exampt from your VPN network the local device on which you're planning to run Codex.

- 3. Good old firewalls<br>
It still happens that your system's default security settings prevent Codex from accepting connections coming from outside the local address space. Please make sure it's configured properly.

**Discover your public IP address and keep it handy** (https://www.whatsmyip.org)

## Generate an ETH key-pair
Codex uses an Eth address (hot wallet) to transact with other nodes in the network. We will need a file containing only a private key, and we'll need the corresponding address. You can generate them using your own preferred method. For convenience, this repository contains a script, `/scripts/generate.sh` which you can use to generate a key pair. *Keys generated with this script should be used for testing purposes only and should be considered insecure.*

Run `generate` script:
```shell
./generate.sh
```
 * Your private key will be saved to scripts/eth.key.
 * Your ethereum address will be saved to scripts/eth.address.

**Generate a key pair**

Then set the permissions of your private key file.
For Unix, use this step:
1. Run `chmod 600 "eth.key"`

For Windows, use these steps:
1. Open explorer to the key file.
2. Right-click it -> Properties.
3. Security -> Advanced.
4. Add -> Select a principal -> Advanced -> Find Now
5. Select your user from the list -> OK -> OK
6. Check 'Full control' -> OK
7. Disable inheritance -> Remove all inheritance
8. OK -> OK

Unix users may be required to install libgomp:
```shell
sudo apt-get install libgomp1
```

## Start Codex node
We're now ready to start your Codex node and join the testnet!
Several configuration options must be set correctly, so the node knows how to connect into the testnet. You can review all of Codex's options with `./codex --help`. Each option can be set via CLI argument, or matching environment variable. (For example, option `--api-port` can also be set with env-var `CODEX_API_PORT`.) We recommend you give the list of options a quick read.

> Building a shell script? Start here and modify [this](./scripts/run_testnet.sh).

> Using docker-compose? Start here and modify [this](./docker-compose.yaml).

These options are required to join the testnet:
 - `--bootstrap-node=SPR` - Set SPR to one of the Codex Testnet bootstrap node SPRs found [here](https://docs.codex.storage/networks/testnet)
 - `--nat=IP` - Set IP to your public IP address. Using Docker? Skip this one.
 - `--listen-addrs=ADDR` - Set ADDR to "/ip4/0.0.0.0/tcp/8070". Note: If you changed the TCP port in the port forwarding step previously, change it here as well.
 - `--disc-port=PORT` - Set PORT to 8090. Again: If you changed it in the forward, do the same thing here.
 - `persistence` - Tells the node we want to enable marketplace interactions.
 - `--eth-private-key=FILE` - Set FILE to your private key file.
 - `--eth-provider=URL` - Set URL to the "Geth Public RPC" found [here](https://docs.codex.storage/networks/testnet)
The marketplace address should default to the correct testnet deployment. You can override it with:
 - `--marketplace-address=ADDR` - Set ADDR to `0x5Bd66fA15Eb0E546cd26808248867a572cFF5706`

The above options allow you to join the testnet, exchange data, and purchase storage in the network. If you wish to *sell storage space* to the network, you must include one additional argument:
 - `prover` - Tells the node we want to enable storage space selling

> You should know: Selling storage space required a zero-knowledge circuit in order to generate storage proofs. On first start, Codex will prompt you to download the correct circuit files. Additionally, proof generation has higher CPU and RAM requirements than other node operations.

> 📢 Are you using docker environment-variables to configure Codex?
> Options `persistence` and `prover` have no equivalent env-var. (Known issue in config-option-handling library.) To provide these arguments to Codex, you must override the container's command. Example:
> ```
>     command:
>      - bash
>      - /docker-entrypoint.sh
>      - persistence
>      - prover
> ```
> 📢 The Codex docker container will automatically find the public IP and use it. You can override this behavior by removing `NAT_PUBLIC_IP_AUTO` and setting `CODEX_NAT` manually.
> 📢 When running in a container, option `--eth-private-key` can't be set to a key file outside of your container. To solve this, set the environment variable `ETH_PRIVATE_KEY` to the content of your private key file. Scripting inside the docker container will automatically write this to a file in the container, set the correct permissions, and pass it to Codex.

> 📢 Are you using Windows, and the "/" characters in the listen-addrs are giving you trouble?
> In some shells, Windows will interpret "/" character as refering to "C:/" or the current working directory.
> Our workaround is to convert the bash script to batch (.bat) and run in CMD.

## Acquire tokens
Your node will need some tokens to be able to both purchase storage space and host storage space. You can acquire tokens in one of two ways: the testnet faucets or the Discord bot.

### Faucets
You will need both ETH and TST:
 1. Get some testnet ETH using https://faucet-eth.testnet.codex.storage.
 2. Get some testnet TST using https://faucet-tst.testnet.codex.storage.

### Discord bot
 - Join the Codex discord server: https://discord.gg/codex-storage.
 - Go to the "bot" channel, in the category "codex-bot".
 - Use `/set` command to enter your eth address.
 - Use `/mint` command to receive some tokens.

## Use Codex
Congrats, you're now a node operator! 🥳 You can now proceed to use your Codex node. Follow the
[instructions](./USINGCODEX.md) 🐇

If you're on Windows, we have prepare the same instructions for CMD [here](./USINGCODEX_WIN.md)
