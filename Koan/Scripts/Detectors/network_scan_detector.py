# Run with sudo - even if you are root
from scapy.all import *
import os
import psycopg2

# Connect to the database
cnx = psycopg2.connect(user=os.environ.get('POSTGRES_USER'), password=os.environ.get('POSTGRES_PASSWORD'),
                              host='Postgres.pagodo_and_proxychain_internal', port='5432', database=os.environ.get('POSTGRES_DB'))

# Create a new cursor
cursor = cnx.cursor()

# Create table
cursor.execute(
    'CREATE TABLE IF NOT EXISTS network_scan_detections \
    ( \
    source_ip text COLLATE pg_catalog."default", \
    source_port text COLLATE pg_catalog."default", \
    target_ip text COLLATE pg_catalog. "default", \
    target_port text COLLATE pg_catalog."default" \
    );'
)
cnx.commit()

query = ("INSERT INTO network_scan_results (source_ip, source_port, target_ip, target_port) "
         "VALUES (%s, %s, %s, %s)")

def network_scan_detector(pkt):
    # Check if the packet is a TCP SYN packet
    if TCP in pkt and pkt[TCP].flags == 2:
        # Print the source and destination IP addresses and ports
        # print("Packet from: %s:%s to %s:%s" % (pkt[IP].src, pkt[TCP].sport, pkt[IP].dst, pkt[TCP].dport))
        # print("Network scan detected - Logged to OSINT database")
        data = (pkt[IP].src, pkt[TCP].sport, pkt[IP].dst, pkt[TCP].dport)
        cursor.execute(query, data)
        cnx.commit()
# Start a packet sniffer using the network_scan_detector function as a callback
sniff(iface="eth1",prn=network_scan_detector)