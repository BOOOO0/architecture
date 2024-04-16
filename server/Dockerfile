FROM openjdk:17-jdk-slim AS builder
COPY . .
RUN ./gradlew build




FROM openjdk:17-jdk-slim
WORKDIR '/app'
COPY --from builder /app/build/libs/server-0.0.1-SNAPSHOT.jar ./server.jar
ENTRYPOINT ["java", "-jar", "server.jar"]