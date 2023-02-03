FROM zenika/kotlin:1.3.72-jdk11-slim

RUN apt update && \
	apt install --no-install-recommends --yes git && \
	rm -r /var/lib/apt/lists/

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git
RUN mv $(which git) $CODECRAFTERS_GIT
