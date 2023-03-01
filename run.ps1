
# This script installs dependancies for the compose file

# Pull Images
docker pull kalilinux/kali-rolling
# docker pull mrecco/ettercap
docker pull theanurin/luksoid
# Koan Proxy - base image
docker pull mitmproxy/mitmproxy
# Honeypot system
docker pull lyrebird/honeypot-base

# Close, build, compose
docker compose down ;  docker compose build ; docker compose up