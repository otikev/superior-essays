FROM gradle:7.4-jdk11
MAINTAINER  Kevin Otieno <oti.kevin@gmail.com>
RUN mkdir /project
COPY . /project
WORKDIR /project
RUN gradle build
CMD ["java", "-jar", "build/libs/SECrawler-1.0-SNAPSHOT.jar"]