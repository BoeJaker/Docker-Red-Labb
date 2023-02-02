-- WORK IN PROGRESS --
# Homebrew Docker Lab
# Overview
This docker container network is intended for security research only

# Layers
# Components
## Koan Proxy
### Traffic obfuscator, firewall, multi-proxy and packet capture / replay tool - The less noise you make the more you hear.
### 
This container routes traffic through a chain of proxy, first Mitm, then Koan (Tor)
This container captures packets traveling either way between this network and the internet
This container encrypts traffic and routes it through tor, filters packets
BUILD NOTE: Could bdee rolled up with Mitm

- [proxychains]()
- tor
- [mitmproxy]()
- [tcpdump]()
- nyx


## OSINT Scanner
###
Automatically scans the internet looking for vulnerabilities
- [pagodo]()
- [nmap]()
- [traceroute]()
- [sqlmap](https://sqlmap.org/)
-  

## [Houston](houston)
### Command and control
This container provides a gui that is accesible though a web browser and a flexible kali installation

## [OSINT Database](database)
### A persistant database of exploits, vulnerabilities and other OSINT gathered by houston

## Source_Data Database
An index of domains, passwords, usernames and historical data such as the carna dataset

# Usage

Edit the .env.dummy file, insert your variables and remove the .dummy extension from the filename.

Open a terminal in this directory and execute the following:

    docker compose build -t obfuscated

To compose:

    docker compose up -d

Packages & Function:
- git 
- python3 
- python3-pip 
- tor  
- obfs4proxy
- proxychains4 
- iproute2 
- curl 
- netcat
- nano
- cron

Ports:
- 9150 - Tor traffic socket
- 9051 - Tor control socket

Services:
- torsocks
- proxychains4
- obfs4proxy
- pagodo

Scripts:
- newroute.sh
- randomise_mac.sh
- whatmyip.sh

Config:
- crontab
- proxychains4
- torrc
- torsocks