#!/bin/bash -x

for sqlfile in /docker-entrypoint-initdb.d/*.sql; do
    echo "Running $sqlfile"
    psql -f $sqlfile
done
