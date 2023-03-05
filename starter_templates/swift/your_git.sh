#!/bin/bash
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e
set -o pipefail

packagePath=$(dirname "$0")
# Swift build writes errors to stdout instead of stderr. Let's collect all output in a file and only print if the exit code is zero.
buildOutputFile=$(mktemp)
swift build -c release --package-path "$packagePath" > "$buildOutputFile" || (cat "$buildOutputFile" && exit 1)
exec swift run -c release --skip-build --package-path "$packagePath" swift-git-challenge "$@"
