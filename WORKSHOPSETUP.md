# Workshop Setup
With these instructions you can set up a Codex node on your machine, to use during the workshop. If you run into trouble and need help, ask a nearby Codexer!

## 1. Clone this repository
```
git clone https://github.com/codex-storage/codex-testnet-starter.git
```

## 2. Use the local network wifi
Switch to the workshop wifi:
- SSID: `codex`
- Password: `ethcc2024`

## 3. Open a terminal
Open a terminal in the `/scripts` folder:
```shell
cd scripts
chmod +x *.sh # make the scripts executable
```
> #### 📢 **Windows users**<br>
>If you are using a native Windows environment, and not a *nix-like environment
>(eg CYGWIN/MINGW/MSYS/MINGW), use the `scripts/windows` directory.

## 4. Download Codex
Run `download` script:
```shell
./download.sh
```

## 5. Generate an ETH key-pair
Run `generate` script:
```shell
./generate.sh

# Generating private key...
#  * your private key has been saved to /Users/egonat/repos/codex-storage/codex-testnet-starter/scripts/eth.key
#  * your ethereum address is 1b54dd8d3b45b419091821c7c47a36e014b8db79
```
> #### 📢 **Don't lose your generated address**<br>
>Take note of the generated address in the output so you can use it to mint
tokens later.

## 6. Start Codex node
Run the `run_client` script:
```shell
./run_client.sh

# LOCAL IP: 192.168.50.45
# INF 2024-06-25 16:32:25.410+10:00 Creating a private key and saving it       tid=25484256
# INF 2024-06-25 16:32:25.414+10:00 Discovery SPR initialized                  topics="discv5"
# ...
```

> #### 📢 **Don't lose your generated address**<br>
>Check that your `LOCAL IP` in the output is correct, and if not, re-run the script with
the LOCALfIP environment variable:
> ```shell
> LOCALIP=192.168.50.46 ./run_client.sh
> ```
> <br>


## 7. Acquire tokens
You can acquire tokens in one of two ways: the testnet faucets or the Discord bot.

### Faucets
You will need both ETH and TST to use Codex:
 1. Get some testnet ETH using https://faucet-eth.testnet.codex.storage.
 2. Get some testnet TST using https://faucet-tst.testnet.codex.storage.

### Discord bot
 - Join the Codex discord server: https://discord.gg/codex-storage.
 - Go to the "bot" channel, in the category "codex-bot".
 - Use `/set` command to enter your generated address.
 - Use `/mint` command to receive some tokens.

## 8. Use Codex
Setup complete! 🥳 You can now proceed to use your Codex node. Follow the
[instructions](./USINGCODEX.md) 🐇
