#!/bin/bash

# Database setup
# initdb 
postgres &

# Cryptographic key generation - These can be used to authenticate communications and encrypt locally sotred data
# ssh-keygen -t rsa -b 4096 -f /Keys/link-key
# echo "Your public key is below. Please save it somewhere easy to access"
# cat /id_rsa.pub

/bin/sh