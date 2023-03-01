# Koan Proxy (MITM)
## Traffic obfuscator, firewall, multi-proxy and packet capture / replay tool - The less noise you make the more you hear.
<br>

update-alternatives --config iptables 

To build on its own enter the following into a terminal:
 
    docker build --cap-add=ALL -t Koan . 

To save as an image:

    docker commit koan boejaker/koan:latest

## Functions

<br/>

### Proxychain routing
Proxychain  is setup by default all packets recieved are routed through the proxychain 

<br/>

### MITM Packet Monitor
The first link in the proxychain is MITMproxy, it allows introspection of packets as they travel the network

<br/>

### Tor network routing
Tor can be used as part of the proxychain

<br/>

### Network scan monitoring

<br/>

### DNS leak test
Tests for DNS request leaks

<br/>

### IPV6 leak test
Test for IPV6 leaks

### Networking Tools
- Proxychains4
- Tor
- Mitmproxy
- TCPdump
- Ettercap + Scripts
- dsniff, arpspoof
- Nmap
- SQLmap

## Init order of operation:
For refrence this is the order dependancies, configurations and scripts are loaded or run
<br/>

### Dockerfile
- Download & install dependancies
- Set scripts to be run on login
- Encryption key generation /Scripts/Server_keyGen.sh
- User generation

### Docker compose
- Set open ports
- Bind volumes
- Set entrypoint

### Login
- /Scripts/Init/Routing.sh
- /Scripts/Init/post-compose-check.sh

### Packet flow
- Packet is recived from internal interface,
- Packet routed thorugh MITMproxy, 
- Packet routed through Proxychains / Tor