#!/bin/bash

codex persistence \
  prover \
  --bootstrap-node=spr:CiUIAhIhAiJvIcA_ZwPZ9ugVKDbmqwhJZaig5zKyLiuaicRcCGqLEgIDARo8CicAJQgCEiECIm8hwD9nA9n26BUoNuarCEllqKDnMrIuK5qJxFwIaosQ3d6esAYaCwoJBJ_f8zKRAnU6KkYwRAIgM0MvWNJL296kJ9gWvfatfmVvT-A7O2s8Mxp8l9c8EW0CIC-h-H-jBVSgFjg3Eny2u33qF7BDnWFzo7fGfZ7_qc9P \
  --bootstrap-node=spr:CiUIAhIhAyUvcPkKoGE7-gh84RmKIPHJPdsX5Ugm_IHVJgF-Mmu_EgIDARo8CicAJQgCEiEDJS9w-QqgYTv6CHzhGYog8ck92xflSCb8gdUmAX4ya78QoemesAYaCwoJBES39Q2RAnVOKkYwRAIgLi3rouyaZFS_Uilx8k99ySdQCP1tsmLR21tDb9p8LcgCIG30o5YnEooQ1n6tgm9fCT7s53k6XlxyeSkD_uIO9mb3 \
  --bootstrap-node=spr:CiUIAhIhAlNJ7ary8eOK5GcwQ6q4U8brR7iWjwhMwzHb8BzzmCEDEgIDARpJCicAJQgCEiECU0ntqvLx44rkZzBDqrhTxutHuJaPCEzDMdvwHPOYIQMQsZ67vgYaCwoJBK6Kf1-RAnVEGgsKCQSuin9fkQJ1RCpGMEQCIDxd6lXDvj1PcHgQYnNpHGfgCO5a7fejg3WhSjh2wTimAiB7YHsL1WZYU_zkHcNDWhRgMbkb3C5yRuvUhjBjGOYJYQ \
  --bootstrap-node=spr:CiUIAhIhA7E4DEMer8nUOIUSaNPA4z6x0n9Xaknd28Cfw9S2-cCeEgIDARo8CicAJQgCEiEDsTgMQx6vydQ4hRJo08DjPrHSf1dqSd3bwJ_D1Lb5wJ4Qt_CesAYaCwoJBEDhWZORAnVYKkYwRAIgFNzhnftocLlVHJl1onuhbSUM7MysXPV6dawHAA0DZNsCIDRVu9gnPTH5UkcRXLtt7MLHCo4-DL-RCMyTcMxYBXL0 \
  --bootstrap-node=spr:CiUIAhIhAzZn3JmJab46BNjadVnLNQKbhnN3eYxwqpteKYY32SbOEgIDARo8CicAJQgCEiEDNmfcmYlpvjoE2Np1Wcs1ApuGc3d5jHCqm14phjfZJs4QrvWesAYaCwoJBKpA-TaRAnViKkcwRQIhANuMmZDD2c25xzTbKSirEpkZYoxbq-FU_lpI0K0e4mIVAiBfQX4yR47h1LCnHznXgDs6xx5DLO5q3lUcicqUeaqGeg \
  --bootstrap-node=spr:CiUIAhIhAuN-P1D0HrJdwBmrRlZZzg6dqllRNNcQyMDUMuRtg3paEgIDARpJCicAJQgCEiEC434_UPQesl3AGatGVlnODp2qWVE01xDIwNQy5G2DeloQm_L2vQYaCwoJBI_0zSiRAnVsGgsKCQSP9M0okQJ1bCpHMEUCIQDgEVjUp1RJGb59eRPs7RPYMSGAI_fo1yv70iBtnTqefQIgVoXszc87EGFVO3aaqorEYZ21OGRko5ho_Pybdyqa6AI \
  --bootstrap-node=spr:CiUIAhIhAsi_hgxFppWjHiKRwnYPX_qkB28dLtwK9c7apnlBanFuEgIDARpJCicAJQgCEiECyL-GDEWmlaMeIpHCdg9f-qQHbx0u3Ar1ztqmeUFqcW4Q2O32vQYaCwoJBNEmoCiRAnV2GgsKCQTRJqAokQJ1dipHMEUCIQDpC1isFfdRqNmZBfz9IGoEq7etlypB6N1-9Z5zhvmRMAIgIOsleOPr5Ra_Nk7BXmXGhe-YlLosH9jo83JtfWCy3-o \
  --data-dir=./codex-data \
  --log-level=TRACE \
  --api-port=8080 \
  --api-bindaddr=0.0.0.0 \
  --metrics=true \
  --listen-addrs=/ip4/0.0.0.0/tcp/8070 \
  --disc-port=8090 \
  --nat=extip:$(curl https://ip.codex.storage) \
  --circuit-dir=./codex-data/circuits \
  --eth-private-key=eth.key \
  --eth-provider=https://rpc.testnet.codex.storage
