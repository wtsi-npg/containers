# Unofficial NPG Docker images

## The images ##

### base/ubuntu/12.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/16.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### conda/ubuntu/12.04 ###

A Conda package-building image with Conda, conda-build and
conda-verify installed. Additional Dockerfiles exist for this image to
allow variant to be made that support building iRODS 4.1 and iRODS 4.2.

### irods/ubuntu/12.04 ###

This is a Docker image of a vanilla iRODS 4.1.12 server that works out
of the box. To be used for running tests only.

### irods/ubuntu/16.04 ###

This is a Docker image of a vanilla iRODS 4.2.5 server that works out
of the box. To be used for running tests only.

## Build in instructions ##

A makefile is supplied that will by default build all images and add
metadata to them based on `git describe`.

`cd containers`
`make`

## Author

Keith James kdj@sanger.ac.uk
