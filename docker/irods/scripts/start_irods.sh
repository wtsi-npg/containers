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

case "$IRODS_VERSION" in
    4.3.4|4.3.5)
        echo "Starting iRODS in test mode ..."
        export IRODS_ENABLE_TEST_MODE=1
        gosu irods /var/lib/irods/irodsctl start --test
        exec tail -n +1 -F /var/lib/irods/log/test_mode_output.log
        ;;
    *)
        echo "Starting iRODS ..."
        gosu irods /var/lib/irods/irodsctl start
        while true; do
            shopt -s nullglob
            logs=(/var/lib/irods/log/rodsLog*)
            shopt -u nullglob

            [ "${#logs[@]}" -gt 0 ] && exec tail -n +1 -F "${logs[@]}"
            sleep 1
        done
        ;;
esac
