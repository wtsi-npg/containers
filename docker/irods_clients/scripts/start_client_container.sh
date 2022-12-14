#!/bin/bash

# This script starts a container hosting iRODS clients and is intended to be
# used in conjunction with the corresponding iRODS client wrapper to emulate
# having installed clients.

set -eo pipefail

# The iRODS client version should match the server version
IRODS_VERSION=${IRODS_VERSION:-"4.2.11"}
IRODS_ENVIRONMENT_FILE=${IRODS_ENVIRONMENT_FILE:-"$HOME/.irods/irods_environment.json"}

DOCKER_TAG=${DOCKER_TAG:-latest}
DOCKER_IMAGE=${DOCKER_IMAGE:-"wsinpg/ub-18.04-irods-clients-${IRODS_VERSION}:${DOCKER_TAG}"}

# The default container name matches that used by the irods_client_wrapper.sh
# script
DOCKER_CONTAINER=${DOCKER_CONTAINER:-"irods-clients"}
DOCKER_NETWORK=${DOCKER_NETWORK:-host}
CLIENT_USER_ID=${CLIENT_USER_ID:-$(id -u)}
CLIENT_USER=${CLIENT_USER:-$USER}
CLIENT_USER_HOME=${CLIENT_USER_HOME:-"$HOME"}

docker run -d --name "$DOCKER_CONTAINER" --network "$DOCKER_NETWORK" \
       -v "$HOME":"$HOME":rw \
       -e CLIENT_USER_ID=$CLIENT_USER_ID \
       -e CLIENT_USER=$CLIENT_USER \
       -e CLIENT_USER_HOME="$CLIENT_USER_HOME" \
       -e IRODS_ENVIRONMENT_FILE="$IRODS_ENVIRONMENT_FILE" \
       "$DOCKER_IMAGE" /bin/bash -c 'sleep infinity'
