FROM zenika/kotlin:1.4.20-jdk11-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y git=1:2.* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
