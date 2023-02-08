-- WORK IN PROGRESS --
# Homebrew Docker Lab
# Overview
This docker container network is intended for security research only

## Security
### How does this lab keep you secure?
These containers use no linked volumes, this prevents file injection onto the contaianers host.
# Layers
# Components
## [Koan Proxy](Koan)
### Traffic obfuscator, firewall, multi-proxy and packet capture / replay tool - The less noise you make the more you hear.
### 
This container routes traffic through a chain of proxy, first Mitm, then Koan (Tor)
captures packets traveling either way between this network and the internet
encrypts traffic and routes it through tor, filters packets
can create an endpoint that pretends to be a networks gateway - capturing all traffic and providing an injection point

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
## [DNS Server](DNS%20Server)
This network of containers has its own self-contained DNS-server
## [Houston](houston)
### Command and control
This container provides a gui that is accesible though a web browser and a flexible kali installation 
## [OSINT Database](database)
### A database of exploits, vulnerabilities and other OSINT gathered by houston. 
You can set a volume to make the database persistant 
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