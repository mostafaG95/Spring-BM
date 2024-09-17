# Use a Java image to build the application
FROM gradle:7.5.1-jdk11 AS builder

# Set the working directory
WORKDIR /app

# Copy the Gradle build files
COPY . ./


# Build the application
RUN gradle build --no-daemon

# Use a smaller Java image to run the application
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/build/libs/*.jar /app/app.jar

# Expose the port the application will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

