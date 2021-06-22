#!/bin/sh

# Adapted from:
#
# https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
#
# Add a local user using USER_NAME and USER_ID passed in, or fallback to
# default user name "duser" and default user ID 1001.

USER_ID=${USER_ID:-1001}
USER_NAME=${USER_NAME:-duser}

echo "Starting with USER: $USER_NAME, UID: $USER_ID"

useradd --shell /bin/bash --uid $USER_ID \
        --non-unique --create-home $USER_NAME --comment ""

export HOME=/home/$USER_NAME
chown $USER_NAME:$USER_NAME $HOME

exec gosu $USER_NAME "$@"
