#!/bin/bash

set -ex

GOSU_VERSION=${GOSU_VERSION:-1.14}
ARCH=${ARCH:-amd64}
PREFIX=${PREFIX:-/usr/local}

gpg --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4

curl -sSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$ARCH" -o /tmp/gosu
curl -sSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$ARCH.asc" -o /tmp/gosu.asc

gpg --verify /tmp/gosu.asc
rm /tmp/gosu.asc

mv /tmp/gosu "$PREFIX/bin/gosu"
chmod +x "$PREFIX/bin/gosu"
