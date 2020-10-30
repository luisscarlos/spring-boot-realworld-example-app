FROM gradle:6.6.1-jdk11-hotspot

WORKDIR /home/gradle/project

EXPOSE 8080

USER root

# RUN apk update

ENV GRADLE_USER_HOME /home/gradle/project

COPY . /home/gradle/project

RUN gradle build -x test

FROM java:jre-alpine

WORKDIR /home/gradle/project

COPY --from=0 /home/gradle/project/build/libs/project-0.0.1-SNAPSHOT.jar .

ENTRYPOINT java -jar project-0.0.1-SNAPSHOT.jar
