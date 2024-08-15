# syntax=docker/dockerfile:1.7-labs
FROM rust:1.77-buster

WORKDIR /app

RUN apt-get update && \
    apt-get install --no-install-recommends -y git=1:2.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# .git & README.md are unique per-repository. We ignore them on first copy to prevent cache misses
COPY --exclude=.git --exclude=README.md . /app

RUN cargo build --release --target-dir=/tmp/codecrafters-git-target

RUN echo "cd \${CODECRAFTERS_REPOSITORY_DIR} && cargo build --release --target-dir=/tmp/codecrafters-git-target --manifest-path Cargo.toml" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Cargo.toml,Cargo.lock"
