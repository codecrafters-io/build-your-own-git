#!/bin/bash

set -e
(
    cd $(dirname "$0")
    stack build --copy-bins
)
exec hs-git-clone-exe "$@"
