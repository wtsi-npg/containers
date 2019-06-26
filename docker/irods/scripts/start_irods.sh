#!/bin/bash

set -eo pipefail

echo "Starting PostgreSQL ..."
service postgresql start

echo "Waiting for PostgreSQL to become ready ..."
while true
do
    if command -v pg_isready >/dev/null 2>&1; then
        pg_isready --quiet && break
    else
        # pg_isready is not available on the older PostgreSQL on
        # Ubuntu Precise
        service postgresql status | \
            grep -e "Running clusters: 9.1/main" && break
    fi

    sleep 1
done

echo "PostgreSQL is ready"

# iRODS 4.1.12 startup usually fails here, even after PostgreSQL is
# accepting connections. The service script gives the error:
#
# RuntimeError: get_current_schema_version: failed to find result line
# for schema_version
#
# The lack of resilience means that we have to fall back on a sleep.
echo "Starting iRODS ..."
while true
do
    service irods start >/dev/null && break
    sleep 5
done

echo "Waiting for iRODS to become ready ..."
while true
do
    service irods status | grep "\bProcess" >/dev/null && break
    sleep 1
done
echo "iRODS is ready"

exec gosu irods /bin/bash -c "sleep infinity"
