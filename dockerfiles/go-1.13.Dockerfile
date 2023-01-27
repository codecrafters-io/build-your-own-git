FROM golang:1.13

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git

RUN mv $(which git) $CODECRAFTERS_GIT
