-- WORK IN PROGRESS --
<br />

# Homebrew Docker Lab
## Overview
This docker container network is intended for security research only
<br />
These containers use no linked volumes, this prevents file injection onto the contaianers host.
<br />
<br />
# Components
## [Koan Proxy & Firewall](Koan)
Traffic obfuscator, firewall, multi-proxy and packet capture / replay tool <br/>
The less noise you make the more you hear.
<br/>
### Description
This container routes traffic through a chain of proxies, first Mitm, then Koan (Tor).<br/>
It captures packets traveling either way between this network and the internet
encrypts traffic filters packets and routes through tor. <br/>
Using ettercap this containier can create an endpoint that pretends to be a networks gateway - capturing all traffic and providing a mitm injection point. 

### Iptables Configuration

### Network Scan detection
Koan can operate as an intrusion detextion mecanism for its own, and/or remote networks. It logs sources and destinations of all syn packets recieved on the LAN. 

### Packages
The packages installed on this container are as follows:

- [proxychains]()
- [tor]()
- [mitmproxy]()
- [ettercap]()
- [tcpdump]()
- [nyx]()

<br/>
<hr/>
<br/>

## [Certificate authority & DNS Server](DNS%20Server)
Secures local network communications using RSA key pairs and encryption as well as resolving internal domain names.


<br/>
<hr/>
<br/>


## [Houston](houston)
### Command and control
This container provides a gui that is accesible though a web browser and a flexible kali installation.

### OSINT Scanner
Automatically scans the internet looking for vulnerabilities
- [pagodo]()
- [masscan]()
- [nmap]()
- [traceroute]()
- [sqlmap](https://sqlmap.org/)

<br/>
<hr/>
<br/>

## [OSINT Database](database)
### A database of exploits, vulnerabilities and other OSINT gathered by houston. 
You can set a volume to make the database persistant <br/>
Post-processors for each tool to log to sql

- nmap_results
- network_scan_detections
## Source_Data Database
An index of domains, passwords, usernames and historical data such as the carna dataset 

<br/>
<hr/>
<br/>

# Usage guide - docker compose -

## Pre-requisites & Setup

### Passwords
Edit the secrets.txt.dummy files to contain your passwords for each container and remove the dummy extension. Then run the following commands:

    docker secret create koan_user_password koan_secrets.txt
    docker secret create housten_user_password housten_secrets.txt
    docker secret create postgres_user_password postgres_secrets.txt

### Environment variables
Edit the .env.dummy file, insert your variables and remove the .dummy extension from the filename.

### Enabling optional features
This is the point to enable any optional features you would like in the final build. 
These features are:
- Housten vnc
- Housten novnc
- CA/DNS
- Filespace encryption 

### Build the system
Use the run.ps1 or run.sh scripts to install dependancies and compose, or; Docker pull each image 
from the compose file manually. Then open a terminal in this directory and execute the following:

    docker compose build -t image_name ; docker compose up -d

### Encryption & Keys
There are various built in mechanisms for encryption, they all rely upon keys and certificates generated and signed when the system is composed. To encrypt the filespace.
Beyond this extra encyption of the database is posisble.
The pregenerated keys and certs are used to form a VPN, communicate over ssh and other protocols.  



Ports:
- Koan 9150 - Tor traffic socket
- Koan 9051 - Tor control socket
- Koan 8080 - Mitmproxy listen
- Koan 8081 - Mitmproxy 
- Koan 8083 - Mitmproxy interface
- Koan 80 - Proxychains listen

- Houston 8888 - NoVNC
- Houston 5900 - VNC

- Postgres 5432 - Postgres database

- CA 80 - Certificate authority signing service
- CA 53/TCP - DNS
- CA 53/UDP - DNS


<br/>

database users:
- postgres
- msf_user

<br/>

Tables:
- msf_database
- nmap_results
- ettercap_results
- network_scan_detections
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