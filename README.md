# NPG Docker images

## The images ##

### base/ubuntu/16.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/18.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/centos/7 ###

A base image with gosu installed.

### base/minideb/bullseye

A base image with gosu installed.

### conda/centos/7 ###

A Conda runtime image with Conda installed.

### conda/centos/7/build ###

A Conda build image with Conda and some of its supporting build
packages installed, including conda-build and conda-verify.

### conda/minideb/bullseye ###

A Conda runtime image with Conda installed.

### irods/ubuntu/16.04 ###

This is a Docker image of a vanilla iRODS 4.2.7 server that works out
of the box. To be used for running tests only.

### irods/ubuntu/18.04 ###

This is a Docker image of a vanilla iRODS >=4.2.11 server that works
out of the box. To be used for running tests only.

The server version may be chosen by passing the Docker build argument
`--build-arg IRODS_VERSION=<version>` (default is 4.3.0).

## Build instructions ##

A makefile is supplied that will by default build all images and add
metadata to them based on `git describe`.

    cd ./docker
    make

# NPG Singularity wrappers

This makefile will install proxies for running executables hosted in Docker
containers, using Singularity. Currently, only iRODS client programs are
available by this method.

The default install prefix is `/usr/local`, the default Docker image is
`ub-18.04-irods-clients-4.2.11` and the defaul Docker tag is `latest`. See the
makefile for the configurable options.

## Installation instructions ##

    cd ./singularity
    make install PREFIX=$HOME/.local DOCKER_IMAGE=ub-18.04-irods-clients-4.2.11 TAG=latest`

## Author

Keith James kdj@sanger.ac.uk
