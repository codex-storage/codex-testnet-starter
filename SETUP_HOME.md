# Home Setup
With these instructions you can set up a Codex node on your machine at home. If you run into trouble, reach out via our Discord server: https://discord.gg/codex-storage

## Prerequisites for Home Setup
In order for Codex to work from your home machine, please make sure you know your public IP address and are able to forward ports on your router or modem. If you're planning to participate as a storage node, please keep in mind that storage nodes are expected to maintain uptime as soon as they are engaged in one or more storage contracts. Taking your storage node offline while it's hosting storage contracts may result in loss of tokens.

## Disclaimer
This [disclaimer](./DISCLAIMER.md) applies to everything found in this repository. Be sure to read it.

## Port Forwarding
Codex requires you to forward two ports: One for data exchange, and one for discovery. These ports can be configured with the CLI parameters `--listen-addrs` and `--disc-port`. We proceed with 8070 for the listen port, and 8090 for the discovery port.

**Follow the instructions of your modem or router to configure the following port-forwards:**
- LAN port: 8070 - Public port: 8070 - Protocol: TCP
- LAN port: 8090 - Public port: 8090 - Protocol: UDP

## Public IP Address
It is important that your Codex node can be reached by others in the network. For this reason, Codex will announce your public IP address to the network. If the announced address is incorrect, other nodes will not be able to establish connections with yours. Here is a list of common issues and possible solutions.

- 1. ISP Sub-NAT<br>
Many ISPs (especially mobile carriers) are using a sub-NAT. In this setup, the IP address your modem receives as public address is not actually exposed to the internet. Rather it is another sub-net that is connected to the internet through another NAT. You can detect this issue by accessing your modem's admin interface and finding the reported public IP address. If it does not match with the IP address provided by services like whatsmyip.org, then you might be behind a sub-NAT. A possible solution: Contact your ISP and ask them to provide you a dynamic internet IP address. Many ISPs can switch you over with the push of a button.

- 2. VPNs<br>
We're all fans of privacy here, but if your uplink is routed through a VPN service, it is unlikely that you're able to get the forwarding working correctly. Some VPNs may try to block traffic that looks peer-to-peer. A solution is to not run a VPN on, or exampt from your VPN network the local device on which you're planning to run Codex.

- 3. Good old firewalls<br>
It still happens that your system's default security settings prevent Codex from accepting connections coming from outside the local address space. Please make sure it's configured properly.

**Discover your public IP address and keep it handy** (https://www.whatsmyip.org)

## Codex Setup

### 1. Clone this repository
```
git clone https://github.com/codex-storage/codex-testnet-starter.git
cd codex-testnet-starter/scripts
```
> #### 📢 **Windows users**<br>
>If you are using a native Windows environment, and not a *nix-like environment
>(eg CYGWIN/MINGW/MSYS/MINGW), use the `scripts/windows` directory.

### 2. Build or Download Codex
> 📢 If you're planning to run a storage node, additional steps are required.

To build Codex from sources, follow the instructions [here](https://github.com/codex-storage/nim-codex/blob/master/BUILDING.md)
> For storage nodes, be sure to build Codex from the branch `feature/ceremony-files`

To download Codex binaries, run `download_online` script.
> For storage nodes, modify the download script first by enabling it to download the 'prover' version of the binary. Look for the variable `BINARY_NAMES`.
```shell
./download_online.sh
```

### 3. Generate an ETH key-pair
Run `generate` script:
```shell
./generate.sh
```
 * Your private key will be saved to scripts/eth.key.
 * Your ethereum address will be saved to scripts/eth.address.

> #### 📢 **Don't lose your keys**<br>
>If you lose your key and address, you can generate new ones. But the faucet and/or discord bot may refuse to give you new tokens for quite a while!

### 4. Start Codex node
Modify the run script: Comment out the Local network SPR. Comment in the Cloud-Node-01 SPR.
Set your public IP and run the `run_client` script. 
```shell
LOCALIP=<PUBLIC-IP-HERE> ./run_client.sh
```
> 📢 For storage nodes, modify the run script first by adding the `prover` argument:
```bash
  ...
  --bootstrap-node=${BOOTSPR} \
  persistence \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage \
  --marketplace-address=0x9C88D67c7C745D2F0A4E411c18A6a22c15b37EaA \
  prover
```

Unix users may be required to install libgomp:
```shell
sudo apt-get install libgomp1
```

### 6. Acquire tokens
You can acquire tokens in one of two ways: the testnet faucets or the Discord bot.

#### Faucets
You will need both ETH and TST to use Codex:
 1. Get some testnet ETH using https://faucet-eth.testnet.codex.storage.
 2. Get some testnet TST using https://faucet-tst.testnet.codex.storage.

#### Discord bot
 - Join the Codex discord server: https://discord.gg/codex-storage.
 - Go to the "bot" channel, in the category "codex-bot".
 - Use `/set` command to enter your generated address.
 - Use `/mint` command to receive some tokens.

### 7. Use Codex
Congrats, you're now a node operator! 🥳 You can now proceed to use your Codex node. Follow the
[instructions](./USINGCODEX.md) 🐇

If you're on Windows, we have prepare the same instructions for CMD [here](./USINGCODEX_WIN.md)
