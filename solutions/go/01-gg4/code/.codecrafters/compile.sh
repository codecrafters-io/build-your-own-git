#!/bin/sh
#
# This script is used to compile your program on CodeCrafters
#
# This runs before .codecrafters/run.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

go build -buildvcs="false" -o /tmp/codecrafters-build-git-go ./cmd/mygit
