#!/bin/bash

set -eo pipefail
set -x

# The iRODS setup script requires the database to be up.
service postgresql start

# Run the iRODS setup script which configures the new server.
python /var/lib/irods/scripts/setup_irods.py < /opt/docker/irods/config/setup_irods.py.in

# Patch the server config to:
#
# Remove the transient hostname of the build container
#
# Set the server checksum to MD5
cd /etc/irods/
echo $(jq -f /opt/docker/irods/config/server_config.delta \
          ./server_config.json) > ./server_config.json

# Patch the irods user environment to:
#
# Remove the transient hostname of the build container
cd /var/lib/irods/.irods/
echo $(jq -f /opt/docker/irods/config/irods_environment.delta \
          ./irods_environment.json) > ./irods_environment.json

# Remove the demoResc to avoid the transient hostname of the build
# container being captured in the IES database.
sudo su irods -c "iadmin rmresc demoResc"

# Also remove mentions of demoResc from the iRODS rules
cp /etc/irods/core.re /etc/irods/core.re.orig
grep -v demoResc /etc/irods/core.re.orig > /etc/irods/core.re

mkdir -p /var/lib/irods/iRODS/Vault2
chown irods:irods /var/lib/irods/iRODS/Vault2

sudo su irods -c "iadmin mkresc unixfs1 unixfilesystem localhost:/var/lib/irods/iRODS/Vault"
sudo su irods -c "iadmin mkresc unixfs2 unixfilesystem localhost:/var/lib/irods/iRODS/Vault2"

sudo su irods -c "iadmin modresc unixfs1 host localhost"
sudo su irods -c "iadmin modresc unixfs2 host localhost"

sudo su irods -c "iadmin mkresc testResc replication"
sudo su irods -c "iadmin addchildtoresc testResc unixfs1"
sudo su irods -c "iadmin addchildtoresc testResc unixfs2"
