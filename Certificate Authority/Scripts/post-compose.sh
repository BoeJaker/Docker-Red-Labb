#!/bin/bash
# Generate root key and certificate
openssl genpkey -algorithm RSA -out /etc/ssl/root-ca.key
openssl req -x509 -new -nodes -key /etc/ssl/root-ca.key -out /etc/ssl/root-ca.crt -days 36500
openssl x509 -noout -text -in /etc/ssl/root-ca.crt

# Configure OpenSSL to use the root CA configuration
openssl req -x509 -newkey rsa:4096 -out  -outform PEM -keyout /etc/ssl/root-ca.key -days 365 -subj "/C=US/ST=California/L=San Francisco/O=My Organization/CN=My Root CA" -config /etc/ssl/root-ca.cnf
# Configure the web server to serve the root CA certificate
echo "alias /root-ca.crt /etc/ssl/root-ca.crt" >> /etc/lighttpd/lighttpd.conf

# Start the web server
lighttpd -D -f /etc/lighttpd/lighttpd.conf

/usr/bin/bash