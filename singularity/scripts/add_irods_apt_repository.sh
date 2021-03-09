#!/bin/sh

if ! curl -sSL $IRODS_PACKAGES_URL/irods-signing-key.asc | apt-key add -
then
    echo "Failed to fetch the iRODS package signing key"
    exit 3
fi

if ! echo "deb [arch=amd64] $IRODS_PACKAGES_URL/apt $UBUNTU_RELEASE main" > \
     /etc/apt/sources.list.d/renci-irods.list
then
    echo "Failed to add the iRODS apt repository"
    exit 3
fi    

if ! apt-get update
then
    echo "apt-get update failed"
    exit 3
fi
