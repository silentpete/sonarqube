#!/bin/bash

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t sonarqube_scanner ${CWD}/.
