-- WORK IN PROGRESS --


# Layers


## Koan Proxy
### Traffic obfuscator and firewall - The less noise you make the more you hear.
This container encrypts traffic and routes it through tor, filters packets 

## Mitm Proxy
### Packet capture & replay tool
This container captures packets traveling either way between this network and the internet

## Proxychains
### 
This container routes traffic through a chain of proxy, first Mitm, then Koan (Tor)

## Houston
### Command and control
This container provides a gui that is accesible though a web browser and a flexible kali installation

## Database
### A persistant database of exploits, vulnerabilities and OSINT

# Usage

Open a terminal in this directory and execute the following:

    docker compose build -t obfuscated

To start the container with full priveleges:

    docker run -ti --cap-add=NET_ADMIN obfuscated

To compose with environment variables:

    docker compose up

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