# SonarQube - check my local code

After seeing SonarQube demo'd by Bill Lyons at last nights (20180507) COS Open Source Software Meetup, I was interested in seeing how it worked.

I had the idea:

- can I get it to run locally in docker?
- can I scan my code in any folder?
- golang?
- throw away?

## SonarQube

Dockerhub hosts a sonarqube container. This container is the 'server'. So scanners are used to send their scan results to the server. The server can then display the results after applying the Quality Profiles.

[https://docs.sonarqube.org/latest/](https://docs.sonarqube.org/latest/)

## Plugins

[https://docs.sonarqube.org/latest/analysis/languages/overview/](https://docs.sonarqube.org/latest/analysis/languages/overview/)

Default Plugins:

- C#
- CSS
- Flex
- Go
- Java
- JavaScript
- Kotlin
- PHP
- Python
- Ruby
- Scala
- TypeScript
- Visual Basic
- HTML
- XML

[https://docs.sonarqube.org/latest/setup/install-plugin/](https://docs.sonarqube.org/latest/setup/install-plugin/)

### Installing a plugin

[https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin](https://docs.sonarqube.org/display/SONAR/Installing+a+Plugin)

## Scanner

[https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)

## Usage

Build containers needed locally.

```none
./build_containers.sh
```

Start the local stack.

```none
docker-compose up -d
```

From any directory with code...

```none
docker run -dt --rm --name=sonarscanner -v $PWD/:/src/ --network=sonarqube_lan --log-driver=json-file sonarqube_scanner:latest -Dsonar.projectKey=${PWD##*/} -Dsonar.sources=. -Dsonar.host.url=http://sonarqube:9000; docker logs -f sonarscanner
```

For SonarQube extra debugging, run with the following:

```none
docker run -dt --rm --name=sonarscanner -v $PWD/:/src/ --network=sonarqube_lan --log-driver=json-file sonarqube_scanner:latest --debug -Dsonar.projectKey=${PWD##*/} -Dsonar.sources=. -Dsonar.host.url=http://sonarqube:9000; docker logs -f sonarscanner
```

Navigate to `http://localhost:9000`

### Get Go test coverage

Sonarqube doesn't run the test, it looks at a coverage file that was pre-staged.

Once the coverage files are created, we need to tell the scanner about the file.

Reference

- [https://docs.sonarqube.org/latest/analysis/coverage/](https://docs.sonarqube.org/latest/analysis/coverage/)
- [https://docs.sonarqube.org/latest/analysis/languages/go/](https://docs.sonarqube.org/latest/analysis/languages/go/)

```none
go test ./... -coverprofile=coverage.out
```

Tell the scanner about the Go coverage file.

```none
docker run -dt --rm --name=sonarscanner -v $PWD/:/src/ --network=sonarqube_lan --log-driver=json-file sonarqube_scanner:latest -Dsonar.projectKey=${PWD##*/} -Dsonar.sources=. -Dsonar.host.url=http://sonarqube:9000 -Dsonar.go.coverage.reportPaths=./coverage.out -Dsonar.exclusions=**/*_test.go,**/vendor/** -Dsonar.tests=. -Dsonar.test.inclusions=**/*_test.go -Dsonar.test.exclusions=**/vendor/**; docker logs -f sonarscanner
```

### Gradle Builds

Once the SonarQube localstack is up and running. Gradle builds can be run and their output sent to the server.

#### Requirements

Add the following in your `build.gradle` file.

```none
plugins {
  id "org.sonarqube" version "2.6.2"
}
```

Then run the following:

```none
./gradlew sonarqube -Dsonar.host.url=http://localhost:9000
```

### Maven Builds

```none
mvn sonar:sonar -Dsonar.host.url=http://localhost:9000
```

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
