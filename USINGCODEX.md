# Using Codex

Codex's web-API is documented: [Here](https://github.com/codex-storage/nim-codex/blob/master/openapi.yaml)
This document will show you several useful API calls.


## Overview
1. [Debug](#debug)
1. [Upload a file](#upload-a-file)
1. [Download a file](#download-a-file)
1. [Local data](#local-data)
1. [Create storage availability](#create-storage-availability)
1. [Purchase storage](#purchase-storage)
1. [View purchase status](#view-purchase-status)


## Debug
An easy way to check that your node is up and running is:
```shell
curl --request GET \
  --url http://localhost:8080/api/codex/v1/debug/info
```
This will return a JSON structure with plenty of information about your local node. It contains peer information that may be useful when troubleshooting connection issues.


## Upload a file
**Warning**
Once you upload a file to Codex, other nodes in the testnet can download it. Please do not upload anything you don't want others to access, or, properly encrypt your data *first*.

```shell
curl --request POST \
  --url http://localhost:8080/api/codex/v1/data \
  --header 'Content-Type: application/octet-stream' \
  -T <FILE>
```

On successful upload, you'll receive a CID. This can be used to download the file from any node in the network.


## Download a file
When you have a CID of data you want to download, you can use the following:

```shell
curl --request GET \
  --url http://localhost:8080/api/codex/v1/data/{CID HERE}/network
```

Note that Codex does not store content-type or extension information.


## Local data
You can view which datasets are currently being stored by your node.
```shell
curl --request GET \
  --url http://localhost:8080/api/codex/v1/data
```


## Create storage availability
In order to start selling storage space to the network, you must configure your node with the following command. Once configured, the node will monitor on-chain requests-for-storage and will automatically enter into contracts that meet these specifications.
```shell
curl --request POST \
  --url http://localhost:8080/api/codex/v1/sales/availability \
  --header 'Content-Type: application/json' \
  --data '{
	"totalSize": "8000000",
	"duration": "7200",
	"minPrice": "10",
	"maxCollateral": "10"
  }'
```
For descriptions of each parameter, please view the [Spec](https://github.com/codex-storage/nim-codex/blob/master/openapi.yaml).


## Purchase storage
To purchase storag space from the network, first you must upload your file. Once you have the CID, use the following to create a request-for-storage contract.

```shell
curl --request POST \
  --url http://localhost:8080/api/codex/v1/storage/request/{CID HERE} \
  --header 'Content-Type: application/json' \
  --data '{
  "duration": "3600",
  "reward": "1",
  "proofProbability": "3",
  "nodes": 2,
  "tolerance": 1,
  "collateral": "5",
  "expiry": "1711703406"
}'
```
For descriptions of each parameter, please view the [Spec](https://github.com/codex-storage/nim-codex/blob/master/openapi.yaml).

'Expiry' must be a Unix timestamp in the future, but not further than 'duration' seconds from now. You can use [this](https://www.unixtimestamp.com) to generate one.

On successful, this request will return a Purchase-ID.


## View purchase status
Using a Purchase-ID, you can check the status of your request-for-storage contract:
```shell
curl --request GET \
  --url http://localhost:8080/api/codex/v1/storage/purchases/{PURCHASE ID HERE}
```

