FROM python:3.13-alpine

# Remove git executable to prevent test solutions from using the git executable
RUN apk del git