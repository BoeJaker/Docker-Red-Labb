#!bin/bash

echo "restarting" ;
ip link set dev eth0 down ;
sleep 5 ;
systemctl stop tor.service ;
sleep 5 ;
systemctl start tor.service ;
sleep 5 ;
ip link set dev eth0 up ;
systemctl restart network.service
echo "restarted" ;