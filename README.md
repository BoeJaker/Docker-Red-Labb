-- WORK IN PROGRESS --
<br />

# Homebrew Docker Lab
# Overview
This docker container network is intended for security research only
<br />
These containers use no linked volumes, this prevents file injection onto the contaianers host.
<br />
<br />
# Components
## [Koan Proxy](Koan)
### Traffic obfuscator, firewall, multi-proxy and packet capture / replay tool - The less noise you make the more you hear.
\
This container routes traffic through a chain of proxy, first Mitm, then Koan (Tor)
captures packets traveling either way between this network and the internet
encrypts traffic and routes it through tor, filters packets
can create an endpoint that pretends to be a networks gateway - capturing all traffic and providing an injection point. 

Iptables Configuration

Network Scan detection

Packages:


- [proxychains]()
- [tor]()
- [mitmproxy]()
- [ettercap]()
- [tcpdump]()
- [nyx]()

<br />

## OSINT Scanner
###
Automatically scans the internet looking for vulnerabilities
- [pagodo]()
- [nmap]()
- [traceroute]()
- [sqlmap](https://sqlmap.org/)
-  
## [DNS Server](DNS%20Server)
This network of containers has its own self-contained DNS-server.
## [Certificate authority](DNS%20Server)
Secures local network communications using RSA key pairs and encryption.
## [Houston](houston)
### Command and control
This container provides a gui that is accesible though a web browser and a flexible kali installation.
## [OSINT Database](database)
### A database of exploits, vulnerabilities and other OSINT gathered by houston. 
You can set a volume to make the database persistant 
## Source_Data Database
An index of domains, passwords, usernames and historical data such as the carna dataset 
# Docker compose usage guide

Edit the .env.dummy file, insert your variables and remove the .dummy extension from the filename.

Use the run.ps1 or run.sh scripts to install dependancies and compose, or; Docker pull each image 
from the compose file manually. Then open a terminal in this directory and execute the following:

    docker compose build -t image_name ; docker compose up -d

Ports:
- 9150 - Tor traffic socket
- 9051 - Tor control socket
- 8080 - Mitmproxy listen
- 8081 - Mitmproxy 
- 8083 - Mitmproxy interface
- 5432 - Postgres
- 


Packages:
- git 
- python3 
- python3-pip 
- iproute2 
- curl 
- netcat
- nano
- cron

Services:
- torsocks
- proxychains4
- obfs4proxy
- pagodo
- ettercap
- postgres
- nmap
- tcpdump
- 

Config:
- crontab
- proxychains4
- torrc
- torsocks
- postgres