#! /bin/bash 

# Changes the tor network route and endpoint IP

echo -e 'AUTHENTICATE "'+${TOR_CREDS}+'"\r\nsignal NEWNYM\r\nQUIT' | nc 0.0.0.0 9051 ;