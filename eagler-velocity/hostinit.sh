#!/usr/bin/env sh

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

mkdir -p plugins
chmod -R 777 plugins

if [ ! -f velocity.toml ]; then
	cp velocity.example.toml velocity.toml
fi
chmod 755 velocity.toml

if [ ! -f server-icon.png ]; then
	cp server-icon.example.png server-icon.png
fi
chmod 755 server-icon.png

if [ ! -f compose.toml ]; then
	cp compose.example.yml compose.yml
fi
