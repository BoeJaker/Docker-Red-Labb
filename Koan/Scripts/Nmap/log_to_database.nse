local pg = require "luapgsql", "luarocks.loader"
local shortport = require "shortport"
local stdnse = require "stdnse"
local table = require "table"
local nmap = require "nmap"

-- Define the PostgreSQL connection parameters
local database = os.getenv("POSTGRES_DATABASE")
local user = os.getenv("POSTGRES_USER")
local password = os.getenv("POSTGRES_PASSSWORD")
local host = os.getenv("POSTGRES_HOST")
local port = 5432

-- Connect to the PostgreSQL database
local conn = pg.connectdb(string.format("host=%s port=%d dbname=%s user=%s password=%s", host, port, database, user, password))

-- Create the table if it does not exist
conn:exec([[
  CREATE TABLE IF NOT EXISTS scan_results (
    id SERIAL PRIMARY KEY,
    ip TEXT,
    port INTEGER,
    protocol TEXT,
    state TEXT,
    reason TEXT,
    output TEXT
  );
]])

-- Define the action function to log scan results to the database
local function log_to_database(host, port, result)
  local ip = host.ip
  local protocol = shortport.protocol(port)
  local state = result.state
  local reason = result.reason
  local output = stdnse.serialize(result)

  -- Build and execute the SQL query to insert the scan result into the database
  local query = string.format("INSERT INTO scan_results (ip, port, protocol, state, reason, output) VALUES ('%s', %d, '%s', '%s', '%s', '%s')", ip, port.number, protocol, state, reason, output)
  conn:exec(query)
end

-- Register the action function to log scan results to the database
action = function(host, port)
  local result = nmap.get_port_state(host, port)
  log_to_database(host, port, result)
end

-- Close the PostgreSQL connection when the script finishes
function cleanup()
  conn:finish()
end
