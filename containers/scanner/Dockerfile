FROM centos:7.4.1708

RUN yum install -y epel-release

RUN yum install -y unzip golang java-1.8.0-openjdk

RUN \
  mkdir -p /opt/sonar/scanner \
  && curl -L -k -o /opt/sonar/scanner.zip https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.1.0.1141-linux.zip \
  && cd /opt/sonar/ \
  && unzip *.zip \
  && mv ./sonar-scanner*/* ./scanner/

CMD ["/bin/sh", "-c", "-x", "/opt/sonar/scanner/bin/sonar-scanner -Dsonar.projectKey=${PROJECTKEY} -Dsonar.sources=/scan/my/code/ -Dsonar.host.url=http://sonarqube:9000"]
