#!/bin/bash
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e

pushd .
cd $(dirname "$0")
stack build
popd

exec /app/.stack-work/dist/x86_64-linux/Cabal-3.8.1.0/build/hs-git-clone-exe/hs-git-clone-exe "$@"
