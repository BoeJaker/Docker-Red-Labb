import os
import pty
import select
import psycopg2

# Define database connection parameters
db_config = {
    'dbname': os.environ.get('POSTGRES_DB'),
    'user': os.environ.get('POSTGRES_USER'),
    'password': os.environ.get('POSTGRES_PASSWORD'),
    'host': ' Postgres.pagodo_and_proxychain_internal',
    'port': '5432'
}
log_table="koan_terminal_log"

# Connect to database
db_conn = psycopg2.connect(**db_config)
cursor = db_conn.cursor()
query = 'CREATE TABLE IF NOT EXISTS '+log_table+'(\
    session_output LONGTEXT,\
);'
cursor.execute(query, (output,))
                db_conn.commit()
# Capture output of terminal session and insert into database
def capture_session_output():
    pid, fd = pty.fork()
    if pid == 0:
        # Child process
        os.execvp('/bin/bash', ['/bin/bash'])
    else:
        # Parent process
        while True:
            rlist, _, _ = select.select([fd], [], [])
            if rlist:
                output = os.read(fd, 1024).decode()
                # Insert output into database
                query = 'INSERT INTO '+log_table+' (session_output) VALUES (%s)'
                cursor.execute(query, (output,))
                db_conn.commit()

# Call function to capture output of terminal session
capture_session_output()

# Close database connection
cursor.close()
db_conn.close()