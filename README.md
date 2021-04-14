# NPG Docker images

## The images ##

### base/ubuntu/12.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/16.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/18.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### conda/ubuntu/12.04 ###

A Conda package-building image with Conda, conda-build and
conda-verify installed.

### irods/ubuntu/16.04 ###

This is a Docker image of a vanilla iRODS 4.2.7 server that works out
of the box. To be used for running tests only.

### irods/ubuntu/18.04 ###

This is a Docker image of a vanilla iRODS 4.2.8 server that works out
of the box. To be used for running tests only.

## Build instructions ##

A makefile is supplied that will by default build all images and add
metadata to them based on `git describe`.

`cd ./docker`
`make`

# NPG Singularity images

## The images

### singularity/baton/baton-2.1.0 ###

This is a Singularity image of baton 2.1.0 built for iRODS 4.2.7.

## Build instructions ##

A makefile is supplied that will by default build all images and add
metadata to them based on `git describe`.

`cd ./singularity`
`make`

## Author

Keith James kdj@sanger.ac.uk
