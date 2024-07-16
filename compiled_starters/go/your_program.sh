#!/bin/sh
#
# Use this script to run your program LOCALLY.
#
# Note: Changing this script WILL NOT affect how CodeCrafters runs your program.
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit early if any commands fail

# This allows running your_program.sh from outside the repository directory
CODECRAFTERS_REPOSITORY_DIR="$(dirname "$0")"
export CODECRAFTERS_REPOSITORY_DIR

# Copied from .codecrafters/compile.sh
#
# - Edit this to change how your program compiles locally
# - Edit .codecrafters/compile.sh to change how your program compiles remotely
(
    cd "$CODECRAFTERS_REPOSITORY_DIR" # cd only affects the subshell
    go build -buildvcs="false" -o /tmp/codecrafters-build-git-go ./cmd/mygit
)

# Copied from .codecrafters/run.sh
#
# - Edit this to change how your program runs locally
# - Edit .codecrafters/run.sh to change how your program runs remotely
exec /tmp/codecrafters-build-git-go "$@"
