FROM centos:7.4.1708

# RUN \
#   yum makecache \
#   && yum install -y epel-release \
#   && yum install -y java-1.8.0-openjdk

# RUN yum install -y golang

RUN yum install -y unzip

RUN \
  mkdir -p /opt/sonar/ \
  && curl -L --progress-bar -o /opt/sonar/scanner.zip https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.1.0.1141-linux.zip \
  && cd /opt/sonar/ \
  && unzip *.zip \
  && mv ./sonar-scanner* ./scanner \
  && rm -rf scanner.zip

ENV PATH="/opt/sonar/scanner/bin:${PATH}"
ENV PATH="/opt/sonar/scanner/jre/bin:${PATH}"

WORKDIR /src

CMD ["/bin/sh", "-c", "-x", "sonar-scanner -Dsonar.projectKey=${PROJECTKEY} -Dsonar.sources=. -Dsonar.host.url=http://sonarqube:9000"]
