#!/bin/bash
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

#Configure Tor
printf "ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy\n \
            HashedControlPassword ""${TOR_CRED_HASH}"" \n \
            ControlPort 9051" | tee -a /etc/tor/torrc && \

nmap 172-173.16.0.0-100 -oX /local_nmap.xml &>/dev/null
results=$(xmllint --format --xpath "//host/address|//hostname|//port/@portid" local_nmap.xml | tr -d "<>")

# echo "${GREEN}$results${NC}"
## Check if Internal network is up
echo $results | grep "172.16.0" &>/dev/null && {
    echo -e "${GREEN}Internal up ${NC}"
} || {
    echo -e "${RED}Internal down ${NC}"
}

## Check if External network is up
echo $results | grep "173.16.0" &>/dev/null && {
    echo -e "${GREEN} External up ${NC}"
} || {
    echo -e "${RED} External down ${NC}"
}

## Check if Database is up and working
echo $results | grep "database"  &>/dev/null && {

    pg_isready -h "${database}" -p 5432 -U "${POSTGRES_USER}" && { 
        echo -e "${GREEN} Database up - Connection established ${NC}" 
    } || {
        echo -e "${RED} Database down - Connection could not be estbalished ${NC}" 
    }
} || {
    echo -e "${RED} Is the database server up? ${NC}"
}

## Check if command and control is up and working
echo $results | grep "housten"  &>/dev/null && {
    echo -e "${GREEN} Housten up ${NC}"
} || {
    echo -e "${RED} Houston down ${NC}"
}

# mitmweb --web-host 0.0.0.0 --set block_global=false && {
#     echo "Mitmproxy online"
# } || {
#     echo "Could not start Mitmproxy"
# }
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode upstream:https://0.0.0.0:9050 &
# mitmweb --web-host 0.0.0.0 --set block_global=false --mode transparent --showhost &

echo -e "${BLUE}Connecting to TOR ${NC}"
tor --hush && {
    echo -e "${GREEN}Connected to TOR network ${NC}"
} || {
    echo -e "${RED}Connection to TOR netowrk failed ${NC}"
} &

echo -e "${BLUE}Starting TCP dump in the background ${NC}"
tcpdump -v > /dev/tty1 &

/Scripts/whatmyip.sh &&
source torsocks on && 
/Scripts/whatmyip.sh

