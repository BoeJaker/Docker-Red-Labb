#!/usr/bin/env nmap

local ssl_cert = require("openssl.x509")
local ssl_socket = require("openssl.ssl")

-- Function to extract the subject and issuer fields from a certificate
function extract_cert_info(cert)
  local subject = cert:subject()
  local issuer = cert:issuer()
  local subject_str = subject:DN()
  local issuer_str = issuer:DN()
  return subject_str, issuer_str
end

-- Function to check if a certificate mismatch occurs
function check_cert_mismatch(host, port)
  local sock = nmap.new_socket()
  sock:connect(host, port)
  local params = {mode = "client", protocol = "tlsv1_2"}
  local ctx = assert(ssl_socket.new_context(params))
  local ssl = assert(ctx:ssl(sock))
  assert(ssl:connect())
  local cert = ssl:peer_certificate()
  local host_subject, host_issuer = extract_cert_info(cert)
  local server_name = host:match("([^.]+)%.(.*)") or host
  local expected_subject = "CN=" .. server_name
  if host_subject ~= expected_subject or host_issuer == host_subject then
    return true
  end
  return false
end

-- Main function that runs the script
function run(host, port)
  if port.protocol == "tcp" and port.state == "open" then
    if port.name == "https" or port.number == 443 then
      if check_cert_mismatch(host.ip, port.number) then
        return "Detected MITM attack"
      end
    end
  end
  return "No MITM detected"
end
