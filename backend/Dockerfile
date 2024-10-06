# Use the official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire project to the container
COPY . .

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Use the official OpenJDK JRE image for the runtime
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Spring Boot application jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port that the Spring Boot application runs on
EXPOSE 8080

# Optionally set JAVA_OPTS environment variable
# ENV JAVA_OPTS=""

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
