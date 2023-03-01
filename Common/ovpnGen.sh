openssl req -new -newkey rsa:4096 -days 365 -nodes -keyout /etc/openvpn/client.key -out /etc/openvpn/client.csr -subj "/C=US/ST=CA/L=San Francisco/O=Example Company/OU=IT Department/CN=example.com/emailAddress=admin@example.com"
openssl x509 -req -in /etc/openvpn/server.csr -CA /etc/openvpn/ca.crt -CAkey /etc/openvpn/ca.key -CAcreateserial -out /etc/openvpn/client.crt
clientKey=/etc/openvpn/client.key
clientCert=/etc/openvpn/client.crt
echo "\
client \
proto udp \
remote Koan.pagodo_and_proxychain_internal \
port 1194 \
dev tun \
nobind \
\
key-direction 1 \
\
<ca> \
-----BEGIN CERTIFICATE-----"

"-----END CERTIFICATE-----
</ca>

<cert>
-----BEGIN CERTIFICATE-----"
# insert base64 blob from client1.crt
"-----END CERTIFICATE-----
</cert>

<key>
-----BEGIN PRIVATE KEY-----
# insert base64 blob from client1.key
-----END PRIVATE KEY-----
</key>

<tls-auth>
-----BEGIN OpenVPN Static key V1-----
# insert ta.key
-----END OpenVPN Static key V1-----
</tls-auth>" > /client.ovpn