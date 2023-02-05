#!/bin/bash

# Looks up the ip address of the proxy container and inserts 
# it into the proxychains config file

ip="$(ping  mitmproxy.pagodo_and_proxychain_internal -c 1 | egrep -o "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique)" 
config="http "+$ip+" 8080\nsocks5 "+$ip+" 9050"
printf $config | tee -a /etc/proxychains.conf 

