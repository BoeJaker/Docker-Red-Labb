-- Define a function that will be called for each packet that is captured
function packet_callback(packet)
    local src_ip = packet.src_ip
    local dst_ip = packet.dst_ip
    local protocol = packet.protocol

    -- Setup database config
    local database_name = os.getenv("POSTGRES_DATABASE")
    local database_user = os.getenv("POSTGRES_USER")
    local database_password = os.getenv("POSTGRES_PASSSWORD)
    local database_host = os.getenv("POSTGRES_HOST")

    -- Connect to the database
    local db = require "luasql.postgres"
    local env = db.postgres()
    local con = env:connect(database_name, database_user, database_password, database_host)
  
    local query = string.format("CREATE TABLE [IF NOT EXISTS] table_name ( \
                                id serial PRIMARY KEY, \
                                src_ip VARCHAR(20) column_contraint, \
                                dst_ip VARCHAR(20) column_contraint, \
                                protocol VARCHAR(40) column_contraint, \
                                table_constraints \
                                ); ")
                                
    local result =con:execute(query)
    -- Insert the packet information into the database
    local query = string.format("INSERT INTO packets (src_ip, dst_ip, protocol) VALUES ('%s', '%s', '%s')", src_ip, dst_ip, protocol)
    local result = con:execute(query)
  
    -- Check if the insertion was successful
    if result then
      io.write("Inserted packet into the database.\n")
    else
      io.write("Failed to insert packet into the database.\n")
    end
  
    -- Close the database connection
    con:close()
    env:close()
  end
  
  -- Register the packet callback function to be called for each packet
  register_packet_filter(packet_callback)
  