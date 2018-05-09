#!/bin/sh

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

curl -L -k -o ${CWD}/plugins/sonar-go-plugin-1.0.0.1404.jar https://repox.sonarsource.com/sonarsource/org/sonarsource/go/sonar-go-plugin/1.0.0.1404/sonar-go-plugin-1.0.0.1404.jar

docker build -t sonarqube ${CWD}/.
