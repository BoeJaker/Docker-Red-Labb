\
    #!/bin/bash

    ## Generate VPN certs

    ## Easy rsa method
    # mkdir ~/easy-rsa
    # ln -s /usr/share/easy-rsa/* ~/easy-rsa
    # cd ~/easy-rsa
    # printf("set_var EASYRSA_ALGO 'ec' set_var EASYRSA_DIGEST 'sha512'") > ./vars
    # ./easyrsa init-pki
    # ./easyrsa gen-req server nopass
    # cp /root/easy-rsa/pki/private/server.key /etc/openvpn/server/
    # scp /root/easy-rsa/pki/reqs/server.req root@ca_authority.pagodo_and_proxychain_internal:/tmp
    
    sudo openvpn --genkey secret /etc/openvpn/ta.key
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -keyout /etc/openvpn/ca.key -out /etc/openvpn/ca.crt -subj "/C=US/ST=CA/L=San Francisco/O=Example Company/OU=IT Department/CN=example.com/emailAddress=admin@example.com"

    openssl dhparam -out /etc/openvpn/dh.pem 4096
    openssl req -new -newkey rsa:4096 -days 365 -nodes -keyout /etc/openvpn/server.key -out /etc/openvpn/server.csr -subj "/C=US/ST=CA/L=San Francisco/O=Example Company/OU=IT Department/CN=example.com/emailAddress=admin@example.com"
    openssl x509 -req -in /etc/openvpn/server.csr -CA /etc/openvpn/ca.crt -CAkey /etc/openvpn/ca.key -CAcreateserial -out /etc/openvpn/server.crt