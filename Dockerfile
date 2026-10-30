FROM eclipse-temurin:21
LABEL "org.opencontainers.image.authors"="spy"
COPY target/jobportal-aws-deployment.jar jobportal-aws-deployment.jar
ENTRYPOINT ["java", "-jar", "jobportal-aws-deployment.jar"]
