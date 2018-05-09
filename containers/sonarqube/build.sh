#!/bin/sh

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

plugins_dir="${CWD}/plugins"

plugins_by_address+=('https://repox.sonarsource.com/sonarsource/org/sonarsource/go/sonar-go-plugin/1.0.0.1404/sonar-go-plugin-1.0.0.1404.jar')

if [[ ! -d "${plugins_dir}" ]]; then
  echo -e "Creating: ${plugins_dir}"
  mkdir "${plugins_dir}"
fi

for addr in ${plugins_by_address[@]}; do
  jar_name="${addr##*/}"
  if [[ -f "${plugins_dir}/${jar_name}" ]]; then
    echo -e "${jar_name} already in plugin directory"
  else
    echo -e "downloading: ${jar_name}"
    curl --location --insecure --progress-bar --output "${plugins_dir}/${jar_name}" "${addr}"
  fi
done

docker build -t sonarqube ${CWD}/.
