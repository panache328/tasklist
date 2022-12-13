#
# Build stage
#
FROM maven:3.8.6-amazoncorretto-19 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM amazoncorretto:19-alpine-jdk
ENV DATASOURCE_USERNAME=${DATABASE_USERNAME}
ENV DATASOURCE_PASSWORD=${DATABASE_PASSWORD}
COPY --from=build /home/app/target/*.jar /usr/local/lib/*.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/*.jar"]
