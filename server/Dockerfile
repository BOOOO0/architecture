# 빌드 단계 (Gradle 빌드, 로컬 환경 `local` 프로필 적용)
FROM openjdk:17-jdk-slim AS builder
WORKDIR /app

# 프로젝트 전체 복사
COPY . .

# Gradle 실행 권한 부여
RUN chmod +x gradlew

# Gradle 빌드 (로컬 환경 `local` 프로필 적용)
RUN ./gradlew clean build -Dspring.profiles.active=local

# 실행 단계 (최종 이미지, 쿠버네티스 환경 `k8s` 프로필 적용)
FROM openjdk:17-jdk-slim
WORKDIR /app

# 빌드된 JAR 복사
COPY --from=builder /app/build/libs/server-0.0.1-SNAPSHOT.jar ./server.jar

# 실행 시 `k8s` 프로필 적용
ENTRYPOINT ["java", "-jar", "server.jar", "--spring.profiles.active=k8s"]
