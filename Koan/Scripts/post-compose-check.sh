#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -I POSTROUTING -s 173.16.0.0/24 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 172.16.0.0/24 -j MASQUERADE

nmap 172-173.16.0.0-100 -oX /local_nmap.xml &>dev/null
results=$(xmllint --format --xpath "//host/address|//hostname|//port/@portid" local_nmap.xml | tr -d "<>")

# echo "${GREEN}$results${NC}"
## Check if Internal network is up
echo $results | grep "172.16.0.1" && {
    echo "Internal up"
} || {
    echo "Internal down"
}

## Check if External network is up
echo $results | grep "173.16.0.1" && {
    echo "External up"
} || {
    echo "External down"
}

## Check if Database is up and working
echo $results | grep "database" && {

    psql -h "${database}" -p 5432 && { 
        echo "Database up - Connection established" 
    } || {
        echo "Database down - Connection could not be estbalished" 
    }
} || {
    echo "Is the database up?"
}

## Check if command and control is up and working
echo $results | grep "housten" && {
    echo "Housten up"
} || {
    echo "Houston down"
}

# mitmweb --web-host 0.0.0.0 --set block_global=false && {
#     echo "Mitmproxy online"
# } || {
#     echo "Could not start Mitmproxy"
# }
echo "Connecting to TOR"
tor --hush && {
    echo "Connected to TOR network"
} || {
    echo "Connection to TOR netowrk failed"
} &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode upstream:https://0.0.0.0:9050 &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode transparent --showhost &
echo "Starting TCP dump in the background"
tcpdump 1> /dev/tty1 &
/usr/bin/bash

