FROM maven:3.9.2-amazoncorretto-20 as builder
ARG VERSION=0.0.1-SNAPSHOT
WORKDIR /build/
COPY pom.xml .
COPY src/ ./src/

RUN mvn clean package

RUN cp ./target/booting-web-${VERSION}.jar target/application.jar

FROM amazoncorretto:20-alpine

WORKDIR /app/
COPY --from=builder /build/target/application.jar /app/

EXPOSE 9000

#CMD java -jar -Dspring.profiles.active=docker /app/application.jar
CMD java -jar /app/application.jar
