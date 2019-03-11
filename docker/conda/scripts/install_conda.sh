#!/bin/bash -il

set -eo pipefail
set -x

trap cleanup EXIT INT TERM

cleanup() {
    local exit_code=$?

    [ -d "$WORK_DIR" ] && rm -rf "$WORK_DIR"
    exit $exit_code
}

make_temp_dir() {
    echo $(mktemp -d /tmp/$(basename -- $0).XXXXXXXXXX)
}

# Conda parameters
OS=${OS:-"Linux"}
ARCH=${ARCH:-"x86_64"}
PYTHON_VERSION=${PYTHON_VERSION:-"3"}
CONDA_VERSION=${CONDA_VERSION:-"4.5.12"}
CONDA_SHA256=${CONDA_SHA256:-"e5e5b4cd2a918e0e96b395534222773f7241dc59d776db1b9f7fedfcb489157a"}
CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda$PYTHON_VERSION-$CONDA_VERSION-$OS-$ARCH.sh"

# Conda package parameters
CONDA_BUILD_VERSION=${CONDA_BUILD_VERSION:-"3.16.3"}

CONDA_INSTALL_DIR=${CONDA_INSTALL_DIR:-/opt/conda}
WORK_DIR=$(make_temp_dir)
curl -sSL $CONDA_URL > "$WORK_DIR/miniconda.sh"
sha256sum "$WORK_DIR/miniconda.sh" | grep $CONDA_SHA256

/bin/sh "$WORK_DIR/miniconda.sh" -b -p "$CONDA_INSTALL_DIR"

source $CONDA_INSTALL_DIR/etc/profile.d/conda.sh
conda activate

conda config --set auto_update_conda False
conda config --set ssl_verify True
conda config --set show_channel_urls True

conda install -y python jinja2 networkx packaging pyaml setuptools
conda install -y "conda-build=$CONDA_BUILD_VERSION" conda-verify

pip install rfc3987

conda clean -y -st
