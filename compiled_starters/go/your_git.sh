#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e

tmpFile=$(mktemp)

( cd $(dirname "$0") &&
	go build -buildvcs="false" -o "$tmpFile" ./cmd/mygit )

exec "$tmpFile" "$@"
