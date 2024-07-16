#!/bin/sh
#
# This script is used to compile your program on CodeCrafters
#
# This runs before .codecrafters/run.sh
#
# Learn more: https://codecrafters.io/program-interface

set -e # Exit on failure

# TODO: Figure out compile vs. run path?
cargo build --release --target-dir=/tmp/codecrafters-git-target --manifest-path Cargo.toml
