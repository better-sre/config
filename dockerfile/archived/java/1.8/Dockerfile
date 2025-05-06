#
# ref:
#   - https://github.com/cpayret-KDM/KDM_API/blob/master/backend/Dockerfile
#   - https://github.com/chanjarster/dockerfile-examples
#     - https://chanjarster.github.io/post/java-dockerfile-best-practice/
#

# build jar:
FROM maven:3.8.3-adoptopenjdk-8 AS maven_build
# FROM maven:3.6.3-adoptopenjdk-15  as maven_build

# dir:
WORKDIR /build/

# code:
COPY pom.xml /build/
COPY src /build/src/

# build:
RUN mvn clean package

#
# run:
#

# run with:
FROM openjdk:8-jdk-alpine

VOLUME /tmp

ARG VERSION

LABEL version=${VERSION}
LABEL description="Spring Boot Application"

EXPOSE 8080

ENV JAVA_OPTS ""

# dir:
WORKDIR /app

# copy:
COPY --from=maven_build /build/target/*.jar /app/app.jar

# exec:
ENTRYPOINT /usr/bin/java ${JAVA_OPTS} -jar /app/app.jar

