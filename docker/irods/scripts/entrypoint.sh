#!/bin/bash -l

set -ex

# This no-op entrypoint exists to avoid the following type of error on ARM-based Macs:
#
# /usr/bin/env: ‘/mnt/lima-rosetta/rosetta’: No such file or directory
#
# This particular error example is triggered by iRODS' Python startup script when
# an iRODS Docker container is run using Rancher Desktop. Similar errors occur with
# Docker Desktop.
#
# Be careful if you decide to remove it.

exec "$@"
