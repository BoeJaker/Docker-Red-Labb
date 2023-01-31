#!/bin/bash
mitmweb --web-host 0.0.0.0 --set block_global=false &
tcpdump