# DevCon Network
With these instructions you can plug your Codex node into the DevCon local network, to participate in the Raspberry Pi challenge!
You can also participate in the challenge using the public testnet, if you have a node already set up.

## 1. Set up your Codex node
Follow the normal Codex TestNet instructions to get Codex running. You can skip all the steps related to port forwarding.
Go [Here](https://docs.codex.storage)

## 2. Switch to the local network wifi
Switch to the workshop wifi:
- SSID: `codex`
- Password: `ethcc2024`

## 3. Switch Codex to the local network
- Turn off your Codex node.
- Change the bootstrap SPR from the TestNet SPR to the following: (UPDATE THIS!) `spr:CiUIAhIhAnBsex_7L5xKJQpmAuOtubQEtKsgCOXE2vaJoTJXrprbEgIDARo8CicAJQgCEiECcGx7H_svnEolCmYC4625tAS0qyAI5cTa9omhMleumtsQnbm0tAYaCwoJBMCoWP2RAh-aKkcwRQIhANjwAV9DGFe4zcMUEHjuTsGWAPc7WB7uoSS86HATwouqAiA8dFhsALCSLsQbSOPF1j7NF643oEmPEJAwU9dIwjM6TA`
- Change your '--nat' IP address parameter to the IP address of your machine in the local WIFI network.

## 4. Done!
You can now use your Codex node to download the local-network CIDs of the challenge!
