#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
deno cache /app/app/main.ts
exec deno run --allow-net --allow-read --allow-write /app/app/main.ts "$@"
