#!/bin/sh

# Adapted from:
#
# https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
#
# Add a local using the USER and UID passed in, or fallback.

UID=${UID:-1001}
USER=${USER:-user}

echo "Starting with USER: $USER, UID: $UID"

useradd --shell /bin/bash --uid $UID \
        --non-unique --create-home $USER --comment ""

export HOME=/home/$USER
chown $USER:$USER $HOME

exec gosu $USER "$@"
