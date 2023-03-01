import nmap

import psycopg2


import sys
import getopt

import time    

# Set default variables to placeholder values
scan_id = hash(time.time())
flags = '-sS'
ip ='172.16.0.0/24'

# Create a new nmap object
nm = nmap.PortScanner()

# Run an nmap scan on the target IP or hostname
scan_results = nm.scan(ip, arguments=flags)

# Connect to the database
cnx = psycopg2.connect(user=os.environ.get('POSTGRES_USER'), password=os.environ.get('POSTGRES_PASSWORD'),
                              host='Postgres.pagodo_and_proxychain_internal', port='5432', database=os.environ.get('POSTGRES_DB'))

# Create a new cursor
cursor = cnx.cursor()

# Populate placholder values with commandline args
options, args = getopt.getopt(sys.argv, "h:f:d", longopts=["host =","flag =","drop ="]) 
for name, value in options:
    if name in ['-h', '--host']:
        ip = value
    elif name in ['-f', '--flag']:
        flag = value
    elif name in ['-d', '--drop']:
        cursor.execute('DROP TABLE IF EXISTS nmap_results ;')
        cnx.commit()
    else:
        print(name+"is not an recognised flag. Available options are -h, -f or -d")

# Create table
cursor.execute(
    'DROP TABLE IF EXISTS nmap_results ; \
    CREATE TABLE IF NOT EXISTS nmap_results \
    ( \
    scan_id bigint, \
    name text COLLATE pg_catalog."default", \
    host text COLLATE pg_catalog."default", \
    mac text COLLATE pg_catalog. "default", \
    flags text COLLATE pg_catalog."default", \
    port text COLLATE pg_catalog."default", \
    service text COLLATE pg_catalog."default", \
    version text COLLATE pg_catalog."default", \
    protocol text COLLATE pg_catalog."default", \
    state text COLLATE pg_catalog."default" \
    );'
)
cnx.commit()

# Insert the scan results into the database
query = ("INSERT INTO nmap_results (scan_id, name, host, mac, flags, port, service, version, protocol, state) "
         "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")

for host, host_data in scan_results['scan'].items():
    if host_data.get('tcp'):
        for port, port_data in host_data['tcp'].items():
            if host_data.get("hostnames")[0].get("name"): name = host_data["hostnames"][0]["name"]
            else : name = ""
            if host_data.get("addresses").get("mac"): mac = host_data["addresses"]["mac"]
            else : mac = ""
            protocol = 'tcp'
            service = ""
            version = ""
            state = port_data.get('state')
            data = (scan_id, name, host, mac, flags, port, service, version, protocol, state)
            cursor.execute(query, data)
    else:
        if host_data.get("hostnames")[0].get("name"): name = host_data["hostnames"][0]["name"]
        else : name = ""
        if host_data.get("addresses").get("mac"): mac = host_data["addresses"]["mac"]
        else : mac = ""
        protocol = ''
        service = ""
        version = ""
        port = ''
        state = host_data.get('status').get('state')
        data = (scan_id, name, host, mac, flags, port, service, version, protocol, state)
        cursor.execute(query, data)
        print(host, host_data)

# Commit the changes to the database
cnx.commit()

# Close the cursor and database connection
cursor.close()
cnx.close()
