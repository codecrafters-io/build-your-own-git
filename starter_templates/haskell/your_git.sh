#!/bin/bash
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!

set -e
(
    cd $(dirname "$0")
    stack build --copy-bins
)
exec hs-git-clone-exe "$@"
