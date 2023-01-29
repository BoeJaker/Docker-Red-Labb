#! /bin/bash 

echo -e 'AUTHENTICATE "'+${TOR_CREDS}+'"\r\nsignal NEWNYM\r\nQUIT' | nc 0.0.0.0 9051 ;