FROM rust:1.62-buster

RUN apt-get update && \
    apt-get install --no-install-recommends -y git=1:2.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY Cargo.toml /app/Cargo.toml
COPY Cargo.lock /app/Cargo.lock

RUN mkdir /app/src
RUN echo 'fn main() { println!("Hello World!"); }' > /app/src/main.rs

WORKDIR /app
RUN cargo build --release --target-dir=/tmp/codecrafters-git-target

RUN rm /tmp/codecrafters-git-target/release/git-starter-rust
RUN rm /tmp/codecrafters-git-target/release/git-starter-rust.d

RUN find /tmp/codecrafters-git-target/release -type f -maxdepth 1 -delete
RUN rm -f /tmp/codecrafters-git-target/release/deps/*git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/deps/git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/.fingerprint/*git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/.fingerprint/git_starter_rust*

RUN rm -rf /app/src

RUN echo "cd \${CODECRAFTERS_REPOSITORY_DIR} && cargo build --release --target-dir=/tmp/codecrafters-git-target --manifest-path Cargo.toml" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Cargo.toml,Cargo.lock"
