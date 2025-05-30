#FROM docker.io/amazoncorretto:17-alpine3.21-full AS builder
FROM docker.io/amazoncorretto:17-al2-full AS builder

#RUN apk add git
RUN ["yum", "install", "-y", "git"]

WORKDIR /data/

RUN ["git", "clone", "--recursive", "https://github.com/lax1dude/eaglerxserver.git", "src"]

WORKDIR /data/src/

# Set options and download Gradle.
ENV GRADLE_OPTS="-Dorg.gradle.daemon=false -Djava.net.preferIPv4Stack=true"
RUN ["chmod", "+x", "gradlew"]
RUN ["./gradlew"]

# Compile.
RUN ["chmod", "+x", "build_all.sh"]
RUN ["./build_all.sh"]

RUN ["mkdir", "jars"]
RUN ["sh", "-c", "mv *.jar jars"]

FROM docker.io/alpine:3.21.3

WORKDIR /data/

COPY --from=builder /data/src/jars .

ENTRYPOINT ["sh", "-c", "mkdir -p jars && cp *.jar jars"]
