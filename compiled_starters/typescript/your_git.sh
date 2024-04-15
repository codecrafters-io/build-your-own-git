#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
cd $(dirname "$0")
deno cache app/main.ts
exec deno run --allow-net --allow-read --allow-write app/main.ts "$@"
