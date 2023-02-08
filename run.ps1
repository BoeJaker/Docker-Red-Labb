# Pull Images
docker pull kalilinux/kali-rolling
docker pull mrecco/ettercap
docker pull mitmproxy/mitmproxy
# Close, build, compose
docker compose down ;  docker compose build ; docker compose up