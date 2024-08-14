FROM gcc:12.2.0-bullseye

RUN apt-get update && \
    apt-get install --no-install-recommends -y cmake=3.18.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# TODO: Clean this up when we move to CPP23
RUN printf "cd \${CODECRAFTERS_REPOSITORY_DIR} && cmake . && make && (echo '#!/bin/sh\nexec \${CODECRAFTERS_REPOSITORY_DIR}/server \"\$@\"' > your_git.sh) && chmod +x your_git.sh" > /codecrafters-precompile.sh
