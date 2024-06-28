# syntax=docker/dockerfile:1.7-labs
FROM haskell:9.4.6-buster

WORKDIR /app

RUN mkdir -p /etc/stack

# Absence of this causes `stack run` to raise a permissions error
RUN echo "allow-different-user: true" >> /etc/stack/config.yaml

# Force usage of the system GHC installation
RUN echo "install-ghc: false" >> /etc/stack/config.yaml
RUN echo "system-ghc: true" >> /etc/stack/config.yaml

# .git & README.md are unique per-repository. We ignore them on first copy to prevent cache misses
COPY --exclude=.git --exclude=README.md . /app

# Dummy static content to circumvent the /app doesn't exist warning
RUN mkdir /app/src

RUN stack build
RUN stack clean hs-git-clone
RUN cp -r .stack-work /tmp/

RUN rm -rf /app/app
RUN rm -rf /app/src

RUN echo "cd \${CODECRAFTERS_SUBMISSION_DIR} && cp -r /tmp/.stack-work . && stack build" > /codecrafters-precompile.sh
RUN chmod +x /codecrafters-precompile.sh

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="stack.yaml,package.yaml,stack.yaml.lock"

# Once the heave steps are done, we can copy all files back
COPY . /app
