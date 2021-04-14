#!/bin/sh

if ! apt-get remove -q -y \
     apt-transport-https \
     curl \
     gnupg-agent
then
    echo "Failed to uninstall apt tools"
    exit 3
fi
