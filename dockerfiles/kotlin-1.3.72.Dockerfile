FROM zenika/kotlin:1.3.72-jdk11

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git

RUN mv $(which git) $CODECRAFTERS_GIT
