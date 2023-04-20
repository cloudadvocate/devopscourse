FROM amazoncorretto:11.0.18-al2023

COPY book-manager-app/target/bookmanager-1.0.0-SNAPSHOT.jar /app/

RUN ls -latr /app

WORKDIR /app

CMD [ "java", "-jar", "bookmanager-1.0.0-SNAPSHOT.jar" ]
