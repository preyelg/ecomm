#Use OpenJDK base image
FROM openjdk:17-jdk-slim

#Set work directory
WORKDIR /app

#Copy the built jar from Maven target
COPY target/ecommerce-1.0.0.jar app.jar

#Expose the port your app runs on
EXPOSE 9090

#Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]