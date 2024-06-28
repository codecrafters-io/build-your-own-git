# syntax=docker/dockerfile:1.7-labs
FROM rust:1.70-buster

RUN apt-get update && \
    apt-get install --no-install-recommends -y git=1:2.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir /app/src
RUN echo 'fn main() { println!("Hello World!"); }' > /app/src/main.rs

WORKDIR /app
# .git & README.md are unique per-repository. We ignore them on first copy to prevent cache misses
COPY --exclude=.git --exclude=README.md . /app
RUN cargo build --release --target-dir=/tmp/codecrafters-git-target

RUN rm /tmp/codecrafters-git-target/release/git-starter-rust
RUN rm /tmp/codecrafters-git-target/release/git-starter-rust.d

RUN find /tmp/codecrafters-git-target/release -type f -maxdepth 1 -delete
RUN rm -f /tmp/codecrafters-git-target/release/deps/*git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/deps/git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/.fingerprint/*git_starter_rust*
RUN rm -f /tmp/codecrafters-git-target/release/.fingerprint/git_starter_rust*

RUN rm -rf /app/src

RUN echo "cd \${CODECRAFTERS_SUBMISSION_DIR} && cargo build --release --target-dir=/tmp/codecrafters-git-target --manifest-path Cargo.toml" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Cargo.toml,Cargo.lock"


# Once the heave steps are done, we can copy all files back
COPY . /app
