# syntax = docker/dockerfile:1.2

#
# Build stage
#
FROM maven:3.8.6-amazoncorretto-19 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN --mount=type=secret,id=_env,dst=/etc/secrets/.env mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM amazoncorretto:19-alpine-jdk
COPY --from=build /home/app/target/*.jar /usr/local/lib/*.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/*.jar"]
