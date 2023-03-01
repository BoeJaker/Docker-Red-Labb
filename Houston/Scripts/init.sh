printf "development:
  adapter: postgresql 
  database: \"${POSTGRES_DB}\"
  username: \"${POSTGRES_USER}\"
  password: \"${POSTGRES_PASSWORD}\"
  host: Postgres.pagodo_and_proxychain_internal
  port: 5432
  pool: 5
  timeout: 5" > /usr/share/metasploit-framework/config/database.yml
