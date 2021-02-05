#!/usr/bin/env bash

TMPDIR=$(pwd)

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${currentDir}"/base.sh

podman kill "$CONTAINER_ID"
podman rm "$CONTAINER_ID"
podman system prune --force --volumes

rm -rfv "$TMPDIR"
