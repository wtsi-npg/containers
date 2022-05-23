#!/bin/bash -l

set -eo pipefail
set -x

# The iRODS client version should match the server version
IRODS_VERSION=${IRODS_VERSION:-"4.2.11"}
# The baton version should generally be the most recent release
BATON_VERSION=${BATON_VERSTION:-"3.2.0"}

# You can use these defaults with a Conda container built from ./docker/conda
# in this repository
CONDA_INSTALL_DIR=${CONDA_INSTALL_DIR:-/opt/conda}
CONDA_ENVIRONMENT=${CONDA_ENVIRONMENT:-irods}

source $CONDA_INSTALL_DIR/etc/profile.d/conda.sh
conda list -n ${CONDA_ENVIRONMENT} || conda create -n ${CONDA_ENVIRONMENT}
conda install -y -c https://dnap.cog.sanger.ac.uk/npg/conda/devel/generic/ \
    -n ${CONDA_ENVIRONMENT} "baton=${BATON_VERSION}"
