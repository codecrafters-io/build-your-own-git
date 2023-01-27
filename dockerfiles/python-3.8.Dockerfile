FROM jfloff/alpine-python:3.8

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git

RUN mv $(which git) $CODECRAFTERS_GIT
