#!/usr/bin/env bash

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${currentDir}"/base.sh

if ! podman exec -i "$CONTAINER_ID" /bin/bash < "$1"; then
    exit "$BUILD_FAILURE_EXIT_CODE"
fi
