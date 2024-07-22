# Workshop Setup
With these instructions you can set up a Codex node on your machine, to use during the workshop. If you run into trouble and need help, ask a nearby Codexer!

## 1. Use the local network wifi
Switch to the workshop wifi:
- SSID: `codex`
- Password: `ethcc2024`

## 2. Clone this repository
```
git clone https://github.com/codex-storage/codex-testnet-starter.git
cd codex-testnet-starter/scripts
```
> #### 📢 **Windows users**<br>
>If you are using a native Windows environment, and not a *nix-like environment
>(eg CYGWIN/MINGW/MSYS/MINGW), use the `scripts/windows` directory.

## 3. Download Codex
Run `download` script:
```shell
./download.sh
```

## 4. Generate an ETH key-pair
Run `generate` script:
```shell
./generate.sh
```
 * Your private key will be saved to scripts/eth.key.
 * Your ethereum address will be saved to scripts/eth.address.

> #### 📢 **Don't lose your keys**<br>
>If you lose your key and address, you can generate new ones. But the faucet and/or discord bot may refuse to give you new tokens for quite a while!

## 5. Start Codex node
Run the `run_client` script:
```shell
./run_client.sh
```

Unix users may be required to install libgomp:
```shell
sudo apt-get install libgomp1
```

#### 📢 **Check your IP**<br>
Check that your `LOCAL IP` in the output is correct, and if not, re-run the script with the LOCALIP environment variable:
```shell
LOCALIP=192.168.88.46 ./run_client.sh
```

## 6. Acquire tokens
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

## 7. Use Codex
Setup complete! 🥳 You can now proceed to use your Codex node. Follow the
[instructions](./USINGCODEX.md) 🐇

If you're on Windows, we have prepare the same instructions for CMD [here](./USINGCODEX_WIN.md)
