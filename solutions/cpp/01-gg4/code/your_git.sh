#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
set -e
# vcpkg & cmake are required. 
cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake
cmake --build ./build

# Check if CODECRAFTERS_SUBMISSION_DIR is set, otherwise set it to "."
if [ -z "${CODECRAFTERS_SUBMISSION_DIR}" ]; then
    CODECRAFTERS_SUBMISSION_DIR="."
fi

exec ${CODECRAFTERS_SUBMISSION_DIR}/build/server "$@"