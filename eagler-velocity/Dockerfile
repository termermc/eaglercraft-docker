FROM ghcr.io/termermc/eaglerxserver:latest AS eag

FROM docker.io/alpine:3.21.3 AS downloader

RUN ["apk", "add", "jq"]

WORKDIR /data/

# Resolve latest build and download link.
RUN ["sh", "-c", "wget -q -O- https://api.papermc.io/v2/projects/velocity | jq -r '.versions | last' > ver.txt"]
RUN ["sh", "-c", "wget -q -O- https://api.papermc.io/v2/projects/velocity/versions/$( cat ver.txt )/builds | jq '.builds | last' > build.json"]
RUN ["sh", "-c", "cat build.json | jq -r '.build' > build_ver.txt"]
RUN ["sh", "-c", "cat build.json | jq -r .downloads.application.name > filename.txt"]

RUN ["sh", "-c", "wget https://api.papermc.io/v2/projects/velocity/versions/$( cat ver.txt )/builds/$( cat build_ver.txt )/downloads/$( cat filename.txt )"]
RUN ["sh", "-c", "printf \"#!/usr/bin/env sh\nset -e\n./containerinit.sh\njava -jar -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 $( cat filename.txt )\n\" > start.sh"]
RUN ["chmod", "+x", "start.sh"]

WORKDIR /data/coreplugins/

# Download ViaVersion and related plugins.
RUN ["sh", "-c", "wget $( wget -q -O- 'https://hangar.papermc.io/api/v1/projects/ViaVersion/versions?limit=1&offset=0&channel=Release&channel=Snapshot&platform=PAPER&platform=WATERFALL&platform=VELOCITY&includeHiddenChannels=true' | jq -r .result[0].downloads.VELOCITY.downloadUrl )"]
RUN ["sh", "-c", "wget $( wget -q -O- 'https://hangar.papermc.io/api/v1/projects/ViaBackwards/versions?limit=1&offset=0&channel=Release&channel=Snapshot&platform=PAPER&platform=WATERFALL&platform=VELOCITY&includeHiddenChannels=true' | jq -r .result[0].downloads.VELOCITY.downloadUrl )"]
RUN ["sh", "-c", "wget $( wget -q -O- 'https://hangar.papermc.io/api/v1/projects/ViaRewind/versions?limit=1&offset=0&channel=Release&channel=Snapshot&platform=PAPER&platform=WATERFALL&platform=VELOCITY&includeHiddenChannels=true' | jq -r .result[0].downloads.VELOCITY.downloadUrl )"]
RUN ["sh", "-c", "wget $( wget -q -O- 'https://hangar.papermc.io/api/v1/projects/SkinsRestorer/versions?limit=1&offset=0&channel=Release&channel=Snapshot&platform=PAPER&platform=WATERFALL&platform=VELOCITY&includeHiddenChannels=true' | jq -r .result[0].downloads.PAPER.downloadUrl )"]

FROM docker.io/amazoncorretto:17-al2-full

WORKDIR /data/
COPY --from=downloader /data/ .
COPY containerinit.sh .
RUN ["chmod", "+x", "containerinit.sh"]

WORKDIR /data/coreplugins/bStats
RUN ["sh", "-c", "echo 'enabled=false' > config.txt"]

WORKDIR /data/coreplugins

COPY --from=eag /data/EaglerMOTD.jar .
COPY --from=eag /data/EaglerWeb.jar .
COPY --from=eag /data/EaglerXRewind.jar .
COPY --from=eag /data/EaglerXServer.jar .

WORKDIR /data/

ENTRYPOINT ["./start.sh"]
