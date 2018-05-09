# SonarQube - check my local code

After seeing SonarQube demo'd at last nights (20180507) COS Open Source Software Meetup, I was interested in seeing how it worked.

I had the idea:

- can I get it to run locally in docker?
- can I scan my code in any folder?
- golang?
- throw away?

## SonarQube

Dockerhub hosts a sonarqube container. This container is the 'server'. So scanners are used to send their scan results to the server. The server can then display the results after applying the Quality Profiles.

[https://docs.sonarqube.org/display/SONAR](https://docs.sonarqube.org/display/SONAR)

## Plugins

Default Plugins:

- Git
- SonarC#
- SonarFlex
- SonarJS
- SonarJava
- SonarPHP
- SonarPython
- SonarTS
- SonarXML
- Svn

[https://docs.sonarqube.org/display/PLUG](https://docs.sonarqube.org/display/PLUG)

### Installing a plugin

[https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin](https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin)

### Go plugin

The default comes with a bunch of plugins, but not Go. So I created a Dockerfile FROM their starting point and add in my desired plugin.

[https://docs.sonarqube.org/display/PLUG/SonarGo](https://docs.sonarqube.org/display/PLUG/SonarGo)

## Scanner

[https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner](https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner)

## Usage

Build containers needed locally.

```none
./build-containers.sh
```

Start the local stack.

```none
docker-compose up -d
```

From any directory with code...

```none
docker run -dt --rm --name=sonarscanner -e PROJECTKEY="${PWD##*/}" -v $PWD/:/src/ --network=sonarqube_lan --log-driver=json-file sonarqube_scanner:latest; docker logs -f sonarscanner
```

Navigate to `http://localhost:9000`

## Conclusion

`can I get it to run locally in docker?` Simple answer is **yes**.

`can I scan my code in any folder?` This took a little effort getting the docker run line correct, but **yes**, you can run this on any folder, just map it into the scanner.

`golang?` **yes**

`throw away?` **yes**, docker-compose down then system prune

## Additional References

- [https://hub.docker.com/_/sonarqube/](https://hub.docker.com/_/sonarqube/)
- [https://github.com/SonarSource/docker-sonarqube](https://github.com/SonarSource/docker-sonarqube)
- [https://hub.docker.com/_/postgres/](https://hub.docker.com/_/postgres/)
- [https://hub.docker.com/r/_/centos/](https://hub.docker.com/r/_/centos/)
