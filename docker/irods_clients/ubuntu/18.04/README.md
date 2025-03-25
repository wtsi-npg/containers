# Ubuntu iRODS clients

## Summary

An image with iRODS clients installed.

 - [iRODS icommands](https://github.com/irods/irods_client_icommands)
 - [baton](https://github.com/wtsi-npg/baton)
 - [samtools](https://github.com/samtools/samtools), with the htslib [iRODS plugin](https://github.com/samtools/htslib-plugins)

This image is intended for use anywhere that container clients are
required. It uses clients supplied by RENCI as Debian packages, or built
from source where packages are not available.

## Usage

The Dockerfile supports these build arguments:

- BASE_IMAGE (defaults to "ubuntu:18.04")
- DOCKER_IMAGE (no default, must be supplied)
- DOCKER_TAG (no default, must be supplied)
- IRODS_VERSION (defaults to the latest usable iRODS version, currently "4.3.1")
- BATON_VERSION (defaults to "4.2.1")
- HTSLIB_VERSION (defaults to "1.18")
- SAMTOOLS_VERSION (defaults to "1.18")
- BCFTOOLS_VERSION (defaults to "1.18")
- HTSLIB_PLUGINS_VERSION (defaults to "201712")

The Dockerfile creates a local user `appuser` with a `UID` of `1000` whose
`IRODS_ENVIRONMENT_FILE` will be
`/home/appuser/.irods/irods_environment.json`.

### As a replacement for native clients

The recommended way to use these clients as a direct replacement for
e.g. the icommands (`ils`, `iget` etc), is via the wrapper script
`irods_client_wrapper.sh` in `irods_clients/scripts`, which relies on
having a container already running. The script should be symlinked,
once for each desired client, to the desired client name:

E.g.

    ln -s irods_client_wrapper.sh ./bin/ils
    ln -s irods_client_wrapper.sh ./bin/iget
    ln -s irods_client_wrapper.sh ./bin/imeta

Executing the script through each of these symlinks will invoke the
respective client within the container.

The `irods_clients/scripts` directory contains an example container
startup script, `start_client_container.sh`. It is intended only as an
example of how to start the container because it mounts the entire
user `$HOME` into it, which is not recommended for security and
performance reasons. Instead, it is prefereable to bring up the
container as part of a Docker Compose configuration, with directory
mounts of a more limited scope.
