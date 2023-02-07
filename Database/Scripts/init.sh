#!/bin/bash
initdb 
postgres &
mv /Config/pg_hba.conf /var/lib/postgres/data/pg_hba.conf
/bin/sh