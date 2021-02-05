#!/usr/bin/env bash

set -eo pipefail

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${currentDir}"/base.sh

trap 'exit $SYSTEM_FAILURE_EXIT_CODE' ERR

if podman inspect "$CONTAINER_ID" >/dev/null 2>&1; then
    podman kill "$CONTAINER_ID"
    podman rm "$CONTAINER_ID"
fi

mkdir -p "$CACHE_DIR"

podman run -dit --name "$CONTAINER_ID" \
    -v "$CACHE_DIR:/home/gitlab-runner/cache":Z "$IMAGE" sleep 14400

podman cp --pause=false /usr/bin/gitlab-runner "$CONTAINER_ID":/usr/bin/gitlab-runner
