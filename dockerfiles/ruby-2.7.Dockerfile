FROM ruby:2.7

ENV CODECRAFTERS_GIT=/usr/bin/codecrafters-secret-git

RUN mv $(which git) $CODECRAFTERS_GIT
