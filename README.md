-- WORK IN PROGRESS --


# Modules
## Ubuntu Koan
A quiet flavour of ubuntu - the less noise you make the more you hear.
## MITM Proxy
Packet capture tool
## Database
    

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