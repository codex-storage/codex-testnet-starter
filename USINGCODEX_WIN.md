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
curl http://localhost:8080/api/codex/v1/debug/info
```

This will return a JSON structure with plenty of information about your local node. It contains peer information that may be useful when troubleshooting connection issues.


## Upload a file
**Warning**
Once you upload a file to Codex, other nodes in the testnet can download it. Please do not upload anything you don't want others to access, or, properly encrypt your data *first*.

```shell
SET FILE="..."
```

```shell
curl --request POST ^
  http://localhost:8080/api/codex/v1/data ^
  --header "Content-Type: application/octet-stream" ^
  -T %FILE%
```

On successful upload, you'll receive a CID. This can be used to download the file from any node in the network.


## Download a file
When you have a CID of data you want to download, you can use the following commands:

```shell
SET CID="..."
```

```shell
curl -o "%CID%.png" "http://localhost:8080/api/codex/v1/data/%CID%/network"
```
> #### 📢 **Note**
>NOTE: Use the file type of the image uploaded in the previous step

Note that Codex does not store content-type or extension information. If you get an error, run `echo ${CID}` to verify your CID is set properly.


## Local data
You can view which datasets are currently being stored by your node.

```shell
curl http://localhost:8080/api/codex/v1/data
```

## Create storage availability
> #### 📢 **Warning**
>Are you currently in a Codex workshop?! Yes: Please skip this step.
>Proceed with 'Purchase storage'.

In order to start selling storage space to the network, you must configure your node with the following command. Once configured, the node will monitor on-chain requests-for-storage and will automatically enter into contracts that meet these specifications.

```shell
curl --request POST ^
  http://localhost:8080/api/codex/v1/sales/availability ^
  --header "Content-Type: application/json" ^
  --data "{ \"totalSize\": \"8000000\", \"duration\": \"7200\", \"minPrice\": \"10\", \"maxCollateral\": \"10\" }"
```

For descriptions of each parameter, please view the [Spec](https://github.com/codex-storage/nim-codex/blob/master/openapi.yaml).


## Purchase storage
To purchase storag space from the network, first you must upload your data. Once you have the CID, use the following to create a request-for-storage.

Set your CID:

```shell
SET CID="..."
```

Next you can run:

```shell
curl --request POST ^
  "http://localhost:8080/api/codex/v1/storage/request/%CID%" ^
  --header "Content-Type: application/json" ^
  --data "{ \"duration\": \"3600\", \"reward\": \"1\", \"proofProbability\": \"5\", \"expiry\": \"1200\", \"nodes\": 5, \"tolerance\": 2, \"collateral\": \"1\" }"
```

For descriptions of each parameter, please view the [Spec](https://github.com/codex-storage/nim-codex/blob/master/openapi.yaml).

On successful, this request will return a Purchase-ID.


## View purchase status
Using a Purchase-ID, you can check the status of your request-for-storage contract:

```shell
SET PURCHASE_ID="..."
```

Then:

```shell
curl "http://localhost:8080/api/codex/v1/storage/purchases/%PURCHASE_ID%"
```

This will display state and error information for your purchase.
| State     | Description                                                                             |
|-----------|-----------------------------------------------------------------------------------------|
| Pending   | Request is waiting for chain confirmation.                                              |
| Submitted | Request is on-chain. Hosts may now attempt to download the data.                        |
| Started   | Hosts have downloaded the data and provided proof-of-storage.                           |
| Failed    | The request was started, but (too many) hosts failed to provide proof-of-storage on time. While the data may still be available in the network, for the purpose of the purchase it is considered lost. |
| Finished  | The request was started successfully and the duration has elapsed.                      |
| Expired   | (Not enough) hosts have submitted proof-of-storage before the request's expiry elapsed. |
| Errored   | An unfortunate state of affairs. The 'error' field should tell you more.                |
