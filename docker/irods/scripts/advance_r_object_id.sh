#!/bin/bash

set -eo pipefail
set -x

service postgresql start

# Start new object IDs above both signed and unsigned 32-bit integer ranges.
sudo -u postgres psql -X -d ICAT -v ON_ERROR_STOP=1 \
    -c 'ALTER SEQUENCE R_ObjectID RESTART WITH 4294967296;'
