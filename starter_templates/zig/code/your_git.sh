#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e

tmp_dir=$(mktemp -d)

( cd $(dirname "$0") && zig build -p $tmp_dir)

exec "$tmp_dir/bin/zit" "$@"
