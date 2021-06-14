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
PYTHON_VERSION=${PYTHON_VERSION:-"39"}
CONDA_VERSION=${CONDA_VERSION:-"4.9.2"}
CONDA_SHA256=${CONDA_SHA256:-"536817d1b14cb1ada88900f5be51ce0a5e042bae178b5550e62f61e223deae7c"}
CONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-py${PYTHON_VERSION}_${CONDA_VERSION}-${OS}-${ARCH}.sh"

# Conda package parameters
CONDA_BUILD_VERSION=${CONDA_BUILD_VERSION:-"3.21.4"}

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

conda install -y jinja2 networkx packaging pyaml setuptools git curl
conda install -y "conda-build=$CONDA_BUILD_VERSION" conda-verify

pip install rfc3987

conda clean -y -st
