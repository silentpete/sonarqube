# sonarqube - check my code

After seeing SonarQube demo'd at last nights COS Open Source Software Meetup, I was interested in seeing how it worked.

I had the idea:

- can I get it to run locally in docker?
- can I scan my code in any folder?
- golang?
- throw away?

## SonarQube

Dockerhub hosts a sonarqube container. This container is the 'server'. So scanners are used to send their scan results to the server. The server can then display the results after applying the Quality Profiles.

[https://docs.sonarqube.org/display/SONAR](https://docs.sonarqube.org/display/SONAR)

## plugins

[https://docs.sonarqube.org/display/PLUG](https://docs.sonarqube.org/display/PLUG)

### installing a plugin

[https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin](https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin)

### go plugin

The default comes with a bunch of plugins, but not Go. So I created a Dockerfile FROM their starting point and add in my desired plugin.

[https://docs.sonarqube.org/display/PLUG/SonarGo](https://docs.sonarqube.org/display/PLUG/SonarGo)

## scanner

[https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner)

## Usage

```none
./build-containers.sh
```

```none
docker-compose up -d
```

From a directory with code...

```none
docker run -dt --rm --name=sonarscanner -e PROJECTKEY="${PWD##*/}" -v $PWD/:/scan/my/code/ --network=sonarqube_lan sonarqube_scanner:latest; docker logs -f sonarscanner
```

Navigate to `http://localhost:9000`

## Additional References

- [https://hub.docker.com/_/sonarqube/](https://hub.docker.com/_/sonarqube/)
- [https://github.com/SonarSource/docker-sonarqube](https://github.com/SonarSource/docker-sonarqube)
- [https://hub.docker.com/_/postgres/](https://hub.docker.com/_/postgres/)
- [https://hub.docker.com/r/_/centos/](https://hub.docker.com/r/_/centos/)
