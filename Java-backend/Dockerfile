# Use the official Maven image to create a build artifact.
# The install stage will copy the project source into the Maven container and run the build
FROM maven:3.8.4-openjdk-11 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

# Use the official OpenJDK image to run the Spring Boot application
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/demo-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]