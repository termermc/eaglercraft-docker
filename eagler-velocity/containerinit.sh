#!/usr/bin/env sh

set -e

cd /data/

mkdir -p cache
if [ ! -f ./cache/eagler_skins_cache.db ]; then
	touch ./cache/eagler_skins_cache.db
fi
ln -s /data/cache/eagler_skins_cache.db /data/ || true

mkdir -p secrets
if [ ! -f ./secrets/forwarding.secret ]; then
	cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > ./secrets/forwarding.secret
fi
ln -s /data/secrets/forwarding.secret /data/ || true

mkdir -p plugins
for FILE in /data/coreplugins/*; do
	ln -s "$FILE" /data/plugins/ || true
done

#ln -s /data/coreplugins/bStats /data/plugins/bStats || true
#ln -s /data/coreplugins/EaglerMOTD.jar /data/plugins/ || true
#ln -s /data/coreplugins/EaglerWeb.jar /data/plugins/ || true
#ln -s /data/coreplugins/EaglerXRewind.jar /data/plugins/ || true
#ln -s /data/coreplugins/EaglerXServer.jar /data/plugins/ || true
