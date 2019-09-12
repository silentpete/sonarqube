FROM centos:7.6.1810

RUN yum install -y unzip

# to be able to scan CSS code, need node.js
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -

RUN yum install -y nodejs

RUN \
  mkdir -p /opt/sonar/ \
  && curl --location \
          --progress-bar \
          --output /opt/sonar/scanner.zip \
          --url https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.1.0.1829-linux.zip \
  && cd /opt/sonar/ \
  && unzip *.zip \
  && mv ./sonar-scanner* ./scanner \
  && rm -rf scanner.zip

ENV PATH="/opt/sonar/scanner/bin:${PATH}"
ENV PATH="/opt/sonar/scanner/jre/bin:${PATH}"

WORKDIR /src

ENTRYPOINT [ "sonar-scanner" ]
