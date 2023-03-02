#!/bin/bash

set -eo pipefail

CLIENT_USER_ID=${CLIENT_USER_ID:-1001}
CLIENT_USER=${CLIENT_USER:-irodsuser}
CLIENT_USER_HOME=${CLIENT_USER_HOME:-"/home/$CLIENT_USER"}

IRODS_ENVIRONMENT_FILE=${IRODS_ENVIRONMENT_FILE:-"$CLIENT_USER_HOME/.irods/irods_environment.json"}

# Create this user, if it does not exist. Do not create a home
# directory in case the home directory of an external user is being
# mounted to the container. An exisiting iRODS environment file may be
# shared with the container in this way, provided the
# IRODS_ENVIRONMENT_FILE environment variable is set appropriately.
id -u $CLIENT_USER >/dev/null 2>&1 ||\
    useradd --shell /bin/bash --uid $CLIENT_USER_ID \
            --non-unique --no-create-home --home "$CLIENT_USER_HOME" $CLIENT_USER --comment ""

export USER=$CLIENT_USER
export HOME="$CLIENT_USER_HOME"
export LOGNAME=$USER
export MAIL=/var/spool/mail/$USER
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

exec gosu $USER "$@"
