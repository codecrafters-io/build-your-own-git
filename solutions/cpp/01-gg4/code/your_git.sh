#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e
cmake $(dirname $0) > /dev/null
make > /dev/null
exec ./server "$@"