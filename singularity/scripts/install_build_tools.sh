#!/bin/sh

if ! apt-get install -q -y --no-install-recommends \
     autoconf \
     automake \
     gcc \
     g++ \
     libtool-bin \
     make
then
    echo "Failed to install build tools"
    exit 3
fi
