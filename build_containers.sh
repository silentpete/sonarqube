#!/bin/sh

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run all build.sh files
for VAR in $(find ${CWD} -type f -name "build.sh"); do echo "building ${VAR}"; ${VAR}; done;
