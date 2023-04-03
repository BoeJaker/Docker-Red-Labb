#!/bin/bash
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Configure Tor
printf "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword ""${TOR_CRED_HASH}"" \n \
            ControlPort 9051" &>/dev/null | tee -a /etc/tor/torrc && \

# Map local network
nmap 172-173.16.0.0-100 -oX /local_nmap.xml &>/dev/null
results=$(xmllint --format --xpath "//host/address|//hostname|//port/@portid" local_nmap.xml | tr -d "<>")

#!/bin/bash

# Looks up the ip address of the proxy container and inserts 
# it into the proxychains config file

## "resolve koan" is not required on the koan node
# ip="$(ping  koan.pagodo_and_proxychain_internal -c 1 | egrep -o "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique)" 
# config="http "+$ip+" 8080\nsocks5 "+$ip+" 9050"
# printf $config | tee -a /etc/proxychains.conf 
# export HOST_KOAN=$ip
# echo "Koan: $ip"

p_ip="$(ping  Postgres.pagodo_and_proxychain_internal -c 1 | egrep -o "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique)" 
[ $p_ip ] && {
    export HOST_POSTGRES=$p_ip
    echo -e "${GREEN}Postgres online: $p_ip${NC}"
} || {
    echo -e "${RED}Postgres offline${NC}"
}
pg_isready -h $p_ip -p 5432 -U "${POSTGRES_USER}" && { 
    echo -e "${GREEN}Database up - Connection established ${NC}" 
} || {
    echo -e "${RED}Database down - Connection could not be estbalished ${NC}" 
}

h_ip="$(ping  Houston.pagodo_and_proxychain_internal -c 1 | egrep -o "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique)" 
[ $h_ip ] && {
    export HOST_HOUSTEN=$h_ip
    echo -e "${GREEN}Housten online: $h_ip${NC}"
} || {
     echo -e "${RED}Housten offline${NC}"
}

ca_ip="$(ping  ca_authority.pagodo_and_proxychain_internal -c 1 | egrep -o "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique)" 
[ $ca_ip ] && {
    export HOST_CA=$ip
    echo -e "${GREEN}CA online: $ca_ip${NC}"
} || {
     "${RED}CA offline${NC}"
}

# echo -e "${BLUE}$results${NC}"
## Check if Internal network is up
echo $results | grep "172.16.0" &>/dev/null && {
    echo -e "${GREEN}Internal up: 172.16.0.1 ${NC}"
} || {
    echo -e "${RED}Internal down ${NC}"
}

## Check if External network is up
echo $results | grep "173.16.0" &>/dev/null && {
    echo -e "${GREEN}External up:  172.16.0.1 ${NC}"
} || {
    echo -e "${RED}External down ${NC}"
}

# mitmweb --web-host 0.0.0.0 --set block_global=false && {
#     echo "Mitmproxy online"
# } || {
#     echo "Could not start Mitmproxy"
# }
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode upstream:https://0.0.0.0:9050 &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode transparent --showhost &

echo -e "${BLUE}Connecting to TOR ${NC}"

tor --hush &

timeout=0
until curl --socks5-hostname localhost:9050 https://check.torproject.org/api/i
p
do
    sleep 5
    ((timeout=timeout+5))
done
 [ $timeout -eq 60 ] && {
    echo -e "${GREEN}Connected to TOR network ${NC}" > /dev/tty
} || {
    echo -e "${RED}Connection to TOR netowrk timed out - try again ${NC}" > /dev/tty
}

echo -e "${BLUE}Starting TCP dump in the background ${NC}"
tcpdump -i lo &

/Scripts/Networking/whatmyip.sh &&
source torsocks on && 
/Scripts/Networking/whatmyip.sh

echo -e "${BLUE}Starting Open VPN${NC}"
openvpn /etc/openvpn/server.conf