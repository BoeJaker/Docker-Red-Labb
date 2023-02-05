#!bin/bash

# Randomises your mac address

new_mac="$(echo AA:60:2F:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10]:$[RANDOM%10]$[RANDOM%10])" ;
ip link set dev eth0 down ;
ip link set dev eth0 address $new_mac ;
ip link set dev eth0 up ;