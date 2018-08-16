FROM centos:7.5.1804

RUN yum install -y unzip

RUN \
  mkdir -p /opt/sonar/ \
  && curl --location \
          --progress-bar \
          --output /opt/sonar/scanner.zip \
          --url https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip \
  && cd /opt/sonar/ \
  && unzip *.zip \
  && mv ./sonar-scanner* ./scanner \
  && rm -rf scanner.zip

ENV PATH="/opt/sonar/scanner/bin:${PATH}"
ENV PATH="/opt/sonar/scanner/jre/bin:${PATH}"

WORKDIR /src

CMD ["/bin/sh", "-c", "-x", "sonar-scanner ${DEBUG} -Dsonar.projectKey=${PROJECTKEY} -Dsonar.sources=. -Dsonar.host.url=http://sonarqube:9000"]
