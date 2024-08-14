# syntax=docker/dockerfile:1.7-labs
FROM alpine:3.20

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --no-cache zig@community=0.12.0-r0

WORKDIR /app

# .git & README.md are unique per-repository. We ignore them on first copy to prevent cache misses
COPY --exclude=.git --exclude=README.md . /app

RUN zig build

RUN printf "set -e \ncd \${CODECRAFTERS_REPOSITORY_DIR} \necho 'Running zig build' \nzig build \necho 'zig build completed.' \n" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh
