#!/bin/sh
#
# This script is used to compile your program on CodeCrafters
#
# This runs before .codecrafters/run.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

# TODO: Figure out directory path options?
mvn -B package -Ddir=/tmp/codecrafters-build-git-java
