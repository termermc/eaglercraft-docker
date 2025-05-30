#!/usr/bin/env bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

if [ "$DOCKER_CMD" = "" ]; then
	DOCKER_CMD="docker"
fi

echo "Building eaglerxserver..."
cd ../eaglerxserver
$DOCKER_CMD build -t ghcr.io/termermc/eaglerxserver:latest .

cd "$SCRIPT_DIR"
echo "Downloading Velocity..."
$DOCKER_CMD build -t ghcr.io/termermc/eagler-velocity:latest .
