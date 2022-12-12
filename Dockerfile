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
FROM amazoncorretto:19-alpine3.16
COPY --from=build /home/app/target/tasklst-0.0.1.jar /usr/local/lib/tasklist.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tasklist.jar"]
