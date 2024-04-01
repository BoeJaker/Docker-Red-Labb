# import docker
# import requests

# # Initialize Docker client
# docker_client = docker.from_env()

# # Guacamole API endpoint
# GUACAMOLE_API_URL = 'http://192.168.3.201:8080/guacamole/api'

# # Guacamole credentials
# GUACAMOLE_USERNAME = 'guacadmin'
# GUACAMOLE_PASSWORD = 'guacadmin'

# # Function to authenticate with Guacamole API
# def authenticate_guacamole():
#     auth_response = requests.post(
#         f"{GUACAMOLE_API_URL}/tokens",
#         data={'username': GUACAMOLE_USERNAME, 'password': GUACAMOLE_PASSWORD}
#     )
#     auth_response.raise_for_status()
#     return auth_response.json()['authToken']

# # Function to add Docker hosts to Guacamole
# def add_docker_hosts_to_guacamole():
#     auth_token = authenticate_guacamole()
#     print(auth_token)
#     headers = {'Authorization': f'Bearer {auth_token}'}

#     for container in docker_client.containers.list():
#         # Extract container details
#         container_name = container.name
#         container_ip = container.attrs['NetworkSettings']['IPAddress']
        
#         # Create connection
#         connection_data = {
#             "name": container_name,
#             "protocol": "ssh",
#             "parameters": {
#                 "hostname": container_ip,
#                 "port": 22,
#                 "username": "your_ssh_username",  # Change as needed
#                 "password": "your_ssh_password"   # Change as needed
#             }
#         }

#         # Add connection to Guacamole
#         connection_response = requests.post(
#             f"{GUACAMOLE_API_URL}/session/data/postgresql/connections",
#             json=connection_data,
#             headers=headers
#         )
#         connection_response.raise_for_status()

#         print(f"Added container {container_name} with IP {container_ip} to Guacamole.")

# # Execute function to add Docker hosts to Guacamole
# add_docker_hosts_to_guacamole()


import psycopg2
import docker
# from dotenv import dotenv_values

password="xxxxxxxx" #dotenv_values("~/BACKUPS/Master/Dev/Docker_Containers/Production/Docker-Red-Lab/Guacamole/guac_service_discovery/.env")
    
# Function to connect to the database
def connect_to_database():
    return psycopg2.connect(
        host="10.0.5.4",
        port=5432,
        database="guacamole_database",
        user="postgres",
        password="your_password_here"
    )

# Function to check if a connection exists in the database
def connection_exists(connection_name):
    conn = connect_to_database()
    cur = conn.cursor()
    cur.execute("SELECT EXISTS(SELECT 1 FROM guacamole_connection WHERE connection_name = %s)", (connection_name,))
    exists = cur.fetchone()[0]
    cur.close()
    conn.close()
    return exists

# Function to insert a new connection into the Guacamole database
def insert_connection(connection_name, protocol, hostname, port, username, password, command=""):
    if connection_exists(connection_name):
        print(f"Connection '{connection_name}' already exists in the database. Skipping.")
        return

    conn = connect_to_database()
    cur = conn.cursor()

    try:
        cur.execute("""
            INSERT INTO guacamole_connection
            (connection_name, protocol)
            VALUES (%s, %s)
            RETURNING connection_id;
        """, (connection_name, protocol))

        connection_id = cur.fetchone()[0]

        cur.execute("""
            INSERT INTO guacamole_connection_parameter
            (connection_id, parameter_name, parameter_value)
            VALUES (%s, %s, %s);
        """, (connection_id, 'hostname', hostname))

        cur.execute("""
            INSERT INTO guacamole_connection_parameter
            (connection_id, parameter_name, parameter_value)
            VALUES (%s, %s, %s);
        """, (connection_id, 'port', str(port)))

        cur.execute("""
            INSERT INTO guacamole_connection_parameter
            (connection_id, parameter_name, parameter_value)
            VALUES (%s, %s, %s);
        """, (connection_id, 'username', username))

        cur.execute("""
            INSERT INTO guacamole_connection_parameter
            (connection_id, parameter_name, parameter_value)
            VALUES (%s, %s, %s);
        """, (connection_id, 'password', password))

        cur.execute("""
            INSERT INTO guacamole_connection_parameter
            (connection_id, parameter_name, parameter_value)
            VALUES (%s, %s, %s);
        """, (connection_id, 'command', command))

        conn.commit()

        print("Connection added successfully.")
    except psycopg2.Error as e:
        print("Error:", e)
        conn.rollback()
    finally:
        cur.close()
        conn.close()

# Function to enumerate Docker hosts and add them as connections
def add_docker_hosts_as_connections():
    # global password
    docker_client = docker.DockerClient(base_url='unix://var/run/docker.sock')
    
    for container in docker_client.containers.list():
        container_name = container.name
        container_ip = container.attrs['NetworkSettings']['IPAddress']

        # Insert the Docker container as a Guacamole connection
        insert_connection(
            connection_name=container_name,
            protocol='ssh',  # Adjust protocol as needed
            hostname="192.168.3.201", #container_ip
            port=22,  # Adjust port as needed
            username='boejaker',  # Adjust username as needed
            password=password,  # Adjust password as needed
            command=f"docker exec -it {container_name} bash"
        )

# Example usage
add_docker_hosts_as_connections()
