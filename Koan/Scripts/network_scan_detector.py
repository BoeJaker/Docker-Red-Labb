from scapy.all import *

def network_scan_detector(pkt):
    # Check if the packet is a TCP SYN packet
    if TCP in pkt and pkt[TCP].flags == 2:
        # Print the source and destination IP addresses and ports
        print("Packet from: %s:%s to %s:%s" % (pkt[IP].src, pkt[TCP].sport, pkt[IP].dst, pkt[TCP].dport))

# Start a packet sniffer using the network_scan_detector function as a callback
sniff(prn=network_scan_detector)