# Ubuntu iRODS client development

## Summary

An image aimed at development of command line iRODS clients.

 - C development tools, including GCC, GDB, autoconf, automake, libtool
   pkg-config and valgrind.
 - [iRODS runtime and development packages](https://github.com/irods/irods)
 - [iRODS icommands](https://github.com/irods/irods_client_icommands)
 - [Dependencies required by baton](https://github.com/wtsi-npg/baton)
 
This image is intended for use anywhere that iRODS C clients are built.

## Usage

This image will create a development container suitable for
[baton](https://github.com/wtsi-npg/baton) and other iRODS clients.

The Dockerfile supports two build arguments:

- BASE_IMAGE (defaults to "ubuntu:bionic")
- IRODS_VERSION (defaults to "4.2.11")
