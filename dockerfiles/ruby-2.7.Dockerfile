FROM ruby:2.7-alpine

RUN apk add --no-cache git

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git
RUN mv $(which git) $CODECRAFTERS_GIT
