-- Metasploit database --
-- DROP DATABASE IF EXISTS msf_database; -- remove comment on this line as required -- --
CREATE DATABASE msf_database ;
CREATE USER msf_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE msf_database TO msf_user;

CREATE DATABASE metabase_database ;
CREATE USER metabase_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE metabase_database TO metabase_user;

CREATE DATABASE cve_database ;
CREATE USER cve_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE cve_database TO cve_user;

CREATE DATABASE cve_database ;
CREATE USER cve_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE cve_database TO cve_user;

-- Nmap database --
-- Declared in: Koan/Scripts/Nmap/log_to_database --
DROP TABLE IF EXISTS nmap_results; -- comment out this line as required --
CREATE TABLE IF NOT EXISTS nmap_results (
    scan_id bigint COLLATE pg_catalog."default",
    name text COLLATE pg_catalog."default",
    host text COLLATE pg_catalog."default",
    mac text COLLATE pg_catalog."default",
    flags text COLLATE pg_catalog."default",
    port text COLLATE pg_catalog."default",
    protocol text COLLATE pg_catalog."default",
    state text COLLATE pg_catalog."default",
    CONSTRAINT nmap_pkey PRIMARY KEY (scan_id)
);

-- Ettercap database --
-- Declared in: Koan/Scripts/Ettercap/log_to_database --
DROP TABLE IF EXISTS ettercap_results; -- comment out this line as required --
CREATE TABLE IF NOT EXISTS ettercap_results (
    scan_id bigint COLLATE pg_catalog."default",
    name text COLLATE pg_catalog."default",
    host text COLLATE pg_catalog."default",
    mac text COLLATE pg_catalog."default",
    flags text COLLATE pg_catalog."default",
    port text COLLATE pg_catalog."default",
    protocol text COLLATE pg_catalog."default",
    state text COLLATE pg_catalog."default",
    CONSTRAINT ettercap_pkey PRIMARY KEY (scan_id)
);

-- Network scan detector database --
-- Declared in: Koan/Scripts/Detectors/network_scan_detector.py --
DROP TABLE IF EXISTS network_scan_detections; -- comment out this line as required --
CREATE TABLE IF NOT EXISTS network_scan_detections (
    source_ip text COLLATE pg_catalog."default",
    source_port text COLLATE pg_catalog."default",
    target_ip text COLLATE pg_catalog."default",
    target_port text COLLATE pg_catalog."default"
);
