# Stage 1: build
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /app

# Copy pom first so dependencies are cached unless pom.xml changes
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Copy source and build the jar
COPY src src
RUN mvn -B clean package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:21-jre
WORKDIR /app

# finalName in your pom.xml is jobportal-aws-deployment
COPY --from=builder /app/target/jobportal-aws-deployment.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
