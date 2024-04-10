FROM ruby:3.3-alpine

ENV CODECRAFTERS_DEPENDENCY_FILE_PATHS="Gemfile,Gemfile.lock"

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install --verbose

RUN apk add --no-cache 'git>=2.40'
