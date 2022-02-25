#!/bin/bash

set -ex

CONDA_USER_ID=${CONDA_USER_ID:-1001}
CONDA_USER=${CONDA_USER:-conda}
CONDA_GROUP_ID=${CONDA_GROUP_ID:-32001}
CONDA_INSTALL_DIR=${CONDA_INSTALL_DIR:-/opt/conda}

echo "Starting with USER: $CONDA_USER, " \
     "UID: $CONDA_USER_ID, GID: $CONDA_GROUP_ID"

groupmod --gid $CONDA_GROUP_ID conda

id -u $CONDA_USER >/dev/null 2>&1 ||\
    useradd --shell /bin/bash --uid $CONDA_USER_ID --gid $CONDA_GROUP_ID \
            --non-unique --create-home $CONDA_USER --comment ""

export USER=$CONDA_USER
export HOME=/home/$USER
export LOGNAME=$USER
export MAIL=/var/spool/mail/$USER
export PATH="$CONDA_INSTALL_DIR/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [ ! -e "$HOME/.condarc" ]; then
    cp "$CONDA_INSTALL_DIR/etc/condarc" "$HOME/.condarc"
fi

find /home/$USER -not -user $USER -not -group $USER -print0 |\
    xargs --max-procs 0 --null --no-run-if-empty \
	  chown --no-dereference $USER:$USER

find "$CONDA_INSTALL_DIR" -not -user $USER -not -group conda -print0 |\
    xargs --max-procs 0 --null --no-run-if-empty \
	  chown --no-dereference $USER:conda

chmod g+w "$CONDA_INSTALL_DIR"

exec gosu $USER "$@"
