import socket

# Create a socket object
s = socket.socket()

# Define the IP address and port number to listen on
ip_address = '0.0.0.0'
port = 8080

# Bind the socket to the IP address and port number
s.bind((ip_address, port))

# Set the socket to listen for incoming connections
s.listen(1)

# Print a message indicating that the listener is running
print(f'[*] Listening on {ip_address}:{port}')

# Accept incoming connections and handle them
conn, addr = s.accept()
print(f'[*] Connection from {addr[0]}:{addr[1]}')

# Enter a loop to receive and execute commands
while True:
    command = input('$ ')
    conn.send(command.encode())
    output = conn.recv(4096).decode()
    print(output)
