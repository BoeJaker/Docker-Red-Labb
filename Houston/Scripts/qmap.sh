#!/bin/bash
args="$@"
target=$args[-1]
flag=$args[-2]

if "$target" ; then

    nmap -PEPM -sP -n "$target" # Quick nmap scan

    if [ "$flag" == "-m" ] ; then
        masscan -p 20,21-23,25,53,80,110,111,135,139,143,443,445,993,995,1723,3306,3389,5900,8080,8081 "$target" # Quick masscan port scan

    elif [ "$flag" == "-n" ] ; then
        nmap --open -PEPM -P -p 20,21-23,25,53,80,110,111,135,139,143,443,445,993,995,1723,3306,3389,5900,8080,8081 "$target" # Quick nmap port scan
    fi

else ; then
    echo "Please specify a target. qmap.sh 192.168.0.0/16"
    echo "optionally specify -p flag to perform a fast port scan. qmap.sh -p 192.168.0.0/16"
    echo "optionally specify -m flag to use masscan. qmap.sh -m 192.168.0.0/16"
fi