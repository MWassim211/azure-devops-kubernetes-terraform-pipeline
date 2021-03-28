FROM maven:3.6.3-jdk-8-slim AS build
WORKDIR /home/app
COPY ./ /home/
RUN ls
RUN mvn clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8000
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
