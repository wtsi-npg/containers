#!/bin/bash

set -eo pipefail
set -x

# The iRODS setup script requires the database to be up.
service postgresql start

# Run the iRODS setup script which configures the new server.

case "$IRODS_VERSION" in
    4.1.*)
        /var/lib/irods/packaging/setup_irods.sh < /opt/docker/irods/config/setup_irods.sh.in
        ;;

    4.2.*)
        python /var/lib/irods/scripts/setup_irods.py < /opt/docker/irods/config/setup_irods.py.in
        ;;
    *)
        echo Unknown iRODS version "$IRODS_VERSION"
        exit 1
esac

# Patch the server config to remove the transient hostname of the
# build container and set the server checksum to MD5.
cd /etc/irods/
echo $(jq -f /opt/docker/irods/config/server_config.delta \
          ./server_config.json) > ./server_config.json

# Patch the irods user environment to remove the transient hostname of
# the build container
cd /var/lib/irods/.irods/
echo $(jq -f /opt/docker/irods/config/irods_environment.delta \
          ./irods_environment.json) > ./irods_environment.json

# Fix up the demoResc to use localhost, to avoid the transient
# hostname of the build container being captured in the IES database.
sudo su irods -c "iadmin modresc demoResc host localhost"

# Add a simple test resource named testResc.
mkdir -p /var/lib/irods/iRODS/Vault2
chown irods:irods /var/lib/irods/iRODS/Vault2

sudo su irods -c "iadmin mkresc testResc unixfilesystem localhost:/var/lib/irods/iRODS/Vault2"
sudo su irods -c "iadmin modresc testResc host localhost"

# Add a replication resource named replResc with two replicates, x and
# y.
mkdir -p /var/lib/irods/iRODS/VaultRx
mkdir -p /var/lib/irods/iRODS/VaultRy

chown irods:irods /var/lib/irods/iRODS/VaultRx
chown irods:irods /var/lib/irods/iRODS/VaultRy

sudo su irods -c "iadmin mkresc unixfs1 unixfilesystem localhost:/var/lib/irods/iRODS/VaultRx"
sudo su irods -c "iadmin mkresc unixfs2 unixfilesystem localhost:/var/lib/irods/iRODS/VaultRy"

sudo su irods -c "iadmin modresc unixfs1 host localhost"
sudo su irods -c "iadmin modresc unixfs2 host localhost"

sudo su irods -c "iadmin mkresc replResc replication"
sudo su irods -c "iadmin addchildtoresc replResc unixfs1"
sudo su irods -c "iadmin addchildtoresc replResc unixfs2"

# Put version-specific hackery here
case "$IRODS_VERSION" in
    4.2.7)
        echo Applying workaround for https://github.com/irods/irods/issues/4672 in iRODS 4.2.7
        cd /tmp
        for user in public rodsadmin
        do
            sudo su postgres -c "echo \"insert into r_user_group (group_user_id, user_id, create_ts, modify_ts) select user_id, user_id, NOW(), NOW() from R_USER_MAIN where user_name = '${user}'\" | psql -d ICAT"
        done
        ;;
    *)
        echo No version-specific configuration for "$IRODS_VERSION"
esac
