#!/bin/bash

set -eo pipefail

service postgresql start

echo "Waiting for PostgreSQL to become ready ..."
while true
do
    pg_isready >/dev/null && break
    sleep 1
done
echo "PostgreSQL is ready"


service irods start

echo "Waiting for iRODS to become ready ..."
while true
do
    service irods status | grep "irodsServer" >/dev/null && break
    sleep 1
done
echo "iRODS is ready"

exec gosu irods /bin/bash -c "sleep infinity"
