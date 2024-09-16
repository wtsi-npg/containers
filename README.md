# NPG Docker images

## The images ##

### base/ubuntu/16.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/18.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### base/ubuntu/20.04 ###

A base image with curl and gosu installed, intended for multi-stage
builds where curl is later dropped.

### irods/ubuntu/16.04 ###

This is a Docker image of a vanilla iRODS 4.2.7 server that works out
of the box. To be used for running tests only.

### irods/ubuntu/18.04 ###

This is a Docker image of a vanilla iRODS >=4.2.11 server that works
out of the box. To be used for running tests only.

The server version may be chosen by passing the Docker build argument
`--build-arg IRODS_VERSION=<version>` (default is 4.3.1).

### irods/ubuntu/22.04 ###

This is a Docker image of a vanilla iRODS >=4.3.1 server that works
out of the box. To be used for running tests only.

The server version may be chosen by passing the Docker build argument
`--build-arg IRODS_VERSION=<version>` (default is 4.3.1).

## Build instructions ##

A makefile is supplied that will by default build all images and add
metadata to them based on `git describe`.

    cd ./docker
    make

# NPG Singularity wrappers

Each container that provides command line programs is self-documenting
and is able to install its own proxy wrappers outside of the container,
to allow these programs to be run transparently.

The images include the singularity-wrapper tool which allows programs to
be listed and their wrappers installed. The install target should be set
to a volume mounted into the container and the -p (install prefix) option
of the tool set accordingly. The -h option will show online help.

e.g. Show online help:

    $ docker run wsinpg/ub-18.04-irods-clients-4.2.11:latest \
        singularity-wrapper -h

e.g. List the programs provided by a container:

    $ docker run wsinpg/ub-18.04-irods-clients-4.2.11:latest \
        singularity-wrapper list
    baton-chmod
    ...
    samtools

e.g. Install wrappers to $PREFIX/bin:

    $ docker run -v $PREFIX:/mnt/tmp \
        wsinpg/ub-18.04-irods-clients-4.2.11:latest \
          singularity-wrapper -p /mnt/tmp install

    $ ls $PREFIX/bin
    -rwxr-xr-x 1 kdj staff 406 Apr 12 15:47 baton-chmod
    ...
    -rwxr-xr-x 1 kdj staff 409 Apr 12 15:47 samtools

## Author

Keith James kdj@sanger.ac.uk
