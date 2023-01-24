#!/bin/bash

set -eu

DOCKER_PREFIX=${DOCKER_PREFIX:?required but was not set}
DOCKER_IMAGE=${DOCKER_IMAGE:?required, but was not set}
TAG=${TAG:?required, but was not set}
EXECUTABLE=${EXECUTABLE:?required, but was not set}

cat << EOF > "$EXECUTABLE"
#!/bin/bash
set -e
DOCKER_PREFIX="$DOCKER_PREFIX" \
DOCKER_IMAGE="$DOCKER_IMAGE" \
TAG="$TAG" \
singularity-run-docker "$EXECUTABLE" "\$@"
EOF
