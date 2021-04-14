#!/bin/sh

if ! apt-get install -q -y --no-install-recommends \
     apt-transport-https \
     curl \
     gnupg-agent
then
    echo "Failed to install apt tools"
    exit 3
fi
