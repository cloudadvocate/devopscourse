FROM amazoncorretto:11.0.18-al2023

COPY bookmanager.jar /app/

RUN ls -latr /app

WORKDIR /app

CMD [ "java", "-jar", "bookmanager.jar" ]
