# ======= Build stage =======
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ======= Run stage =======
FROM amazoncorretto:17-alpine-jdk
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]