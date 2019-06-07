#!/bin/bash

set -eo pipefail
set -x

service postgresql start

sudo -u postgres createuser -D -R -S irods
sudo -u postgres createdb -O irods ICAT
sudo -u postgres sh -c "echo \"ALTER USER irods WITH PASSWORD 'irods'\" | psql"
