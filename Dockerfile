FROM maven
WORKDIR /usr/src/app
COPY . .
RUN mvn clean install -Dmaven.test.skip=true

FROM nimbleplatform/nimble-base
MAINTAINER Salzburg Research <nimble-srfg@salzburgresearch.at>

# copy resource folder
COPY src/main/resources /resources
RUN ls /resources
VOLUME /tmp
COPY --from=0 /usr/src/app/target/epcis.jar ./
ENV JAR=/usr/src/app/epcis.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar", "/epcis.jar"]
