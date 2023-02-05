#!/bin/bash
mitmweb --web-host 0.0.0.0 --set block_global=false &
tor &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode upstream:https://0.0.0.0:9050 &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode transparent --showhost &
# tcpdump